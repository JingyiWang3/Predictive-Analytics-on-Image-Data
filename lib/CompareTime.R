############################################################################
### Compare xgboost model running time and cv.error on different feature ###
############################################################################

### Authors: Group 9
### ADS Spring 2018

# load library
library("xgboost")

#set.seed
set.seed(1234)


##################################

## sift time and cv.error
dat_train <- SIFT_train[,-1]
train_matrix <- xgb.DMatrix(data=data.matrix(dat_train),label=label_train)
system.time(cv.err_sift <- xgb(train_matrix))
# user  system elapsed 
# 511.969   2.924 151.932 
cv.err_sift
# [1] 0.2593334

## gist time and cv.error
dat_train <- gist_fea
train_matrix <- xgb.DMatrix(data=data.matrix(dat_train),label=label_train)
system.time(cv.err_gist <- xgb(train_matrix))
# user  system elapsed 
# 194.112   0.886  54.633 
cv.err_gist
# [1] 0.256


## rgb time and cv.error
dat_train <- rgb_train
train_matrix <- xgb.DMatrix(data=data.matrix(dat_train),label=label_train)
system.time(cv.err_rgb <- xgb(train_matrix))
# user  system elapsed 
# 288.458   1.413  79.644 
cv.err_rgb
# [1] 0.0976664

# predict
rgb.fit <- train(dat_train, label_train, run.xgboost = T)
rgb.pred <- test(rgb.fit, rgb_test)
mean(rgb.pred!=label_test)
# [1] 0.09066667

## rgb + gist time and cv.error
GistRgb_fea <- cbind(gist_fea,rgb_feature)
dat_train <- GistRgb_fea
train_matrix <- xgb.DMatrix(data=data.matrix(dat_train),label=label_train)
system.time(cv.err_GistRgb <- xgb(train_matrix))
# user  system elapsed 
# 394.409   1.861 112.146 
cv.err_GistRgb
# [1] 0.081

## sift + gist time and cv.error
GistSift_fea <- cbind(gist_fea,SIFT_train[,-1])
dat_train <- GistSift_fea
train_matrix <- xgb.DMatrix(data=data.matrix(dat_train),label=label_train)
system.time(cv.err_GistSift <- xgb(train_matrix))
# user  system elapsed 
# 638.885   1.293 166.451 
cv.err_GistSift
# [1] 0.1616666

## rgb + gist + sift time and cv.error
GistRgbSift_fea <- cbind(gist_fea,rgb_feature,SIFT_train[,-1])
dat_train <- GistRgbSift_fea
train_matrix <- xgb.DMatrix(data=data.matrix(dat_train),label=label_train)
system.time(cv.err_GistRgbSift <- xgb(train_matrix))
# user  system elapsed 
# 738.015   2.949 200.772 
cv.err_GistRgbSift
# [1] 0.0766668






