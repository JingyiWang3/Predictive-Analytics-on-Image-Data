max_depth_values<-seq(4,9,2) #for xgboost
min_child_weight_values <- seq(1,6,2) #for xgboost
stat_matrix = matrix(NA,nrow = length(max_depth_values), length(min_child_weight_values))

dat_train <- rgb_train
train_matrix <- xgb.DMatrix(data=data.matrix(dat_train),label=label_train)
for (i in 1:length(max_depth_values)){
  for (j in 1:length(min_child_weight_values)){
    my.params <- list(max_depth = max_depth_values[i],
                      min_child_weight = min_child_weight_values[j])
    
    cv.output <- xgb.cv(data=train_matrix, ###make by yourself.
                        params=my.params,
                        eta = 0.4,
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
    print(cv_err)
    stat_matrix[i,j] = cv_err
    
  }}

rgb_stat_matrix <- stat_matrix
# [,1]      [,2]      [,3]
# [1,] 0.1075556 0.1004444 0.0982220
# [2,] 0.1111112 0.1040000 0.1048886
# [3,] 0.1137778 0.1040000 0.1102222

