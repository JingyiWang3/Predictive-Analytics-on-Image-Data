######## function from adabag package #########

library("adabag")

train_ada <- function(train.data, train.label){
  train <- data.frame(label = factor(train.label), data = train.data)
  adabag_fit=boosting(label~.,data = train,coeflearn="Zhu")
  return(adabag_fit)
}

test_ada <- function(test.data, fitmodel){
  test <- data.frame(data = test.data)
  pred_ada = predict.boosting(fitmodel,newdata = test)$class
  return(pred_ada)
}

cv.ada <- function(X.train, y.train, train,test,K=5){
  
  n <- length(y.train)
  n.fold <- floor(n/K)
  s <- sample(rep(1:K, c(rep(n.fold, K-1), n-(K-1)*n.fold)))  
  cv.error <- rep(NA, K)
  
  for (i in 1:K){
    train.data <- X.train[s != i,]
    train.label <- y.train[s != i]
    test.data <- X.train[s == i,]
    test.label <- y.train[s == i]
    
    fit <- train(train.data, train.label)
    pred <- test(test.data, fit)  
    cv.error[i] <- mean(pred != test.label)  
    
  }			
  return(c(mean(cv.error),sd(cv.error)))
}

## using gist feature
system.time(ada.cverr <- cv.ada(gist_fea,label_train,train_ada,test_ada))
# user   system  elapsed 
# 2065.577   31.845 2119.947 
ada.cverr
# [1] 0.273666667 0.009234597

# using rgb feature
system.time(ada.cverr <- cv.ada(rgb_train,label_train,train_ada,test_ada))
# user   system  elapsed 
# 2393.798   63.151 2477.031 
# > ada.cverr
# [1] 0.11777778 0.01405457

# using SIFT feature
system.time(ada.cverr <- cv.ada(sift_train,label_train,train_ada,test_ada))
