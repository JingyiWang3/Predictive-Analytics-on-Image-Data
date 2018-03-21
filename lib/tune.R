########################
### Feature Turning ###
########################

### Author: Group 9
### ADS Spring 2018

tune <- function(dat_train ,label_train,
                 run.xgboost = F,
                 run.gbm = F,
                 run.adaboost = F){
  
  ### tune parameter
  
  ### Input: 
  ###   dat_train -  processed features from images 
  ###   label_train -  class labels for training images
  ###   run.xxxxxx - select which model to fit
  ### Output: 
  ###   best parameter
  
  ### load libraries
  library("gbm")
  library("adabag")
  library("xgboost")
  
  ### load functions 
  source("../lib/cross_validation.R")
  
  #############################################
  
  ## adaboost model tune parameter
  
  if(run.adaboost == T){
    ## parameter pool
    mfinal <- c(50, 75, 100, 125)
    
    ## initial cv error
    cv.error <- c()
    
    ## loop parameter combination
    for(i in length(mfinal)){
      par <- list(mfinal = mfinal[i])
      cv.error[i] <- cv(dat_train, label_train, run.adaboost = T, par = par)$error
    }
    
    # best cv.error
    cv_error =  min(cv.error)
    # best parameter
    best.mfinal = mfinal[which(cv.error == min(cv.error))]
    best_par = list(mfinal = best.mfinal)

  }
  
  #############################################
  
  ## gbm model tune parameter
  
  if(run.gbm == T){
    
    ## parameter pool
    shrinks_range <- c(0.01,0.1,0.3)
    trees_range  <- c(40,50,60)
    
    ## initial cv error
    error_matrix = matrix(NA,nrow = length(shrinks_range), length(trees_range))
    
    ## loop parameter combination
    for (i in 1:length(shrinks_range)){
      for (j in 1:length(trees_range)){
      par <- list(shrinkage = shrinks_range[i], ntrees = trees_range[j] )
      cv.error[i] <- cv(dat_train, label_train, run.adaboost = T, par = par)$error
      }
    }
    
    # best cv.error
    cv_error =  min(cv.error)
    
    # best parameter
    best_par = list(shrinkage = shrinks_range[which(error_matrix == min(error_matrix), arr.ind = T)[1]],
                    ntrees = trees_range[which(error_matrix == min(error_matrix), arr.ind = T)[2]])
  }
    
  #############################################
  
  ## xgboost model tune parameter
  
  if(run.xgboost == T){

    max_depth_values <- seq(3,9,2)
    min_child_weight_values <- seq(1,6,2)
    
    # error matrix
    error_matrix = matrix(NA,nrow = length(max_depth_values), length(min_child_weight_values))
    
    #tuning process
    for (i in 1:length(max_depth_values)){
      for (j in 1:length(min_child_weight_values)){
        
        par <- list(depth = max_depth_values[i], child_weight = min_child_weight_values[j] )
        error_matrix[i] <- cv(dat_train, label_train, run.xgboost = T, par = par)$error
      }
    }
    
    # best cv.error
    cv_error =  min(error_matrix)
    # best parameter
    best_par = list(depth = par$depth[which(error_matrix == min(error_matrix), arr.ind = T)[1]],
                    child_weight = par$depth[which(error_matrix == min(error_matrix), arr.ind = T)[2]])

  }
  
  return(list(cv_error,best_par))
}