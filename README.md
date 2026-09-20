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
2. **Protein-protein interaction network** — constructed via STRING database 
   from significant DEGs (padj < 0.05, |log2FC| > 1)
3. **Network topology and hub identification** — Cytoscape, CytoHubba plugin 
   (Degree and Betweenness Centrality algorithms)
4. **Functional module detection** — MCODE clustering algorithm
5. **Functional enrichment analysis** — Gene Ontology (Biological Process) 
   and Reactome pathway analysis
6. **Druggability assessment** — DGIdb (Drug-Gene Interaction Database)

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
The results support an emerging pathogenic model in which chronic 
neuroinflammation — mediated by chemokine receptor signaling — actively 
contributes to selective vulnerability of GABAergic interneurons, rather 
than being a secondary consequence of neurodegeneration. CXCR4's dual role 
as an immune cell trafficking mediator and a direct neuromodulator makes it 
a candidate mechanistic link between these two processes.

## Repository Structure

## Requirements
R (≥ 4.3), Bioconductor packages: `DESeq2`, `org.Hs.eg.db`, 
. Network analysis performed in Cytoscape (≥ 3.9) with CytoHubba 
and MCODE plugins.

## References
1. [Meta-analysis paper identifying CXCR4 as hub gene] – Frontiers in Genetics, 2023
2. [PPI network study identifying CXCL12/CXCL8 as hub genes] – Genomics & Informatics, 2020
3. [Multi-algorithm topological analysis identifying CXCR4] – 2025

## Author
[Simone Marroni] 
