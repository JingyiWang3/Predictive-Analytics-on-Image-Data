###################
### record time ###
###################

### Author: Group 9
### ADS Spring 2018

###record time

## import functions
source('./lib/cross_validation.R')
source('./lib/test.R')

################### rgb_train ##################################

system.time(cverr.rgb <- cv(rgb_train ,label_train,
                           run.xgboost = T,
                           run.gbm = F,
                           run.adaboost = F))
# user  system elapsed 
# 174.817   0.637  46.731

cverr.rgb
# $error
# [1] 0.09688889
# 
# $sd
# [1] 0.00640216

##################### gist_train##################################

system.time(cverr.gist <- cv(gist_train ,label_train,
                            run.xgboost = T,
                            run.gbm = F,
                            run.adaboost = F))
# user  system elapsed 
# 182.393   0.543  49.138 
 
cverr.gist
# $error
# [1] 0.2564444
# 
# $sd
# [1] 0.02129163

################## sift_train #####################################

system.time(cverr.sift <- cv(sift_train ,label_train,
                             run.xgboost = T,
                             run.gbm = F,
                             run.adaboost = F))
# user  system elapsed 
# 379.659   1.301 104.052 

cverr.sift
# $error
# [1] 0.2928889
# 
# $sd
# [1] 0.01452116

############## rgb&gist_train#########################################

system.time(cverr.rgbgist <- cv(cbind(rgb_train,gist_train) ,label_train,
                            run.xgboost = T,
                            run.gbm = F,
                            run.adaboost = F))
# user  system elapsed 
# 293.864   1.462  83.249 

cverr.rgbgist
# $error
# [1] 0.09022222
# 
# $sd
# [1] 0.00854906

##################### gistsift_train ##################################

system.time(cverr.gistsift <- cv(cbind(gist_train,sift_train) ,label_train,
                             run.xgboost = T,
                             run.gbm = F,
                             run.adaboost = F))
# user  system elapsed 
# 547.463   2.343 154.025 

cverr.gistsift
# $error
# [1] 0.1724444
# 
# $sd
# [1] 0.01583869

####################### gbgistsift_train################################

system.time(cverr.rgbgistsift <- cv(cbind(rgb_train,gist_train,sift_train) ,label_train,
                             run.xgboost = T,
                             run.gbm = F,
                             run.adaboost = F))
# user  system elapsed 
# 584.693   2.862 166.637 

cverr.rgbgistsift
# $error
# [1] 0.08933333
# 
# $sd
# [1] 0.007761889

#####################################################
