library(igraph)
# Final Statements

don2com = read.table("campaign-contribution-text/smallDon2Com.txt", sep="\t", col.names=c("CID","DID","YEAR","AMOUNT"),fill = TRUE , header = FALSE)
don2com$YEAR =  substr(don2com$YEAR, 1, 4)
data_frame = data.frame(don2com)
data_frame <- data_frame[,c(2,1,4,3)]
shorter_data_frame = subset(data_frame, data_frame$YEAR >='1980')
shorter_data_frame = subset(shorter_data_frame, shorter_data_frame$YEAR <='2006')
groupByYear = split(shorter_data_frame , f = shorter_data_frame$YEAR)




processData = function(x)
{	
  #Row swap (this ensures that edges are sorted row wise, so that edges say 3-4 and 4-3 are both written as 3-4, and the two edges are differentiated by their corresponding direction)
  #condition <- x[,1] > x[,2] 
  # x[condition,] <- cbind(rev(x[condition,1:2]),-x[condition,3])
  x[x[,1]==x[,2],] <- NA     #to remove the edges of the type 3-3 etc (self loops) - such rows are replaced by "NA"
  x=x[complete.cases(x),]    #remove the NA rows
  colnames(x) <- c("DonorID","CommitteeID","Amount")
  #print(x[,1])
  #Getting net weight of an edge within a timestep (to account for the cases when within a timestep any particular edge repeats)	
  aggregate(x, by = list(x$DonorID , x$CommitteeID), FUN = sum) -> a
  print(a)
  x=data.frame(X1=a$Group.1, X2=a$Group.2, X3=a$X3)
  
  nrowx=nrow(x) 
  y=matrix(nrow=nrowx, ncol=3)
  y=data.frame(y[,])
  y[,1:3] = x[,1:3]	
  
  #Getting the direction column
  # y$X4 <- with(y,ifelse(X3<0,'b','f'))  #if net weight is negative, direction id backward, else forward
  # y$X3 <- with(y,ifelse(X3<0,-X3,X3))   #direction column is obtained, so now all weights are made positive
  
  #Replacing the numbers in weight column by an albhabet, depending on the range in which it lies
  condition1 <- ((y[,3]>1)&(y[,3]<=1000))
  condition2 <- ((y[,3]>1000)&(y[,3]<=3000))
  condition3 <- ((y[,3]>3000)&(y[,3]<=8000))
  condition4 <- ((y[,3]>8000)&(y[,3]<=15000))
  condition5 <- ((y[,3]>15000))
  
  y$Amount <- with(y,ifelse(condition1,'p', Amount))
  y$Amount <- with(y,ifelse(condition2,'q', Amount))
  y$Amount <- with(y,ifelse(condition3,'r', Amount))
  y$Amount <- with(y,ifelse(condition4,'s', Amount))
  y$Amount <- with(y,ifelse(condition5,'t', Amount))
  
  return(y)
}





result <- list()
i <- 1
for (name in names(groupByYear)) {
  print(name)
  result[[i]] = cbind(groupByYear[[i]]$CID, groupByYear[[i]]$DID, groupByYear[[i]]$AMOUNT)
  i <- i+1
  #result[[name]] <- dput(groupByYear[[name]])
}


#result
#g = graph.data.frame(as.data.frame(list_1980))

#for year in groupByYear$


### ~~~~~~~~~~~ END
g = graph.data.frame(as.data.frame(list_1980))
par("mar")
par(mar=c(1,1,1,1))
plot(g, vertex.size=.1 ,edge.arrow.size=.2,vertex.label=NA)
gList <- list()
