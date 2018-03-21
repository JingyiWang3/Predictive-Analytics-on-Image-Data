#######################################
### make prediction using test data ###
#######################################

### Author: Group 9
### ADS Spring 2018

test <- function(fit.model, dat_test,
                 run.xgboost = F, run.gbm = F,
                 run.adaboost = F, par=NULL){
  ### train a model according to input
  
  ### Input: 
  ###   fit.model - the fitted classification model using training data
  ###   dat_test - processed features from testing images 
  ###   run.xxxxxx - select which model to fit
  ###   par - specified parameters, otherwise use default
  ### Output: 
  ###   model prediction
  
  ### load libraries
  library("gbm")
  library("adabag")
  library("xgboost")
  
  ### make prediction 
  if(run.adaboost == T){
    
    # create test data frame
    test <- data.frame(data = dat_test)
    # predict
    pred = predict.boosting(fit.model,newdata = test)$class
  }
  
  else{
    pred <- predict(fit.model, newdata=as.matrix(dat_test))
  }
  return(pred)
}

