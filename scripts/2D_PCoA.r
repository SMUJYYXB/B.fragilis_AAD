#R version 3.2.2
assign("read.dm", function (distance, ...) {
  ## It will skip all the beginning comment lines except
  ## the last line.
  ## This is specifically for QIIME related tables.
  filename <- paste(distance,"_dm.txt",sep="")
  lines <- readLines(filename)
  ## lines of comment
  n <- grep("^#", lines)
  if(length(n) > 0)
    start <- n[length(n)]
  else
    start <- 1
  end <- length(lines)
  x <- read.table(text=lines[start:end],
                  header=T,
                  sep='\t',
                  comment.char='',
                  check.names=F,
                  row.names=1,
                  ...)
})

assign("read.pc", function (distance, ...) {
  ## It will skip all the beginning comment lines except
  ## the last line.
  ## This is specifically for QIIME related tables.
  filename <- paste(distance,"_pc.txt",sep="")
  lines <- readLines(filename)
  ## lines of comment
  n <- grep("^#", lines)
  if(length(n) > 0)
    start <- n[length(n)]
  else
    start <- 1
  end <- length(lines)
  x <- read.table(text=lines[start:end],
                  header=F,
                  sep='\t',
                  comment.char='',
                  check.names=F,
                  stringsAsFactors = F,
                  fill=T,
                  ...)
  x <-na.omit(x)
  pc_percent <- format(as.numeric(x[2,1:10])*100,digits = 4)
  print (pc_percent)
  x <- x[-c(1:2),]
  rownames(x) <- x[,1]
  x <- x[,-1]
  pc_name <- paste("PC",1:10,sep="")
  colnames(x) <- pc_name
  pc <- list(pc_data=x,pc_percent=pc_percent)
})
#----------------Package
library(ade4)
source("s.classmd.R")
#----------------All 
path <- "output/bdiv/unweighted_unifrac"
dm <- read.dm(path)
pc_list <- read.pc(path)
pc_data <- pc_list[[1]]
pc_percent <- pc_list[[2]]
meta <- read.table("aad.metadata.txt",header=T,sep="\t",row.names = 1,comment.char = "")
sample.ids <- intersect(rownames(meta),rownames(pc_data))
data <- data.frame(pc_data[sample.ids,1:2],group=meta[sample.ids,"combine_group"])
mycolors <- c("red2","darkorange2","yellow2","green2","turquoise1","blue2","magenta3",
               "rosybrown2","darkgoldenrod2","lightgoldenrod2","lightgreen","lightcyan2","skyblue2","orchid2")
pdf(file=paste("all_pcoa.pdf",sep=""),width=6,height=6,useDingbats=F)
s.classmd(data[,1:2],data$group,xax=1,yax=2,col = mycolors,axesell=F,Labels=pc_percent,cpoint=2,grid=FALSE,cgrid = 0,clabel = 0.5)
dev.off()
#---------------Group A and Group B
path <- "output/AB_bdiv/unweighted_unifrac"
dm <- read.dm(path)
pc_list <- read.pc(path)
pc_data <- pc_list[[1]]
pc_percent <- pc_list[[2]]
meta <- read.table("aad.metadata.txt",header=T,sep="\t",row.names = 1,comment.char = "")
meta <- subset(meta,Group=="A"|Group=="B")
meta <- droplevels(meta)
sample.ids <- intersect(rownames(meta),rownames(pc_data))
data <- data.frame(pc_data[sample.ids,1:2],group=meta[sample.ids,"combine_group"])
mycol <- c("#E31A1C","#1F78B4","#FCCDE5","#B3CDE3")
pdf(file=paste("AB_pcoa.pdf",sep=""),width=6,height=6,useDingbats=F)
s.classmd(data[,1:2],data$group,xax=1,yax=2,col = mycol,axesell=F,Labels=pc_percent,cpoint=2,grid=FALSE,cgrid = 0)
dev.off()
