setwd("/Users/iris/Desktop/5243 ADS/Project3")
sift_feature=read.csv("train/SIFT_train.csv", header = F)
## read data
label=read.csv("train/label_train.csv")
#load("rgb_feature.RData")
#write.csv(rgb_feature, file = "rgb_feature.csv")
rgb_feature=read.csv("rgb_feature.csv")
gist_feature=read.csv("gist_feature.csv", header = F)

sift_feature <- sift_feature[,-1]
rgb_feature <- rgb_feature[,-1]

## split data
library(fifer)
set.seed(1)
ind <- 1:3000
df <- data.frame(ind, label[,3])
colnames(df) <- c("index","label")
train <- stratified(df, "label", 0.75)
train.ind <- train$index
test.ind <- setdiff(ind, train.ind)

# label
label_train <- factor(train$label)
label_test <- factor(df$label[test.ind])

# train data
rgb_train <- rgb_feature[train.ind,]
gist_train <- gist_feature[train.ind,]
sift_train <- sift_feature[train.ind,]

# test data
sift_test <- sift_feature[test.ind,] 
rgb_test <- rgb_feature[test.ind,]
gist_test <- gist_feature[test.ind,]

## linear svm function
library(e1071)
svm_linear <- function(train, test, c){
  time <- system.time(fit <- svm(x=train, y=label_train, kernel="linear", cost=c, scale = FALSE))
  res <- predict(fit, test)
  err <- mean(res != label_test)
  return(list(Time = time, Error = err))
}
svm1 <- svm_linear(sift_train, sift_test, c=100)
svm1
svm3 <- svm_linear(rgb_train, rgb_test, c=100)
svm3
svm5 <- svm_linear(gist_train, gist_test, c=1)
svm5

## non-linear svm function
svm_linear <- function(train, test, c, g){
  time <- system.time(fit <- svm(x=train, y=label_train, kernel="radial", cost=c, gamma=g, scale = FALSE))
  res <- predict(fit, test)
  err <- mean(res != label_test)
  return(list(Time = time, Error = err))
}
svm2 <- svm_linear(sift_train, sift_test, c=10, g=100)
svm2
svm4 <- svm_linear(rgb_train, rgb_test, c=100, g=1)
svm4
svm6 <- svm_linear(gist_train, gist_test, c=10, g=10)
svm6