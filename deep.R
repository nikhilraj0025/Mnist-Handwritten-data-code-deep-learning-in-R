library(caret)
library(nnet)
mnist<-read.csv("C:/Users/AKHIL/Desktop/New folder/MNIST_Train.csv")
View(mnist)
dim(mn)
mnist$label<-factor(mnist$label,levels=0:9)
mnist.x<-mnist[,-1]
mnist.y<-mnist[,1]  #######these two codes are instead of train and test#####################
mnist_model<-train(x=mnist.x,y=mnist.y,method="nnet",tuneGrid = expand.grid(.size=c(10),
                    .decay=.1),trControl = trainControl(method = "none"),MaxNWts=10000,maxit=300)


mnist_pred<-predict(mnist_model,mnist)
mnist_pred<-confusionMatrix(mnist_pred,mnist.y)
mnist_pred
###################################"OR"#######################################################
#mnist_df<-data.frame(mnist_pred,mnist.y)
#View(mnist_df)

#colnames(mnist_df)<-c("predict","actual")
#mnist_tab<-table(mnist_df$predict,mnist_df$actual)
#acc_mnist<-sum(diag(mnist_tab)/sum(mnist_tab))
#acc_mnist
##############################################################h2o#########################################
library(h2o)
h2o.init()
mnist<-read.csv("C:/Users/AKHIL/Desktop/New folder/MNIST_Train.csv")
mnist$label<-as.factor(mnist$label)
mnist1<-as.h2o(mnist)
class(mnist1)
model_mnist_h2o<-h2o.deeplearning(x=2:785,y=1,training_frame = mnist1,hidden = c(20,20),epochs=100)
model_mnist_h2o_pred<-h2o.predict(model_mnist_h2o,as.h2o(mnist))
h2o.confusionMatrix(model_mnist_h2o,as.h2o(mnist))
#############################################################################################


