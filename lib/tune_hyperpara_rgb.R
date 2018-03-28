##################################
### tune hyperparameter of rgb ###
##################################

### Authors: Group 9
### ADS Spring2018

# load feature extraction function and some other files
source("./lib/feature.R")
source("./lib/tune.R")
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
cv888 <- cv(rgb888 ,rgb_label, run.xgboost = T, K = 5, par = par888)
cv888
# $error
# [1] 0.1016667
# 
# $sd
# [1] 0.01027402

tune(rgb888,rgb_label,
     run.xgboost = T,
     verbose = T)
# >error_matrix
# 1         3         5
# 3 0.1030000 0.1013333 0.1036667
# 5 0.1016667 0.1013333 0.1033333
# 7 0.1170000 0.1060000 0.1073333
# 9 0.1140000 0.1043333 0.1033333
# >sd_matrix
# 1           3          5
# 3 0.01868600 0.009545214 0.02155742
# 5 0.02450624 0.009472181 0.01016530
# 7 0.02296132 0.011266963 0.02212967
# 9 0.01341641 0.009972184 0.01417157
# >par
# [[2]]$depth
# [1] 3
# 
# [[2]]$child_weight
# [1] 3

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

tune(rgb101010,rgb_label,
     run.xgboost = T,
     verbose = T)

# >error_matrix
# 1          3          5
# 3 0.0880000 0.09133333 0.08300000
# 5 0.0930000 0.09466667 0.09400000
# 7 0.1023333 0.09466667 0.09966667
# 9 0.1053333 0.10033333 0.09533333
# >sd_matrix
# 1          3           5
# 3 0.008771798 0.01615893 0.011155467
# 5 0.007691987 0.01977653 0.013354150
# 7 0.012382784 0.01806624 0.006168919
# 9 0.007397447 0.01820409 0.007940753

# >par
# [[2]]$depth
# [1] 3
# 
# [[2]]$child_weight
# [1] 5



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

tune(rgb101212,rgb_label,
     run.xgboost = T,
     verbose = T)
# >error_matrix
# 1          3          5
# 3 0.09166667 0.09366667 0.09100000
# 5 0.09833333 0.09700000 0.09133333
# 7 0.10266667 0.10333333 0.10333333
# 9 0.10733333 0.10100000 0.09933333
# >sd_matrix
# 1          3          5
# 3 0.006519202 0.01455831 0.01391442
# 5 0.004183300 0.01426924 0.01387444
# 7 0.006932211 0.01269296 0.01031450
# 9 0.023499409 0.01099242 0.01138957

# 
# >par
# [[2]]$depth
# [1] 3
# 
# [[2]]$child_weight
# [1] 5

