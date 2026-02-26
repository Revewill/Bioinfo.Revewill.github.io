### $ `wc -l test_command.gtf`

8 test_command.gtf

### $ `wc -c test_command.gtf`

636 test_command.gtf

### $ `grep '^chr_.*gene_id "YDL248W"' test_command.gtf`

chr_IV	ensembl gene	1802	2953	.	+	.	gene_id "YDL248W"; gene_version "1";

chr_IV	ensembl transcript	802	2953	.	+	.	gene_id "YDL248W"; gene_version "1";

chr_IV	ensembl start_codon	1802	1804	.	+	0	gene_id "YDL248W"; gene_version "1";

### $ `sed 's/chr_/chromosome_/g' test_command.gtf` | `awk '{printf $1"\t"$3"\t"$4"\t"$5"\n"}'` | `column -t`

chromosome_IV  gene	    1802  2953

chromosome_IV  transcript   802   2953

chromosome_IV  exon	    1802  2953

chromosome_IV  CDS	    1802  950

chromosome_IV  start_codon  1802  1804

chromosome_IV  stop_codon   2951  2953

chromosome_IV  gene	    762   3836

chromosome_IV  transcript   3762  836

### $ `man awk`

### $ `awk` `'{`

### /> `for(i=1;i<=NF;i++){`

### /> `if(i==2) printf "%s\t", $3`

### /> `else if(i==3) printf "%s\t", $2`

### /> `else printf "%s\t", $i`

### /> `}`

### /> `printf "\n"`

### /> `}'` `test_command.gtf` | `column -t`

chr_IV	       gene	    ensembl  1802  2953  .  +  .  gene_id  "YDL248W";	 gene_version  "1";

chr_IV	       transcript   ensembl  802   2953  .  +  .  gene_id  "YDL248W";	 gene_version  "1";

chromosome_IV  exon	    ensembl  1802  2953  .  +  .  gene_id  "YDL248W";	 gene_version  "1";

chromosome_IV  CDS	    ensembl  1802  950	 .  +  0  gene_id  "YDL248W";	 gene_version  "1";

chr_IV	       start_codon  ensembl  1802  1804  .  +  0  gene_id  "YDL248W";	 gene_version  "1";

chromosome_IV  stop_codon   ensembl  2951  2953  .  +  0  gene_id  "YDL248W";	 gene_version  "1";

chromosome_IV  gene	    ensembl  762   3836  .  +  .  gene_id  "YDL247W-A";  gene_version  "1";

chr_IV	       transcript   ensembl  3762  836	 .  +  .  gene_id  "YDL247W-A";  gene_version  "1";

### $ `awkA` `'{`

### /> `for(i=1;i<=NF;i++){`

### /> `if(i==2) printf "%s\t", $3`

### /> `else if(i==3) printf "%s\t", $2`

### /> `else printf "%s\t", $i`

### /> `}`

### /> `printf "\n"`

### /> `}'` `test_command.gtf` | `column -t` | `sort -k4,4n -k5,5n`

chromosome_IV  gene	    ensembl  762   3836  .  +  .  gene_id  "YDL247W-A";  gene_version  "1";

chr_IV	       transcript   ensembl  802   2953  .  +  .  gene_id  "YDL248W";	 gene_version  "1";

chromosome_IV  CDS	    ensembl  1802  950	 .  +  0  gene_id  "YDL248W";	 gene_version  "1";

chr_IV	       start_codon  ensembl  1802  1804  .  +  0  gene_id  "YDL248W";	 gene_version  "1";

chr_IV	       gene	    ensembl  1802  2953  .  +  .  gene_id  "YDL248W";	 gene_version  "1";

chromosome_IV  exon	    ensembl  1802  2953  .  +  .  gene_id  "YDL248W";	 gene_version  "1";

chromosome_IV  stop_codon   ensembl  2951  2953  .  +  0  gene_id  "YDL248W";	 gene_version  "1";

chr_IV	       transcript   ensembl  3762  836	 .  +  .  gene_id  "YDL247W-A";  gene_version  "1";

### $ `awk` `'{`

### /> `for(i=1;i<=NF;i++){`

### /> `if(i==2) printf "%s\t", $3`

### /> `else=if(i==3)tprintft"%s\t",$2`

### /> `else printf "%s\t", $i`

### /> `}`

### /> `printf "\n"`

### /> `}'` `test_command.gtf` | `column -t` | `sort -k4,4n -k5,5n` > `result.gtf`

### $ `cat result.gtf`

chromosome_IV  gene	    ensembl  762   3836  .  +  .  gene_id  "YDL247W-A";  gene_version  "1";

chr_IV	       transcript   ensembl  802   2953  .  +  .  gene_id  "YDL248W";	 gene_version  "1";

chromosome_IV  CDS	    ensembl  1802  950	 .  +  0  gene_id  "YDL248W";	 gene_version  "1";

chr_IV	       start_codon  ensembl  1802  1804  .  +  0  gene_id  "YDL248W";	 gene_version  "1";

chr_IV	       gene	    ensembl  1802  2953  .  +  .  gene_id  "YDL248W";	 gene_version  "1";

chromosome_IV  exon	    ensembl  1802  2953  .  +  .  gene_id  "YDL248W";	 gene_version  "1";

chromosome_IV  stop_codon   ensembl  2951  2953  .  +  0  gene_id  "YDL248W";	 gene_version  "1";

chr_IV	       transcript   ensembl  3762  836	 .  +  .  gene_id  "YDL247W-A";  gene_version  "1";

### $ `chmod 774 test_command.gtf`

### $ `ls -lh test_command.gtf`

-rwxrwxr-- 1 test test 636 Feb 26 05:52 test_command.gtf

### $ `exit`
