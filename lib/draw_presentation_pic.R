# install.packages("RColorBrewer")
library("RColorBrewer")
#install.packages("gplots")
library(gplots)
feature.dim  <- c(rep("SIFT",2000),rep("RGB",1440),rep("GIST",512))
feature.name <- c("SIFT", "RGB", "GIST")
plot(table(feature.dim))
barplot(feature.dim, xlab, ylab, main, names.arg, col)

barplot(feature.dim)



H <- c(2000,1000,512)
M <-  c("SIFT", "RGB", "GIST")


# Plot the bar chart.
p1 <- barplot(H,names.arg = M,xlab = "feature",ylab = "dimension",col = "yellow",
        main = "feature dimension",border = "red")
text(cex=1,x=p1, y=H+50, xpd=TRUE, lab=paste(H))


cvsd <- data.frame(RGB = c("8:8:8","10:10:10","10:12:12"),cv.error=c(0.1016667,0.09133333,0.097),sd = c(0.01027402,0.008283182,0.0119257))
cvsd <- data.frame(RGB = c(1,2,3),cv.error=c(0.1016667,0.09133333,0.097),sd = c(0.01027402,0.008283182,0.0119257))

library(ggplot2)
# Plot the 
ggplot(cvsd, aes(x=RGB, y=cv.error)) + 
  geom_errorbar(aes(ymin=cv.error-sd, ymax=cv.error+sd), width=.1,color =  factor(cvsd$RGB)) +
  geom_line() +
  geom_point() +
  ylim(0.065,0.125) + 
  theme(axis.text.x = element_blank()) + 
  geom_text(aes(label = cv.error, vjust = 1, hjust = -0.5, angle = 45)) +
  geom_text(aes(x = cvsd$RGB,y=rep(0.07,3),label = c("8:8:8","10:10:10","10:12:12")))
  
# Plot th
rgbsvm <- data.frame(t(matrix(c(0.554667	,0.565778	,0.01	,0.012555	,0.004565
,0.628000	,0.641778	,0.1	 ,0.009978	,0.007894
,0.684444	,0.708667,	1	   ,0.015938	,0.011863
,0.704444	,0.764444,	10	 ,0.014700	,0.009370
,0.725333	,0.823333,	100		,0.019956	,0.003771),nrow=5,)))

colnames(rgbsvm) <- c("mean_test_score", "mean_train_score", "param C", "std_test_score","std_train_score")
rgbsvm2 <- data.frame(mean_score = c(rgbsvm$mean_test_score,rgbsvm$mean_train_score),
                      param_C = rep(rgbsvm$`param C`,2),
                      std_score = c(rgbsvm$std_test_score,rgbsvm$std_train_score ),
                      supp = c(rep("test",5),rep("train",5)))

ggplot(rgbsvm2, aes(x=param_C, y=mean_score, colour=supp)) + 
  geom_errorbar(aes(ymin=mean_score-std_score, ymax=mean_score+std_score), width=.1) +
  geom_line() +
  geom_point() +
  scale_x_continuous(trans = "log10",breaks = rgbsvm2$param_C) + 
  geom_text(aes(label = mean_score, vjust = 0.5, hjust = -0.4, angle = -45)) 


# heat map
rbfsvm <- data.frame(t(matrix(c(0.425778		,0.01	,0.01
,0.425778		,0.01	,0.1	
,0.429333		,0.01	,1
,0.548444		,0.01	,10	
,0.491111		,0.01	,100),nrow=3,byrow = F)))

colnames(rbfsvm) <- c("mean_test_score", "C","gamma")


x  <- as.matrix(mtcars)
rc <- rainbow(nrow(x), start = 0, end = .3)
cc <- rainbow(ncol(x), start = 0, end = .3)
hv <- heatmap(x, col = cm.colors(256), scale = "column",
              RowSideColors = rc, ColSideColors = cc, margins = c(5,10),
              xlab = "specification variables", ylab =  "Car Models",
              main = "heatmap(<Mtcars data>, ..., scale = \"column\")")

## "no nothing"

rgb888_error <- matrix(c(0.1030000, 0.1013333, 0.1036667,
                          0.1016667, 0.1013333, 0.1033333,
                          0.1170000, 0.1060000, 0.1073333,
                          0.1140000, 0.1043333, 0.1033333),4,byrow = T)
heatmap.2(rgb888_error, Rowv=NA, Colv=NA, col = "blue",
          scale="row", density.info="none", trace="none")

## Some fake data for you
data_matrix <- matrix(runif(100, 0, 3.5), 10, 10)

## The colors you specified.
myCol <- c("blue", "green")
## Defining breaks for the color scale
myBreaks <- c(0, .3)

hm <- heatmap.2(data_matrix, scale="none", Rowv=NA, Colv=NA,
                col = myCol, ## using your colors
                breaks = myBreaks, ## using your breaks
                dendrogram = "none",  ## to suppress warnings
                margins=c(5,5), cexRow=0.5, cexCol=1.0, key=TRUE, keysize=1.5,
                trace="none")

