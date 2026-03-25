# GSEA
> An answer `md` file for Bioinformatics_Homework_Function_Analysis_GSEA

> Direct to [GSEA](#gsea-1), [fGSEA](#fgsea) quickly here.
---
### GSEA
* Load from files ([snapshot 1](./GSEA/GSEA.snapshots/1.png))
* Adjust arguments ([snapshot 2](./GSEA/GSEA.snapshots/2.png))
* Run ([snapshot 3](./GSEA/GSEA.snapshots/3.png))
* Acquire results ([snapshot 4](./GSEA/GSEA.snapshots/4.png))
  * View results in [`tsv`](./GSEA/GSEA.res.tsv), [enrichment plot](./GSEA/GSEA.res.enrichment_plot.png) or [ES distribution](./GSEA/GSEA.res.ES_dis.png)
![EP](./GSEA/GSEA.res.enrichment_plot.png)
![ESD](./GSEA/GSEA.res.ES_dis.png)

---
### fGSEA
* Create [`R` script](./fGSEA/fGSEA.script.R) for `fGSEA` analysis and data visualization
* Run [script](./fGSEA/fGSEA.script.R) and get results
  * View result in [`txt`](./fGSEA/fGSEA.res.txt) or [`png`](./fGSEA/fGSEA.res.plot.png) format
    > Note that `txt` file was processed with the following command

    ```bash
    sed -i 's/"//g' fGSEA.res.txt
    ```

![plot](./fGSEA/fGSEA.res.plot.png)

---