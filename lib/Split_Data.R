###############################################
### Split data into train and test data set ###
###############################################

### Authors: Group 9
### ADS Spring2018

# load feature
rgb_feature <- read.csv('./data/rgb_feature.csv',header = T)
gist_feature <- read.csv('./data/gist_feature/gistfea512.csv',header = F)
SIFT_feature <- read.csv('./data/train/SIFT_train.csv',header = F)[,-1]

# set seed
set.seed(1234)

# total index
ind <- 1:3000

# total label
all.label <- c(rep(0,1000),rep(1,1000),rep(2,1000))

# test data index
test.ind <- sample(ind, size = 750, replace = FALSE)

# train data index
train.ind <- setdiff(ind,test.ind)

# train label
label_train <- all.label[train.ind]
label_test <- all.label[test.ind]


# train data
rgb_train <- rgb_feature[train.ind,] # rgb train data
gist_train <- gist_feature[train.ind,] # gist train data
sift_train <- SIFT_feature[train.ind,] # sift train data

# test data
rgb_test <- rgb_feature[test.ind,] # rgb train data
gist_test <- gist_feature[test.ind,] # gist train data
sift_test <- SIFT_feature[test.ind,] # sift train data

