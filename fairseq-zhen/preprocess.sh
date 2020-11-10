#!/bin/bash
#BSUB -q HPC.S1.GPU.X785.sha
#BSUB -n 1
data=~/hazhang/datas/zhen.all.75
python fairseq_cli/preprocess.py --source-lang zh \
                    --target-lang en \
                    --trainpref $data/train.bpe \
                    --validpref $data/valid.bpe \
                    --testpref $data/test.bpe \
                    --destdir $data/data-bin \
		            --workers 80
                    #--srcdict /data1/hfyu/Summarization-model/Rush/rush-32k-data-bin/dict.src.txt \
                    #--tgtdict /data1/hfyu/Summarization-model/Rush/rush-32k-data-bin/dict.tgt.txt
                    #--nwordstgt 50000 \
                    #--nwordssrc 50000 \
					#--testpref /data/hazhang/data-ldc-no-unk/test \

