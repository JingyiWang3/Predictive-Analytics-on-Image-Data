##################################
### tune hyperparameter of rgb ###
##################################

### Authors: Group 9
### ADS Spring2018

# load feature extraction function and some other files
source("./lib/feature.R")
source("./lib/Split_Data.R")
source("./lib/cross_validation.R")

# create rgb label
rgb_label <- c(rep(0,1000),rep(1,1000),rep(2,1000))
  
##################################
# set RGB to 8 8 8
par888 = list(nR = 8, nG = 8, nB = 8)

# extract rgb888 feature
rgb888 <- feature(par = par888)

# compute cv error and sd
cv888 <- cv(rgb_train ,label_train, run.xgboost = T, K = 5, par = par888)
cv888
# $error
# [1] 0.1016667
# 
# $sd
# [1] 0.01027402

##################################
# set RGB to 10 10 10
par101010 = list(nR = 10, nG = 10, nB = 10)

# extract rgb101010 feature
rgb101010 <- feature(par = par101010)

# compute cv error and sd
cv101010 <- cv(rgb101010 ,rgb_label, run.xgboost = T, K = 5, par = par101010)
cv101010
# > cv101010
# $error
# [1] 0.09133333
# 
# $sd
# [1] 0.008283182

##################################
# set RGB to 10 12 12
par101212 = list(nR = 10, nG = 12, nB = 12)

# extract rgb101212 feature
rgb101212 <- feature(par = par101212)

# compute cv error and sd
cv101212 <- cv(rgb101212 ,rgb_label, run.xgboost = T, K = 5, par = par101212)
cv101212

# > cv101212
# $error
# [1] 0.097
# 
# $sd
# [1] 0.0119257