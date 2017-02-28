##Commands used to download data from Kozich et al. paper links

Obtained the raw `fastq.gz` files from https://www.mothur.org/MiSeqDevelopmentData.html
​* Downloaded https://www.mothur.org/MiSeqDevelopmentData/StabilityNoMetaG.tar
​* Ran the following from the project's root directory
```bash
curl -LO https://www.mothur.org/MiSeqDevelopmentData/StabilityNoMetaG.tar
tar xvf StabilityNoMetaG.tar -C data/raw/
rm StabilityNoMetaG.tar



Obtained the silva reference alignment from the mothur website:
```bash
curl -LO http://mothur.org/w/images/1/15/Silva.seed_v123.tgz
tar xvzf Silva.seed_v123.tgz silva.seed_v123.align silva.seed_v123.tax
mothur "#get.lineage(fasta=silva.seed_v123.align, taxonomy=silva.seed_v123.tax, taxon=Bacteria);degap.seqs(fasta=silva.seed_v123.pick.align, processors=8)"
mv silva.seed_v123.pick.align data/references/silva.seed.align
rm Silva.seed_v123.tgz silva.seed_v123.*
rm mothur.*.logfile
`​``
Obtained the RDP reference taxonomy from the mothur website:
```bash
curl -LO http://www.mothur.org/w/images/8/88/Trainset14_032015.pds.tgz
tar xvzf Trainset14_032015.pds.tgz trainset14_032015.pds/trainset14_032015.pds.*
mv trainset14_032015.pds/* data/references/
rmdir trainset14_032015.pds
rm Trainset14_032015.pds.tgz
`​``


Obtained the MacOS X version of mothur (v1.39.3) from the mothur GitHub repository
```bash
curl -LO https://github.com/mothur/mothur/releases/download/v.1.39.3/Mothur.mac_64.OSX-10.12.zip
unzip Mothur.mac_64.OSX-10.12.zip
mv mothur code/
rm Mothur.mac_64.OSX-10.12.zip
rm -rf __MACOSX
`​``
mothur should output the version by doing...
```bash
code/mothur/mothur -v
`​``