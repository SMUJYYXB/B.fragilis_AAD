library(pheatmap)
meta <- read.table("aad.metadata.txt",header=T,sep="\t",row.names = 1,comment.char = "")
biom <- read.table("otu_table.36750.biom.txt",header=T,sep="\t",row.names = 1)
otu_tax<-biom[,ncol(biom)]
otu_id <- paste("OTU",rownames(biom),sep="")
biom <- biom[,-ncol(biom)]
print(class(biom))
#-----
if (length(otu_tax)!=0) {
  tax.16s <- otu_tax
  #remove the "[a-z]__" from the taxonomy
  tax.16s <- gsub("Other", "",tax.16s)
  tax.16s <- gsub("[a-z]__", "",tax.16s)
  #remove the " " from the taxonomy
  tax.16s <- gsub("; ", ';', tax.16s)
  #remove  "[" from the taxonomy
  #tax.16s <- gsub("\\[", '', tax.16s)
  #remove  "]" from the taxonomy
  #tax.16s <- gsub("\\]", '', tax.16s)
  #remove the last ";" from the taxonomy
  tax.16s <- gsub(";$", '', tax.16s)
  #remove the last ";" from the taxonomy
  tax.16s <- gsub(";$", '', tax.16s)
  #remove the last ";" from the taxonomy
  tax.16s <- gsub(";$", '', tax.16s)
  #remove the last ";" from the taxonomy
  tax.16s <- gsub(";$", '', tax.16s)
  #remove the last ";" from the taxonomy
  tax.16s <- gsub(";$", '', tax.16s)
  #remove the last ";" from the taxonomy
  tax.16s <- gsub(";$", '', tax.16s)
  #remove the last ";" from the taxonomy
  tax.16s <- gsub(";$", '', tax.16s)
  #get the last identified level from the taxa
  for(i in 1:length(tax.16s)){
    a<-length(grep(";",tax.16s[i]))
    if(a!=0){tax.16s[i]<-unlist(strsplit(tax.16s[i],";"))[length(unlist(strsplit(tax.16s[i],";")))]}
  }
}
newtax<-paste(otu_id,tax.16s,sep="_")
biom <- t(biom)
colnames(biom) <- newtax
#----------------All
sample.ids <- intersect(rownames(meta),rownames(biom))
data <- biom[sample.ids,]
data <- data[,order(-colSums(data))]
all <- meta[rownames(data),]
#rownames(data) <- all$ID
annotation_col = data.frame(group = all$combine_group,stage=all$stage)
rownames(annotation_col) <- rownames(data)
ann_colors <- list(stage=c(d11="#33A02C",d17="#B3DE69"),
                   group=c(d11_A="red2",d11_B="darkorange2",d11_C="yellow2",d11_D="green2",d11_E="turquoise1",d11_F="blue2",d11_G="magenta3",
                           d17_A="rosybrown2",d17_B="darkgoldenrod2",d17_C="lightgoldenrod2",d17_D="lightgreen",d17_E="lightcyan2",d17_F="skyblue2",d17_G="orchid2"))
pheatmap(t(data[,1:20]),cluster_cols = FALSE,fontsize_col = 9,annotation_col = annotation_col,annotation_colors = ann_colors,
          filename = "all_pheatmap.pdf",width = 13,height = 10)
#---------------Group A and Group B
meta <- subset(meta,Group=="A"|Group=="B")
meta <- droplevels(meta)
sample.ids <- intersect(rownames(meta),rownames(biom))
data1 <- biom[sample.ids,]
data1 <- data1[,order(-colSums(data1))]
AB <- meta[rownames(data1),]
#rownames(data1) <- AB$ID
annotation_col = data.frame(group = AB$combine_group,stage=AB$stage)
rownames(annotation_col) <- rownames(data1)
ann_colors <- list(stage=c(d11="#33A02C",d17="#B3DE69"),
                   group=c(d11_A="#E31A1C",d11_B="#1F78B4",d17_A="#FCCDE5",d17_B="#B3CDE3"))
pheatmap(t(data1[,1:20]),cluster_cols = FALSE,fontsize_col = 9,annotation_col = annotation_col,annotation_colors = ann_colors,
          filename = "AB_pheatmap.pdf",width = 10,height = 7)
