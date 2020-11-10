#!/bin/bash
#BSUB -q HPC.S1.GPU.X795.sha
#BSUB -gpu num=2:mode=exclusive_process
nohup bash transformer.sh > log 2>&1 & 
