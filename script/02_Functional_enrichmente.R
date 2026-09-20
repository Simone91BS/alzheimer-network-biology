# =============================================================
# Alzheimer's Disease - Functional Enrichment Analysis
# Input: gene lists exported from Cytoscape (MCODE cluster)
# =============================================================

library(clusterProfiler)
library(org.Hs.eg.db)
library(ReactomePA)

# --- 1. Define cluster gene lists (from MCODE output) ---
# Upregulated: chemokine/neuroinflammatory sub-module
cluster_UP <- c("CXCL8", "CXCR4", "CCR2", "CXCR3", "IL7R")

# Downregulated: GABAergic/neurotrophic sub-module
cluster_DOWN <- c("GAD1", "SST", "CRH", "SLC32A1", "BDNF")

# --- 2. GO Biological Process enrichment ---
ego_UP <- enrichGO(gene = cluster_UP,
                    OrgDb = org.Hs.eg.db,
                    keyType = "SYMBOL",
                    ont = "BP",
                    pAdjustMethod = "BH",
                    pvalueCutoff = 0.05)

ego_DOWN <- enrichGO(gene = cluster_DOWN,
                      OrgDb = org.Hs.eg.db,
                      keyType = "SYMBOL",
                      ont = "BP",
                      pAdjustMethod = "BH",
                      pvalueCutoff = 0.05)

# --- 3. Reactome pathway enrichment ---
# convert symbols to Entrez ID (required by ReactomePA)
entrez_UP <- mapIds(org.Hs.eg.db, keys = cluster_UP, column = "ENTREZID",
                     keytype = "SYMBOL", multiVals = "first")
entrez_DOWN <- mapIds(org.Hs.eg.db, keys = cluster_DOWN, column = "ENTREZID",
                       keytype = "SYMBOL", multiVals = "first")

reactome_UP <- enrichPathway(gene = na.omit(entrez_UP), organism = "human",
                              pAdjustMethod = "BH", pvalueCutoff = 0.05)

reactome_DOWN <- enrichPathway(gene = na.omit(entrez_DOWN), organism = "human",
                                pAdjustMethod = "BH", pvalueCutoff = 0.05)

# --- 4. Export results ---
write.csv(as.data.frame(ego_UP), "results/tables/GO_upregulated.csv", row.names = FALSE)
write.csv(as.data.frame(ego_DOWN), "results/tables/GO_downregulated.csv", row.names = FALSE)
write.csv(as.data.frame(reactome_UP), "results/tables/Reactome_upregulated.csv", row.names = FALSE)
write.csv(as.data.frame(reactome_DOWN), "results/tables/Reactome_downregulated.csv", row.names = FALSE)
