#!/usr/bin/Rscript
library(rmemcache)

# store for a year
year <-  as.integer(Sys.time()+24*60*60*365)

mcon <- mcConnect(servers='localhost:11211')
con <- file('stdin',open='r')
l <- readLines(con,n=1,warn=FALSE)
i <- 1
while(length(l)){

	x <- strsplit(l,'\t')[[1]]

	key <- gsub(' ','|',x[1])

	if (!mcAdd(mcon=mcon,key=key,value=x[2],exptime=year)){
		cat(x[1],'\n',sep='')
	}

	l <- readLines(con,n=1,warn=FALSE)
	i <- i + 1
}
