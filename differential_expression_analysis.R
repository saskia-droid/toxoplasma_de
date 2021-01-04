
# differential expression analysis

# run script exploratory_data_analysis
source("exploratory_data_analysis.R")

# lists the coefficients
resultsNames(dds)

# get differentially expressed genes
dds$group <- factor(paste0(dds$tissue, dds$condition)); dds$group
design(dds) <- ~ group
dds <- DESeq(dds)
resultsNames(dds)
# condition effect for lung
lung_res <- results(dds, contrast=c("group", "lunginfected", "lungcontrol"))
# condition effect for blood
#blood_res <- results(dds, contrast=c("group", "bloodinfected", "bloodcontrol"))

# How many genes are differentially expressed (DE)
# in the pairwise comparison you selected

sig <- lung_res[!is.na(lung_res$padj) & lung_res$padj < 0.05 & abs(lung_res$log2FoldChange) > 1,]; sig # -> 4994
up <- subset(sig, log2FoldChange > 0) # 1882
down <- subset(sig, log2FoldChange < 0) # 3112

# Tgtp1, ENSMUSG 00000078922
plotCounts(dds, gene = "ENSMUSG00000078922", intgroup = c("tissue", "condition"))

# Gbp5, ENSMUSG 00000105504
plotCounts(dds, gene = "ENSMUSG00000105504", intgroup = c("tissue", "condition"))

