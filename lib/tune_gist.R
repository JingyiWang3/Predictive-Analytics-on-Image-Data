###install library
library("xgboost")


###Load data
gist.feasure2 <-read.csv("gistfea1152.csv",header = FALSE)
gist_matrix2 <- xgb.DMatrix(data=data.matrix(gist.feasure2[train_ind,]),label=label[train_ind])
gist_test2 <-  xgb.DMatrix(data=data.matrix(gist.feasure2[test_ind,]),label=label[test_ind])

### Tune max_depth and min_child_weight
max_depth<-seq(4,9,2) 
min_child_weight <- seq(1,6,2)
stat_matrix3 = matrix(NA,nrow = length(max_depth), length(min_child_weight))

for (i in 1:length(max_depth)){
  for (j in 1:length(min_child_weight)){
    my.params <- list(max_depth = max_depth[i], min_child_weight = min_child_weight[j])
    cv.output3 <- xgb.cv(data=gist_matrix2, 
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
    
    cv_err = min(cv.output3$evaluation_log$test_merror_mean)
    print(cv_err)
    stat_matrix3[i,j] = cv_err
    
  }}



which(stat_matrix3 == min(stat_matrix3), arr.ind = TRUE) 
max_depth[2]
min_child_weight[3]


###Final Model
system.time(xgb_gist2 <- xgb.train(data=gist_matrix2,  
                                  eta = 0.3,
                                  max_depth = 6,
                                  min_child_weight = 5,
                                  nrounds = 100, 
                                  gamma = 0, 
                                  subsample = 1, 
                                  metrics = "merror",  
                                  objective = "multi:softprob", 
                                  num_class = 3,
                                  seed = 1234,
                                  nfold = 5, 
                                  nthread = 4,
                                  verbose = 0,
                                  maximize = F, 
                                  prediction = T))



###Test Prediction
test_pred <- predict(xgb_gist2, gist_test2)
library(dplyr)
numberOfClasses = 3 
test_label = train$V1[test_ind]
test_prediction <- matrix(test_pred, nrow = numberOfClasses,
                          ncol=length(test_pred)/numberOfClasses) %>%
  t() %>%
  data.frame() %>%
  mutate(label = test_label  + 1,
         max_prob = max.col(., "last"))

1- mean(test_prediction$label == test_prediction$max_prob) #0.255



