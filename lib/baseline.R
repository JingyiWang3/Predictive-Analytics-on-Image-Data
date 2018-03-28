#######################################################
### baseline model ###
#######################################################

### Authors: Group 9
### ADS Spring2018

### note that :
###     In train.R, all default parameters (in gbm) are set to best parameters we get 
###     from our experiments. Therefore we can fit model here without seting parameter,
###     i.e. use default best parameters

# sift
system.time(fit.model <- train(sift_train, label_train, run.gbm = T))
# user  system elapsed 
# 43.631   0.435  44.324 
pred <- test(fit.model, sift_test, run.gbm = T)
mean(pred != label_test)
# [1] 0.3


# gist
system.time(fit.model <- train(gist_train, label_train, run.gbm = T))
# user  system elapsed 
# 13.567   0.132  13.821 
pred <- test(fit.model, gist_test, run.gbm = T)
mean(pred != label_test)
# [1] 0.2786667

# rgb
system.time(fit.model <- train(rgb_train, label_train, run.gbm = T))
# user  system elapsed 
# 20.702   0.211  21.283 
pred <- test(fit.model, rgb_test, run.gbm = T)
mean(pred != label_test)
# [1] 0.132