# B.fragilis_AAD
Antibiotic-associated diarrhea (AAD) is characterized by the disruption of the gut microbiota. Accordingly, probiotics are routinely used to treat AAD, but the effectiveness of this treatment and the mechanisms by which probiotics alleviate symptoms remain poorly clarified. In this study, we demonstrated that rats exposed to adequate antibiotics developed diarrhea symptoms and exhibited microbiota alterations with overgrowth of some pathogenic bacteria.  Oral treatment with B. fragilis ameliorated AAD-related diarrhea symptoms and reversed specific microbial changes in AAD rats by increasing some commensal microbiota. 

## Introduction
Analysis pipeline for: Consumption of B. fragilis alters specific intestinal microbiota and protects against antibiotic-associated diarrhea in rats

### Copyright
       Copyright:     Prof. Hong-Wei Zhou   
     Institution:     State Key Laboratory of Organ Failure Research, Division of Laboratory Medicine, Zhujiang Hospital, Southern Medical University, Guangzhou, China, 510282   
           Email:     biodegradation@gmail.com   

      
### Author
         Author:     Wen-Li Tang, Xian Wang    
    Last update:     2017-10-10   
          Email:     1071429394@qq.com   
      
### Index
--------------------------------------------------------
1 Environment   
    1.1 System   
        1.1.1 System Platform   
        1.1.2 Hardware   
    1.2 R   
        1.2.1 R version   
        1.2.2 R libraries   
    1.3 Qiime   
        1.3.1 Qiime version   
        1.3.2 System information   
        1.3.3 QIIME default reference information   
        1.3.4 QIIME config values   
    
2 Demo data   
    2.1 sequences   
    2.2 metadata   
    
3 Scripts   
    3.1 Shell Scripts   
    3.2 R Scripts   
    
4 Supplementary files   
    4.1 aad.metadata.txt   
    4.2 closedref.params.txt   
    4.3 otu_table.36750.biom.txt
    
5 Direction for use   


# 1 Environment

## 1.1 System
-------------------------------------------------------
### 1.1.1 System Platform
-------------------------------------------------------
    Platform:      Linux2 
     Version:      Linux version 2.6.32-573.8.1.el6.x86_64 (mockbuild@c6b8.bsys.dev.centos.org) (gcc version 4.4.7 20120313 (Red Hat 4.4.7-16)(GCC))
          OS:      CentOS release 6.7 (Final)
--------------------------------------------------------
### 1.1.2 Hardware
--------------------------------------------------------
         Cpu(s):      >2
         thread:      >1
            RAM:      >10G
      Hard disk:      >20G
--------------------------------------------------------

## 1.2 R
-------------------------------------------------------
### 1.2.1 R version
-------------------------------------------------------
        Version:      R version 3.2.2(2015-08-14)
      Copyright:      (C) 2015 The R Foundation for Statistical Computing
--------------------------------------------------------
### 1.2.2 R libraries
-------------------------------------------------------
      pheatmap
      ade4
--------------------------------------------------------
## 1.3 Qiime
--------------------------------------------------------
### 1.3.1 Qiime version
--------------------------------------------------------
      Version:      qiime 1.9.1
--------------------------------------------------------
### 1.3.2 System information
--------------------------------------------------------
               Platform:      Linux2
         Python version:      2.7.10 (default, Dec  4 2015, 15:36:19)  [GCC 4.4.7 20120313 (Red Hat 4.4.7-16)]
      Python executable:      /usr/local/bin/python
--------------------------------------------------------
### 1.3.3 QIIME default reference information
--------------------------------------------------------
    For details on what files are used as QIIME's default references, see here:
    https://github.com/biocore/qiime-default-reference/releases/tag/0.1.3
--------------------------------------------------------
              QIIME library version:      1.9.1
               QIIME script version:      1.9.1
    qiime-default-reference version:      0.1.3
                      NumPy version:      1.11.0
                      SciPy version:      0.17.1
                     pandas version:      0.17.1
                 matplotlib version:      1.4.3
                biom-format version:      2.1.5
                       qcli version:      0.1.1
                       pyqi version:      0.3.2
                 scikit-bio version:      0.2.3
                     PyNAST version:      1.2.2
                    Emperor version:      0.9.51
                    burrito version:      0.9.1
           burrito-fillings version:      0.1.1
                  sortmerna version:      SortMeRNA version 2.0, 29/11/2014
                  sumaclust version:      SUMACLUST Version 1.0.00
                      swarm version:      Swarm 1.2.19 [Dec  5 2015 16:48:11]
                              gdata:      Installed.
