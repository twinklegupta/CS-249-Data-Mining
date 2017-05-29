library(igraph)
# Final Statements

don2com = read.table("campaign-contribution-text/Don2Com.txt", sep="\t", col.names=c("CID","DID","YEAR","AMOUNT"),fill = TRUE , header = FALSE)
don2com2 = read.table("campaign-contribution-text/Don2Com.txt", sep="\t", col.names=c("CID","DID","YEAR","AMOUNT"),fill = TRUE , header = FALSE)
don2com$YEAR =  substr(don2com$YEAR, 1, 4)
data_frame = data.frame(don2com)
shorter_data_frame = subset(data_frame, data_frame$YEAR >='1980')
shorter_data_frame = subset(shorter_data_frame, shorter_data_frame$YEAR <='2006')
groupByYear = split(shorter_data_frame , f = shorter_data_frame$YEAR)
result <- list()
for (name in names(groupByYear)) {
  print(name)
  result[[name]] = cbind(groupByYear[name]$CID, groupByYear[name]$DID, groupByYear[name]$AMOUNT)
  #result[[name]] <- dput(groupByYear[[name]])
}
#result
g = graph.data.frame(as.data.frame(list_1980))
par("mar")
par(mar=c(1,1,1,1))
plot(g, vertex.size=.1 ,edge.arrow.size=.2,vertex.label=NA)
#for year in groupByYear$


### ~~~~~~~~~~~ END




#candidates_table = read.table("campaign-contribution-text/candidates.txt", sep="\t", col.names=c("ID", "FECID", "NAME","PARTY1", "PARTY2", "ICO", "STATUS", "STREET1", "STREET2", "CITY", "STATE", "ZIP", "COMID", "ELECYEAR", "DISTRICT"), strip.white=TRUE, fill = TRUE , header = FALSE)
#committee_table = read.table("campaign-contribution-text/committees.txt", sep="\t", col.names=c("ID", "FECID", "NAME","TRESNAME", "STREET1", "STREET2","CITY" ,"STATE", "ZIP" , "DESIGNATION" ,"TYPE","PARTY", "FREQUENCY","INTERESTCAT","CONNECTEDORG", "CANDID" ), fill = TRUE)
#gsub("\\r(?!\\n)","[nl]"

#candidates_table = read.table("campaign-contribution-text/candidates.txt", sep="\t", col.names=c("ID", "FECID", "NAME","PARTY1", "PARTY2", "ICO", "STATUS", "STREET1", "STREET2", "CITY", "STATE", "ZIP", "COMID", "ELECYEAR", "DISTRICT"), strip.white=TRUE, fill = TRUE , header = FALSE)

#committee_table = read.table(textConnection(gsub("'", "", readLines("campaign-contribution-text/committees.txt"))), sep="\t", col.names=c("ID", "FECID", "NAME","TRESNAME", "STREET1", "STREET2","CITY" ,"STATE", "ZIP" , "DESIGNATION" ,"TYPE","PARTY", "FREQUENCY","INTERESTCAT","CONNECTEDORG", "CANDID" ),fill = TRUE , header = FALSE)
# contributors1 = read.table("campaign-contribution-text/contributors1.txt", sep="\t", col.names=c("ID","NAME","STREET","CITY","STATE","ZIP","OCCUPATION" ),fill = TRUE , header = FALSE)
# contributors2 = read.table("campaign-contribution-text/contributors2.txt", sep="\t", col.names=c("ID","NAME","STREET","CITY","STATE","ZIP","OCCUPATION" ),fill = TRUE , header = FALSE)
# contributors3 = read.table("campaign-contribution-text/contributors3.txt", sep="\t", col.names=c("ID","NAME","STREET","CITY","STATE","ZIP","OCCUPATION" ),fill = TRUE , header = FALSE)
# contributors4 = read.table("campaign-contribution-text/contributors4.txt", sep="\t", col.names=c("ID","NAME","STREET","CITY","STATE","ZIP","OCCUPATION" ),fill = TRUE , header = FALSE)
# contributors_table = rbind(contributors1,contributors2,contributors3, contributors4 )

#don2com = read.table("campaign-contribution-text/Don2Com.txt", sep="\t", col.names=c("CID","DID","YEAR","AMOUNT"),fill = TRUE , header = FALSE)
#check = don2com[1:10, ]
#check$YEAR <- substr(check$YEAR, 1, 4)


