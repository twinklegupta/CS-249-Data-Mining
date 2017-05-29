library(igraph)

#Reading file to load the dataset as a list in R

don2com = read.table("Don2Com.txt", sep="\t", col.names=c("CommitteeID", "DonorID", "Date","Amount"),fill = TRUE , header = FALSE)
print(" Loading Complete")

#Stripping the Date and storing the first 4 characters which signifies year of contribution
don2com$Date <- substr(don2com$Date, 1, 4)

#Loading into data frame
df <- data.frame(don2com)

# Swapping column names to correct the edge direction

df <- df[,c(2, 1, 4, 3)]
shorter_data_frame = subset(df, df$Date >='1980')
shorter_data_frame = subset(shorter_data_frame, shorter_data_frame$Date <='2006')
# gruping by year
#groupByYear[[1]] gives records of one specific year and so on

groupByYear <- split(shorter_data_frame , f = shorter_data_frame$Date)


result <- list()
for (i in 1:length(groupByYear)) {
result[[i]] = cbind(groupByYear[[i]]$DonorID, groupByYear[[i]]$CommitteeID, groupByYear[[i]]$Amount)
}

groupByYear <- result
#Installing package and attaching library
#install.packages("igraph")
#library(igraph)

# Plotting groups
# g = graph.data.frame(as.data.frame(groupByYear[[1]]))
# par("mar")
# par(mar=c(1,1,1,1))
# plot(g, vertex.size=.1 ,edge.arrow.size=.2, vertex.label= g$CommitteeID)
# plot.igraph(g)

# Storing graphs of all years
g <- list()
for (i in 1:length(groupByYear)){
  g[[i]] = graph.data.frame(as.data.frame(groupByYear[[i]]))
}

processData = function(x)
{	
  #Row swap (this ensures that edges are sorted row wise, so that edges say 3-4 and 4-3 are both written as 3-4, and the two edges are differentiated by their corresponding direction)
  #condition <- x[,1] > x[,2] 
  # x[condition,] <- cbind(rev(x[condition,1:2]),-x[condition,3])
  x[x[,1]==x[,2],] <- NA     #to remove the edges of the type 3-3 etc (self loops) - such rows are replaced by "NA"
  x=x[complete.cases(x),]    #remove the NA rows
  # colnames(x) <- c("DonorID","CommitteeID","Amount")
  #print(x[,1])
  #Getting net weight of an edge within a timestep (to account for the cases when within a timestep any particular edge repeats)	
  a <- aggregate(x[,3], by = list(x[,1] , x[,2]), FUN = sum)
  x=data.frame(X1=a$Group.1, X2=a$Group.2, X3=a$x)

  nrowx=nrow(x)
  y=matrix(nrow=nrowx, ncol=3)
  y=data.frame(y[,])
  y[,1:3] = x[,1:3]

  #Getting the direction column
  # y$X4 <- with(y,ifelse(X3<0,'b','f'))  #if net weight is negative, direction id backward, else forward
  # y$X3 <- with(y,ifelse(X3<0,-X3,X3))   #direction column is obtained, so now all weights are made positive

  #Replacing the numbers in weight column by an albhabet, depending on the range in which it lies
  condition1 <- ((y[,3]<=1000))
  condition2 <- ((y[,3]>1000)&(y[,3]<=10000))
  condition3 <- ((y[,3]>10000)&(y[,3]<=50000))
  condition4 <- ((y[,3]>50000)&(y[,3]<=1000000))
  condition5 <- ((y[,3]>1000000)&(y[,3]<=5000000))
  condition6 <- ((y[,3]>5000000))

  y[,3] <- with(y,ifelse(condition1,'p', X3))
  y[,3] <- with(y,ifelse(condition2,'q', X3))
  y[,3] <- with(y,ifelse(condition3,'r', X3))
  y[,3] <- with(y,ifelse(condition4,'s', X3))
  y[,3] <- with(y,ifelse(condition5,'t', X3))
  y[,3] <- with(y,ifelse(condition6,'u', X3))

  return(y)
}

#Each of the following y obtained is proper dataset corresponding to each timestep, having weight as well as direction columns corresponding to each edge 

dataList <- list()
for (i in 1:length(groupByYear)){
  dataList[[i]] = processData(groupByYear[[i]])
  print("I am on iteration")
  print(i)
}

# y1=processData(groupByYear[[1]])
# y2=processData(groupByYear[[2]])
# y3=processData(groupByYear[[3]])
# y4=processData(groupByYear[[4]])

for( i in 1:length(groupByYear)){
  fileName = paste("data_",toString(i), ".csv",sep="") 
  write.table(dataList[[i]],fileName, sep = '\t',row.names = FALSE,col.names = TRUE)
}