--------------------------------------------------------
### 1.3.4 QIIME config values
--------------------------------------------------------
    For definitions of these settings and to learn how to configure QIIME, see here:
    http://qiime.org/install/qiime_config.html
    http://qiime.org/tutorials/parallel_qiime.html

    QIIME config values

    For definitions of these settings and to learn how to configure QIIME, see here:
    http://qiime.org/install/qiime_config.html
    http://qiime.org/tutorials/parallel_qiime.html

                          blastmat_dir:      None
           pick_otus_reference_seqs_fp:      /usr/local/lib/python2.7/site-packages/qiime_default_reference/gg_13_8_otus/rep_set/97_otus.fasta
                         python_exe_fp:      python
                              sc_queue:      all.q
           topiaryexplorer_project_dir:      None
          pynast_template_alignment_fp:      /usr/local/data/core_set_aligned.fasta.imputed
                       cluster_jobs_fp:      None
     pynast_template_alignment_blastdb:      None
     assign_taxonomy_reference_seqs_fp:      /usr/local/lib/python2.7/site-packages/qiime_default_reference/gg_13_8_otus/rep_set/97_otus.fasta
                          torque_queue:      friendlyq
                   qiime_test_data_dir:      None
        template_alignment_lanemask_fp:      /usr/local/data/lanemask_in_1s_and_0s.txt
                         jobs_to_start:      1
                            slurm_time:      None
                     cloud_environment:      False
                     qiime_scripts_dir:      /usr/local/bin
                 denoiser_min_per_core:      50
                           working_dir:      None
     assign_taxonomy_id_to_taxonomy_fp:      /usr/local/lib/python2.7/site-packages/qiime_default_reference/gg_13_8_otus/taxonomy/97_otu_taxonomy.txt
                              temp_dir:      /tmp/
                          slurm_memory:      None
                           slurm_queue:      None
                           blastall_fp:      blastall
                      seconds_to_sleep:      2
--------------------------------------------------------

# 2 Demo data

--------------------------------------------------------
## 2.1 sequences
--------------------------------------------------------
     format of sequences :      fasta
       Number of fa files:      84
             fa_filenames:      d11.A1.fasta
                                d11.A2.fasta
                                d11.A3.fasta
                                d11.A4.fasta
                                d11.A5.fasta
                                d11.A6.fasta
                                d11.B1.fasta
                                d11.B2.fasta
                                d11.B3.fasta
                                d11.B4.fasta
                                d11.B5.fasta
                                d11.B6.fasta
                                d11.C1.fasta
                                d11.C2.fasta
                                d11.C3.fasta
                                d11.C4.fasta
                                d11.C5.fasta
                                d11.C6.fasta
                                d11.D1.fasta
                                d11.D2.fasta
                                d11.D3.fasta
                                d11.D4.fasta
                                d11.D5.fasta
                                d11.D6.fasta
                                d11.E1.fasta
                                d11.E2.fasta
                                d11.E3.fasta
                                d11.E4.fasta
                                d11.E5.fasta
                                d11.E6.fasta
                                d11.F1.fasta
                                d11.F2.fasta
                                d11.F3.fasta
                                d11.F4.fasta
                                d11.F5.fasta
                                d11.F6.fasta
                                d11.G1.fasta
                                d11.G2.fasta
                                d11.G3.fasta
                                d11.G4.fasta
                                d11.G5.fasta
                                d11.G6.fasta
                                d17.A1.fasta
                                d17.A2.fasta
                                d17.A3.fasta
                                d17.A4.fasta
                                d17.A5.fasta
                                d17.A6.fasta
                                d17.B1.fasta
                                d17.B2.fasta
                                d17.B3.fasta
                                d17.B4.fasta
                                d17.B5.fasta
                                d17.B6.fasta
                                d17.C1.fasta
                                d17.C2.fasta
                                d17.C3.fasta
                                d17.C4.fasta
                                d17.C5.fasta
                                d17.C6.fasta
                                d17.D1.fasta
                                d17.D2.fasta
                                d17.D3.fasta
                                d17.D4.fasta
                                d17.D5.fasta
                                d17.D6.fasta
                                d17.E1.fasta
                                d17.E2.fasta
                                d17.E3.fasta
                                d17.E4.fasta
                                d17.E5.fasta
                                d17.E6.fasta
                                d17.F1.fasta
                                d17.F2.fasta
                                d17.F3.fasta
                                d17.F4.fasta
                                d17.F5.fasta
                                d17.F6.fasta
                                d17.G1.fasta
                                d17.G2.fasta
                                d17.G3.fasta
                                d17.G4.fasta
                                d17.G5.fasta
                                d17.G6.fasta
