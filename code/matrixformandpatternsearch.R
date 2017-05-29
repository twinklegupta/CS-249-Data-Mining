# g1<-graph.data.frame(y1[,1:2])
# g2<-graph.data.frame(y2[,1:2])
# g3<-graph.data.frame(y3[,1:2])
# g4<-graph.data.frame(y4[,1:2])

graphByYear <- list()
for (i in 1:length(groupByYear)){
  graphByYear[[i]] = graph.data.frame(dataList[[i]][,1:2])
}

graphUnion <- graph.union(graphByYear[[1]],graphByYear[[2]])

for (i in 3:length(groupByYear)){
  graphUnion = graph.union(graphUnion,graphByYear[[i]])
}


print("graph union done!!")
graphUnionEdge <- get.edgelist(graphUnion)

adjacencyMx <- list()
edgeList <- list()
for (i in 1:length(groupByYear)){
  print(i)
  #adjacencyMx[[i]] = as.matrix(get.adjacency(graphByYear[[i]]))
  #adjacencyMx[[i]] = get.adjacency(graphByYear[[i]])
  edgeList[[i]] = get.edgelist(graphByYear[[i]])
}




# gunion<-graph.union(g1,g2,g3,g4)
# gunionedge<-get.edgelist(gunion)
# 
# 
# ga1<-as.matrix(get.adjacency(g1))
# ga2<-as.matrix(get.adjacency(g2))
# ga3<-as.matrix(get.adjacency(g3))
# ga4<-as.matrix(get.adjacency(g4))
# 
# ge1<-get.edgelist(g1)
# ge2<-get.edgelist(g2)
# ge3<-get.edgelist(g3)
# ge4<-get.edgelist(g4)
# 
occrule<-matrix(nrow = nrow(graphUnionEdge), ncol = 56)
occrule[,1:2] <- graphUnionEdge[,1:2]
occrule[,3:56]<-0




occfun<-function(i)
{
  # print(i)
  x<-occrule[i,1]
  y<-occrule[i,2]
  x<-toString(x)
  y<-toString(y)

  for (j in length(groupByYear):1){
  
    #if((is.na(match(x,edgeList[[j]][,1])) || is.na(match(y,edgeList[[j]][,2]))))
    if(length(which(edgeList[[j]][,1] == x)) == 0 || length(which(edgeList[[j]][,1] == x) == 0))
    {
      occrule[i,j+2]<-0
    } else
    {
      
       occrule[i,j+2]<-1
      occrule[i,j+2+length(groupByYear)] <- dataList[[j]][which((x==dataList[[j]][,1]) & (y==dataList[[j]][,2])),3]
      
    }
  }

return(occrule)
}

stime <- proc.time()

for(i in 1:nrow(occrule))
{
  print(i)
  occrule<-occfun(i)
}

# # etime <- proc.time()
# # time <- etime-stime


# occfun<-function(i)
# {
#   # print(i)
#   x<-occrule[i,1]
#   y<-occrule[i,2]
#   x<-toString(x)
#   y<-toString(y)
#   
#   
#   
#   if((is.na(match(x,ge4[,1])) || is.na(match(y,ge4[,2]))))
#   {
#     occrule[i,6]<-0
#   } else
#   {
#     
#     if(ga4[x,y] != 0) { occrule[i,6]<-1
#     occrule[i,10] <- y4[which((x==y4[,1]) & (y==y4[,2])),3]
#     }
#   }
#   
#   if((is.na(match(x,ge3[,1])) || is.na(match(y,ge3[,2]))))
#   {
#     occrule[i,5]<-0
#   } else
#   {
#     
#     if(ga3[x,y] != 0) { occrule[i,5]<-1
#     occrule[i,9] <- y3[which((x==y3[,1]) & (y==y3[,2])),3]
#     
#     }
#   }
#   
#   if((is.na(match(x,ge2[,1])) || is.na(match(y,ge2[,2]))))
#   {
#     occrule[i,4]<-0
#   } else
#   {
#     
#     if(ga2[x,y] != 0) { occrule[i,4]<-1
#     occrule[i,8] <- y2[which((x==y2[,1]) & (y==y2[,2])),3]
#     }
#   }
#   
#   if((is.na(match(x,ge1[,1]))|| is.na(match(y,ge1[,2]))))
#   {
#     occrule[i,3]<-0
#   } else
#   {
#     
#     if(ga1[x,y] != 0) { occrule[i,3]<-1
#     occrule[i,7] <- y1[which((x==y1[,1]) & (y==y1[,2])),3]
#     }
#   }
#   return(occrule)
# }
# 
# stime <- proc.time()
# 
# for(i in 1:nrow(occrule))
# {
#   occrule<-occfun(i)
# }
