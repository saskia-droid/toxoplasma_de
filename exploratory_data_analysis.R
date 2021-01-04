
# exploratory data analysis

# clear environment
rm(list = ls())

# install, load libraries

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("DESeq2")

library(DESeq2)
library(pheatmap)
library(RColorBrewer)

# import featureCounts.txt
fc_data <- read.table("/Users/saskia/unibe19/RNA-sequencing/project/featureCounts/featureCounts.txt",
                      sep='\t', header = TRUE)

# transform the dataframe into a matrix
count_matrix <- as.matrix(fc_data);

rm(fc_data)

# remove columns that we don't need
count_matrix <- count_matrix[, -c(2, 3, 4, 5, 6)];

# transforming first column in row labels
rownames(count_matrix) <- count_matrix[,1]
count_matrix <- count_matrix[, -1]

class(count_matrix) <- "numeric"

# changing colnames of the count_matrix
for ( col in 1:ncol(count_matrix)){
  colnames(count_matrix)[col] <-  sub("X.data.courses.rnaseq.toxoplasma_de.mapping.", "", colnames(count_matrix)[col], fixed = TRUE)
  colnames(count_matrix)[col] <-  sub(".sorted.bam", "", colnames(count_matrix)[col], fixed = TRUE)
}

# create coldata matrix

samples <- colnames(count_matrix); samples

condition <- c("infected", "infected", "infected", "infected", "infected",
               "control", "control", "control",
               "infected", "infected", "infected", "infected", "infected",
               "control", "control", "control"); condition

tissue <- c("lung", "lung", "lung", "lung", "lung", "lung", "lung", "lung",
            "blood", "blood", "blood", "blood", "blood", "blood", "blood",
            "blood"); tissue

coldata <- cbind(samples, condition, tissue); coldata
rownames(coldata) <- coldata[,1]; coldata
coldata <- coldata[, -1]; coldata

# create DESeq object
dds <- DESeqDataSetFromMatrix(countData = count_matrix,
                              colData = coldata,
                              design = ~ condition + tissue)

# run DESeq
dds <- DESeq(dds)

# to remove the dependence of the variance on the mean
# variance stabilizing transformations (VST)

vsd <- vst(dds, blind=TRUE)
#head(assay(vsd))

# PCA
print(plotPCA(vsd, intgroup=c("condition", "tissue")))

# heatmap

# colors of the heat map
hmcolor <- colorRampPalette(brewer.pal(9, "GnBu"))(100)
ann_color = list(
  condition = c(infected = "darkorchid4", control = "darkorchid1"),
  tissue = c(lung = "deeppink2", blood = "deeppink4")
)

select <- order(rowMeans(counts(dds,normalized=TRUE)),
                decreasing=TRUE)[1:20]

df <- as.data.frame(colData(dds)[,c("condition","tissue")])

pheatmap(assay(vsd)[select,], color = hmcolor, border_color = NA,
         cluster_rows=FALSE, cluster_cols=FALSE,
         annotation_col=df, annotation_colors = ann_color,
         show_rownames = TRUE)

