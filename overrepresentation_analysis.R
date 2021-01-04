
# overrepresentation analysis

source("differential_expression_analysis.R")

# install and load libraries
BiocManager::install("clusterProfiler")
BiocManager::install("org.Mm.eg.db")
library(clusterProfiler)
library(org.Mm.eg.db)
library(enrichplot)

genes <- row.names(sig)
universe <- row.names(lung_res)

ego <- clusterProfiler::enrichGO( gene          = genes,
                                  universe      = universe,
                                  OrgDb         = org.Mm.eg.db,
                                  ont           = "BP", # biological process
                                  pAdjustMethod = "BH",
                                  pvalueCutoff  = 0.01,
                                  qvalueCutoff  = 0.05,
                                  readable      = TRUE,
                                  keyType       = 'ENSEMBL')
head(ego)

dotplot(ego, showCategory=20)
