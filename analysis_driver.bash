#!/usr/bin/env bash

#Driver script to run the entire analysis


# Download the raw data and put them into the data/raw directory
curl -LO https://www.mothur.org/MiSeqDevelopmentData/StabilityNoMetaG.tar
tar xvf StabilityNoMetaG.tar -C data/raw/
rm StabilityNoMetaG.tar

# Download the SILVA reference file (v.123). We will pull out the bacteria-specific sequences and
# clean up the directories to remove the extra files
curl -LO http://mothur.org/w/images/1/15/Silva.seed_v123.tgz
tar xvzf Silva.seed_v123.tgz silva.seed_v123.align silva.seed_v123.tax
code/mothur/mothur "#get.lineage(fasta=silva.seed_v123.align, taxonomy=silva.seed_v123.tax, taxon=Bacteria);degap.seqs(fasta=silva.seed_v123.pick.align, processors=8)"
mv silva.seed_v123.pick.align data/references/silva.seed.align
rm Silva.seed_v123.tgz silva.seed_v123.*
rm mothur.*.logfile

# Download the RDP taxonomy references (v14), put the necessary files in data/references, and
# clean up the directories to remove the extra files
curl -LO http://www.mothur.org/w/images/8/88/Trainset14_032015.pds.tgz
tar xvzf Trainset14_032015.pds.tgz trainset14_032015.pds/trainset14_032015.pds.*
mv trainset14_032015.pds/* data/references/
rmdir trainset14_032015.pds
rm Trainset14_032015.pds.tgz

# Generate a customized version of the SILVA reference database that targets the V4 region
code/mothur/mothur "#pcr.seqs(fasta=data/references/silva.seed.align, start=11894, end=25319, keepdots=F, processors=8)"
mv data/references/silva.seed.pcr.align data/references/silva.v4.align


# Run mothur through the various quality control steps and generate fully curated sequences
code/mothur/mothur code/get_good_seqs.batch

# Run mock community data through mothur to calculate the sequencing error rates
code/mothur/mothur code/get_error.batch

#Generate the shared files
code/mothur/mothur code/get_shared_otus.batch

#Generate the nmds.axes file from our data
code/mothur/mothur code/get_nmds_data.batch

#Run Rscript to make nmds plot
R -e "source('code/plot_nmds.R'); plot_nmds('data/mothur/stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.opti_mcc.thetayc.0.03.lt.ave.nmds.axes')"


