## ----para, echo = FALSE, results='hide'---------------------------------------
BiocStyle::markdown()
knitr::opts_chunk$set(dev="png",fig.show="hold",
               fig.width=4,fig.height=4.5,fig.align="center",
               message=FALSE,collapse=TRUE)

## ----library------------------------------------------------------------------
library(rnaseqcomp)

dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")

input <- function(inputfile) {
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1];
    pfix = prefix()
  if (length(pfix) != 0) {
     pfix <<- paste(pfix, "/", sep="")
  }
}

run <- function() {}

output <- function(outputfile) {
pdf(outputfile)
## ----data---------------------------------------------------------------------
# load the dataset in this package
meta = read.csv(paste(pfix, parameters["meta", 2], sep="/"))
dat = readRDS(paste(pfix, parameters["data", 2], sep="/"))

## ----tx2----------------------------------------------------------------------
meta$fcsign[meta$fcstatus == "off.on"] <- NA
#print(str(dat))
write.csv(dat@quantData$rsem, paste(outputfile, "csv", sep="."))
plotFC(dat,meta$positive,meta$fcsign,ylim=c(0,1.2))

}
