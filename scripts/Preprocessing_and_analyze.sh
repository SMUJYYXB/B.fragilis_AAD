#!/bin/sh
usage(){
    echo "usage:sh `basename $0` fasta_dir metadata params_file output_dir"
}
if [ $# -ne 4 ]; then
    usage
    exit 1
fi
PWD1=${PWD};
#-------Prepare sequence file
mkdir $4;
cat $1/*.fasta > $4/total.fa &&
#--------Pre-processing
identify_chimeric_seqs.py -m usearch61 -i $4/total.fa -o $4/usearch61_chimerc_checking --reference_seqs_fp /usr/local/lib/python2.7/site-packages/qiime_default_reference/gg_13_8_otus/rep_set/97_otus.fasta &&
filter_fasta.py -f $4/total.fa -o $4/non_chimeric_seqs.fasta -s $4/usearch61_chimerc_checking/chimeras.txt -n &&
pick_closed_reference_otus.py -i $4/non_chimeric_seqs.fasta -p $3 -o $4/otus &&
single_rarefaction.py -i $4/otus/otu_table.biom -o $4/otu_table.36750.biom -d 36750 &&
biom convert -i $4/otu_table.36750.biom -o $4/otu_table.36750.biom.txt --to-tsv --table-type "OTU table" --header-key taxonomy &&
#--------Analyze
alpha_diversity.py -i $4/otu_table.36750.biom -o $4/adiv.txt -m shannon,chao1,PD_whole_tree,observed_otus -t /usr/local/lib/python2.7/site-packages/qiime_default_reference/gg_13_8_otus/trees/97_otus.tree &&
beta_diversity_through_plots.py -i $4/otu_table.36750.biom -m $2 -t /usr/local/lib/python2.7/site-packages/qiime_default_reference/gg_13_8_otus/trees/97_otus.tree -o $4/bdiv &&
summarize_taxa_through_plots.py -i $4/otu_table.36750.biom -m $2 -c combine_group -o $4/taxa_using_combine &&
#--------Group A vs Group B
filter_samples_from_otu_table.py -i $4/otu_table.36750.biom -o $4/AB_otu_table.36750.biom -m $2 -s 'Group:A,B' &&
alpha_diversity.py -i $4/AB_otu_table.36750.biom -o $4/AB_adiv.txt -m shannon,chao1,PD_whole_tree,observed_otus -t /usr/local/lib/python2.7/site-packages/qiime_default_reference/gg_13_8_otus/trees/97_otus.tree &&
beta_diversity_through_plots.py -i $4/AB_otu_table.36750.biom -m $2 -t /usr/local/lib/python2.7/site-packages/qiime_default_reference/gg_13_8_otus/trees/97_otus.tree -o $4/AB_bdiv &&
summarize_taxa_through_plots.py -i $4/AB_otu_table.36750.biom -m $2 -c combine_group -o $4/AB_taxa_using_combine;
#--------R plot
R --no-save < make_heatmap.r
R --no-save < 2D_PCoA.r