--------------------------------------------------------
## 2.2 metadata
--------------------------------------------------------
     Filename:       aad.metadata.txt
       Header:       #SampleID	Group	Group(Full Name)	stage	combine_group
    Row.names:       84 SampleIDs
--------------------------------------------------------


# 3 Scripts

--------------------------------------------------------
## 3.1 Shell Scripts
--------------------------------------------------------
### 3.1.1 Preprocessing_and_analyze.sh
--------------------------------------------------------
         Function:      Pipline of preprocessing and diversity analysis, this script performs all processing steps through building the OTU table with several fasta file.
      Last updata:      2017-10-09
           Author:      Wenli Tang
--------------------------------------------------------

## 3.2 R Scripts
--------------------------------------------------------
#### 3.2.1 make_heatmap.r
--------------------------------------------------------
         Function:      Make heatmap using otu table calculated by QIIME.
         Location:      Called by the script--Preprocessing_and_analyze.sh
      Last updata:      2017-10-09
           Author:      Wenli Tang
--------------------------------------------------------
#### 3.2.2 2D_PCoA.r
--------------------------------------------------------
         Function:      Make 2D PCoA using dm file and pc file calculated by QIIME.
         Location:      Called by the script--Preprocessing_and_analyze.sh
      Last updata:      2017-10-09
           Author:      Wenli Tang
--------------------------------------------------------
#### 3.2.3 s.classmd.R
--------------------------------------------------------
         Function:      Modify axis of s.class function (ade4 package).
         Location:      Called by the script--2D_PCoA.r
      Last updata:      2017-05-25
           Author:      Xian Wang
--------------------------------------------------------


# 4 Supplementary files
--------------------------------------------------------
## 4.1 aad.metadata.txt
--------------------------------------------------------
        Supplementary file of Preprocessing_and_analyze.sh,make_heatmap.r and 2D_PCoA.r
--------------------------------------------------------

## 4.2 closedref.params.txt
--------------------------------------------------------
        Supplementary file of Preprocessing_and_analyze.sh 
--------------------------------------------------------

## 4.3 otu_table.36750.biom.txt
--------------------------------------------------------
        Supplementary file of make_heatmap.r 
--------------------------------------------------------


# 5 Direction for use
--------------------------------------------------------
## 5.1 Configuring the system environment files and variables
--------------------------------------------------------
       Configuring the system environment files and variables based on the (1) Environment
--------------------------------------------------------

## 5.2 Location of the files
--------------------------------------------------------
      put the scripts and supplementary files in the same path
      put all fasta files in the same path
--------------------------------------------------------

## 5.3  modify Preprocessing_and_analyze.sh 
--------------------------------------------------------
### 5.3.1  modify Preprocessing_and_analyze.sh 
--------------------------------------------------------
             line 17:   get the path of 97_otus.fasta,such as /usr/local/lib/python2.7/sitepackages/qiime_default_reference/gg_13_8_otus/rep_set/97_otus.fasta
    line 23,24,28,29:   get the path of 97_otus.tree, such as /usr/local/lib/python2.7/site-packages/qiime_default_reference/gg_13_8_otus/trees/97_otus.tree
--------------------------------------------------------
### 5.3.2  modify 2D_PCoA.r 
--------------------------------------------------------
    line 59:   get the path of beta diversity(all samples), such as output/bdiv/unweighted_unifrac
    line 73:   get the path of beta diversity(samples of Group A and B ), such as output/AB_bdiv/unweighted_unifrac
--------------------------------------------------------

## 5.4 Run pipeline
--------------------------------------------------------
### 5.4.1 Preprocessing: From raw sequences to BIOM and diversity analysis
-------------------------------------------------------- 
     sh Preprocessing_and_analyze.sh <fasta_dir> <metadata> <params_file> <output_dir> 
     <fasta_dir>: Path to the folder containing all fasta files.
     <metadata>: Path to metadata file.
     <params_file>:Path to the parameter file.
     <output_dir>: The output directory.
     # nohup sh Preprocessing_and_analyze.pl <fasta_dir> <metadata> <params_file> <output_dir> > analyze.log 2>&1 &
