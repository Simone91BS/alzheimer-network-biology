# alzheimer-network-biology
netowork biology analysis identifying CXCR4 as hub gene in Alzheimer's disease.
# Network Biology Analysis of Alzheimer's Disease

## Overview
This project applies a network biology framework to RNA-seq data from 
post-mortem human brain tissue (fusiform gyrus) to identify central genes 
in the molecular architecture of Alzheimer's disease (AD). The analysis 
integrates differential gene expression, protein-protein interaction (PPI) 
network topology, functional module detection, and cross-validation against 
independently published studies.

## Dataset
- **Source**: [GSE125583](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE125583) (Gene Expression Omnibus)
- **Origin**: Genentech
- **Samples**: 289 total (219 AD, 70 age-matched controls)
- **Tissue**: Fusiform gyrus, post-mortem
- **Technology**: RNA-sequencing

## Methodology
1. **Differential expression analysis** — DESeq2 (R/Bioconductor), with 
   explicit reference-level validation against known AD-associated genes 
   (e.g., GFAP) to confirm correct comparison directionality
2. Sex was included as a covariate following PCA-based identification 
     of sex-driven variance independent of disease status; key findings 
     (GFAP, CXCR4) remained robust after this correction
3. **Protein-protein interaction network** — constructed via STRING database 
   from significant DEGs (padj < 0.05, |log2FC| > 1)
4. **Network topology and hub identification** — Cytoscape, CytoHubba plugin 
   (Degree and Betweenness Centrality algorithms)
5. **Functional module detection** — MCODE clustering algorithm
6. **Functional enrichment analysis** — Gene Ontology (Biological Process) 
   and Reactome pathway analysis
7. **Druggability assessment** — DGIdb (Drug-Gene Interaction Database)

## Key Findings
- Identification of a single, functionally coherent network module 
  comprising two interconnected sub-programs:
  - **Upregulated**: chemokine/neuroinflammatory signaling (CXCL8, CXCR4, 
    CCR2, CXCR3, IL7R)
  - **Downregulated**: GABAergic neurotransmission and neurotrophic support 
    (GAD1, SST, SLC32A1, BDNF, CRH)
- **CXCR4** identified as a hub-bottleneck node (high degree and high 
  betweenness centrality), bridging the neuroinflammatory and neuronal 
  sub-modules
- This finding **independently converges** with at least three previously 
  published PPI network studies on Alzheimer's disease, which identified 
  CXCR4 (or its ligand CXCL12) as a central hub gene using different 
  datasets and methodologies (see References)

## Biological Interpretation
CXCR4/CXCL12 signaling has an established role in the developmental 
migration and laminar positioning of somatostatin-, calretinin-, and 
neuropeptide Y-expressing cortical GABAergic interneurons. This project 
proposes that this axis — already mechanistically linked to the 
establishment of GABAergic circuits during development — may become 
aberrantly reactivated in a neuroinflammatory context in adult AD, 
contributing to the selective vulnerability of the same interneuron 
population it helps establish during development. This connection is 
grounded in established developmental neuroscience; its extension to 
adult neurodegeneration is proposed here as a data-driven, testable 
hypothesis, not a demonstrated mechanism in the AD literature reviewed.

## Repository Structure

## Requirements
R (≥ 4.3), Bioconductor packages: `DESeq2`, `org.Hs.eg.db`, 
. Network analysis performed in Cytoscape (≥ 3.9) with CytoHubba 
and MCODE plugins.

## References
1. Frontiers in Genetics (2023) – Meta-analysis of microarray datasets 
   identifying biological regulatory networks in Alzheimer's disease.
   https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10497115/
2. Genomics & Informatics (2020) – Prediction of hub genes of 
   Alzheimer's disease using a protein interaction network and 
   functional enrichment analysis.
   https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7808865/
3. Multi-algorithm topological PPI analysis identifying CXCR4 as an 
   AD hub gene (2025).
   https://pmc.ncbi.nlm.nih.gov/articles/PMC12307957
4. Tanaka et al. (2010) – CXCR4 is required for proper regional and 
   laminar distribution of cortical somatostatin-, calretinin-, and 
   neuropeptide Y-expressing GABAergic interneurons. Cerebral Cortex.
   https://academic.oup.com/cercor/article/20/12/2810/362255
5. Volk & Lewis (2015) – Chemokine receptors and cortical interneuron 
   dysfunction in schizophrenia.
   https://pmc.ncbi.nlm.nih.gov/articles/PMC4427549/

## Author
[Simone Marroni] [BSc in Biological Sciences,currently MSc student in 
Advanced Biotechnologies.   ] [simone.marroni@outlook.it]
