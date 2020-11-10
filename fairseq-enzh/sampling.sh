
MODEL_PATH=~/checkpoints/ldc-baseline/checkpoint_best.pt

bleu=multi-bleu.perl
data_dir=~/ldc-bin
nist=~/nist



CUDA_VISIBLE_DEVICES=0 python interactive.py $data_dir --path $MODEL_PATH --beam 1 --sampling --remove-bpe -s ch -t en < $nist/nist02-bpe.in > sample &
