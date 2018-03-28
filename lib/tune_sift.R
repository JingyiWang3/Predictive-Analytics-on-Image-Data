###install library
library("matrix")
library("xgboost")

###read data
train = read.csv("SIFT_train.csv",header = FALSE,as.is = TRUE)
train$V1 = read.csv("label_train.csv",header = TRUE,as.is = TRUE)$label -1 
set.seed(1234)

train_ind = sample(1:nrow(train),0.7*nrow(train) )
test_ind = seq(1:nrow(train))[-train_ind]

#covert data to matrix
train_matrix <- xgb.DMatrix(data=data.matrix(train[train_ind,-1]),label=train$V1[train_ind])




### Step 1: Tune max_depth and min_child_weight
max_depth<-seq(4,9,2) 
min_child_weight <- seq(1,6,2)
stat_matrix = matrix(NA,nrow = length(max_depth), length(min_child_weight))

for (i in 1:length(max_depth)){
  for (j in 1:length(min_child_weight)){
    my.params <- list(max_depth = max_depth[i], min_child_weight = min_child_weight[j])
    cv.output <- xgb.cv(data=train_matrix, 
                        params=my.params, 
                        eta = 0.3,
                        nrounds = 100, 
                        gamma = 0, 
                        subsample = 1, #0.5-1
                        metrics = "merror",  #merror?
                        objective = "multi:softprob", 
                        num_class = 3,
                        seed = 1234,
                        nfold = 5,  #10
                        nthread = 4, #early_stopping_rounds = 5, 
                        verbose = 0,
                        maximize = F, 
                        prediction = T)
    
    cv_err = min(cv.output$evaluation_log$test_merror_mean)
    print(cv_err)
    stat_matrix[i,j] = cv_err
    
  }}


###Step 2: Tune gamma    
gamma <-  seq(0,0.5,0.1)
stat_matrix_2 = matrix(NA, nrow = length(gamma),ncol = 1)

for (i in 1:length(gamma)){
  cv.output.2 <- xgb.cv(data=train_matrix, 
                        max_depth = 5,
                        min_child_weight = 3,
                        gamma = gamma[i], 
                        eta = 0.3,
                        nrounds = 100, 
                        gamma = gamma[i], 
                        subsample = 1, #0.5-1
                        metrics = "merror",  #merror?
                        objective = "multi:softprob", 
                        num_class = 3,
                        seed = 1234,
                        nfold = 5,  #10
                        nthread = 4, #early_stopping_rounds = 5, 
                        verbose = 0,
                        maximize = F, 
                        prediction = T)
  cv_err = min(cv.output.2$evaluation_log$test_merror_mean)
  print(cv_err)
  stat_matrix_2[i,1] = cv_err
  
}
save(cv.output.2, file = "cv2.rda")


gamma[which(stat_matrix_2 == min(stat_matrix_2), arr.ind = TRUE)] 
#best gamma 0



###Step 3: Tune subsample and colsample_bytree
subsample = seq(0.6,1,by = 0.1)

stat_matrix_3 = matrix(NA, nrow = length(subsample),ncol = 1)

for (i in 1:length(subsample)){
  cv.output.3 <- xgb.cv(data=train_matrix, 
                        max_depth = 5,
                        min_child_weight = 3,
                        # params=my.params, 
                        eta = 0.3,
                        nrounds = 100, 
                        gamma = 0, 
                        subsample = subsample[i], #0.5-1
                        metrics = "merror",  #merror?
                        objective = "multi:softprob", 
                        num_class = 3,
                        seed = 1234,
                        nfold = 5,  #10
                        nthread = 4, #early_stopping_rounds = 5, 
                        verbose = 0,
                        maximize = F, 
                        prediction = T)
  cv_err = min(cv.output.3$evaluation_log$test_merror_mean)
  print(cv_err)
  stat_matrix_3[i,1] = cv_err
  
}

subsample[which(stat_matrix_3 == min(stat_matrix_3), arr.ind = TRUE)]

#best subsample 0.6

###Step 4: Tuning Regularization Parameters

lambda = c(0, 0.001, 0.005, 0.01, 0.05)


stat_matrix_4 = matrix(NA, nrow = length(lambda),ncol = 1)

for (i in 1:length(lambda)){
  cv.output.4 <- xgb.cv(data=train_matrix, 
                        max_depth = 5,
                        min_child_weight = 3,
                        # params=my.params, 
                        eta = 0.3,
                        nrounds = 100, 
                        gamma = 0, 
                        subsample = 0.6, #0.5-1
                        metrics = "merror",  #merror?
                        objective = "multi:softprob", 
                        num_class = 3,
                        seed = 1234,
                        nfold = 5,  #10
                        nthread = 4, #early_stopping_rounds = 5, 
                        verbose = 0,
                        lambda = lambda[i],
                        maximize = F, 
                        prediction = T)
  cv_err = min(cv.output.4$evaluation_log$test_merror_mean)
  print(cv_err)
  stat_matrix_4[i,1] = cv_err
  
}

lambda[which(stat_matrix_4 == min(stat_matrix_4), arr.ind = TRUE)]
#best lambda 0 


###Step 5:  Learning Rate
eta = c(0.01, 0.05, 0.1, 0.2, 0.3,0.4)
stat_matrix_5 = matrix(NA, nrow = length(eta),ncol = 1)

for (i in 1:length(eta)){
  cv.output.5 <- xgb.cv(data=train_matrix, 
                        max_depth = 5,
                        min_child_weight = 3,
                        eta = eta[i],
                        nrounds = 100, 
                        gamma = 0,
                        subsample = 0.6 , #0.6 or 1
                        metrics = "merror",  
                        objective = "multi:softprob", 
                        num_class = 3,
                        seed = 1234,
                        nfold = 5,  #10
                        nthread = 4, 
                        verbose = 0,
                        lambda = 0,
                        maximize = F, 
                        prediction = T)
  cv_err = min(cv.output.5$evaluation_log$test_merror_mean)
  print(cv_err)
  stat_matrix_5[i,1] = cv_err
  
}



#Final Model 

xgb <-function(train_matrix){
  cv.output<- xgb.cv(data=train_matrix, 
                     max_depth = 5,
                     min_child_weight = 3,
                     eta = 0.3,
                     nrounds = 100, 
                     gamma = 0,
                     subsample =0.6,
                     metrics = "merror",  
                     objective = "multi:softprob", 
                     num_class = 3,
                     seed = 1234,
                     nfold = 5,  
                     nthread = 4, 
                     verbose = 0,
                     lambda = 0,
                     maximize = F, 
                     prediction = T)
  cv_err = min(cv.output$evaluation_log$test_merror_mean)
  return(cv_err)
}



