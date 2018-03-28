#######################################################
### extract RGB feature for training/testing images ###
#######################################################

### Authors: Group 9
### ADS Spring2018

feature <- function(img_dir = NULL, par = NULL){
  
  ### extract rgb feature from raw data
  ###! note that based on rgb algorithm, the process of extract feature is independent 
  ###   from individual to individual. Therefore we can import whole data and extract feature
  ###   (disregard train and test)
  
  ### Input: 
  ###   img_dir -  image directory, with default to "../data/train/images/"
  ###   par - hyperparameter of rgb
  ### Output: 
  ###   rgb feature
  
  ### load libraries
  library("EBImage")
  library("grDevices")
  
  if(is.null(img_dir)){
    img_dir = "../data/train/images/"
  }
  
  ### Define the bin number of R, G and B
  if(is.null(par)){
    # set default number to our tuned best parameter
    nR <- 10
    nG <- 10
    nB <- 10
  }
  else{
    nR <- par$nR
    nG <- par$nG
    nB <- par$nB
  }

  rBin <- seq(0, 1, length.out=nR)
  gBin <- seq(0, 1, length.out=nG)
  bBin <- seq(0, 1, length.out=nB)
  mat=array()
  freq_rgb=array()
  rgb_feature=matrix(nrow=3000, ncol=nR*nG*nB)
  
  n_files <- length(list.files(img_dir))
  
  if(n_files == 0){
    print("no file  in the directory")
    return(0)
  }
  
  ########extract RGB features############

  for (i in 1:n_files ){
    mat <- imageData(readImage(paste0(img_dir, sprintf("%04.f",i), ".jpg")))
    mat_as_rgb <-array(c(mat,mat,mat),dim = c(nrow(mat),ncol(mat),3))
    freq_rgb <- as.data.frame(table(factor(findInterval(mat_as_rgb[,,1], rBin), levels=1:nR), 
                                    factor(findInterval(mat_as_rgb[,,2], gBin), levels=1:nG),
                                    factor(findInterval(mat_as_rgb[,,3], bBin), levels=1:nB)))
    rgb_feature[i,] <- as.numeric(freq_rgb$Freq)/(ncol(mat)*nrow(mat))
    
    mat_rgb <-mat_as_rgb
    dim(mat_rgb) <- c(nrow(mat_as_rgb)*ncol(mat_as_rgb), 3)
  }
  
  return(data.frame(rgb_feature))
}