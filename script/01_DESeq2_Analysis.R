# =============================================================
# Alzheimer's Disease - Differential Expression Analysis
# Dataset: GSE125583 (Genentech) - Fusiform gyrus, AD vs control
# =============================================================

library(DESeq2)
library(GEOquery)
library(org.Hs.eg.db)

# --- 1. Load raw counts and metadata ---
counts_data <- read.delim("GSE125583_raw_counts_GRCh38.p13_NCBI.tsv.gz",
                           row.names = 1, check.names = FALSE)

gse_meta <- getGEO(filename = "GSE125583_series_matrix.txt.gz")
pheno_data <- pData(gse_meta)

# --- 2. Align sample order between counts and metadata ---
pheno_data_ordered <- pheno_data[colnames(counts_data), ]
stopifnot(all(rownames(pheno_data_ordered) == colnames(counts_data)))

# rename diagnosis column for convenience
colnames(pheno_data_ordered)[colnames(pheno_data_ordered) == "diagnosis:ch1"] <- "diagnosis"

# --- 3. Build DESeq2 object ---
dds <- DESeqDataSetFromMatrix(countData = counts_data,
                               colData = pheno_data_ordered,
                               design = ~ diagnosis)

# set "control" as reference level (critical for correct fold-change direction)
dds$diagnosis <- relevel(factor(dds$diagnosis), ref = "control")

# --- 4. Filter low-count genes ---
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep, ]

# --- 5. Run differential expression analysis ---
dds <- DESeq(dds)
res <- results(dds)

# --- 6. Validate comparison direction against known AD marker (GFAP) ---
res["2670", c("log2FoldChange", "padj")]  # GFAP Entrez ID; expect positive logFC

# --- 7. Filter significant DEGs ---
sig_genes <- res[which(res$padj < 0.05 & abs(res$log2FoldChange) > 1), ]

# --- 8. Convert Entrez ID to gene symbol ---
sig_genes$symbol <- mapIds(org.Hs.eg.db,
                            keys = rownames(sig_genes),
                            column = "SYMBOL",
                            keytype = "ENTREZID",
                            multiVals = "first")
sig_genes <- sig_genes[!is.na(sig_genes$symbol), ]

# remove unannotated loci (LOC identifiers)
sig_genes_clean <- sig_genes[!grepl("^LOC", sig_genes$symbol), ]

# --- 9. Export for STRING network construction ---
write.csv(as.data.frame(sig_genes_clean)[, c("symbol", "log2FoldChange")],
          "AD_logFC_for_cytoscape.csv", row.names = FALSE)
