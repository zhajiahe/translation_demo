
#data_bin=/data1/hfyu/Summarization-model/Rush/rush-32k-data-bin/
#data_bin=/data1/hfyu/Summarization-data/rush-32k-independent/10-sentences-example/data-bin
num=1,2,3
dropout=0.3
arch=lstm
max_tokens=5000
criterion=label_smoothed_cross_entropy
label_smoothing=0.1
lrscheduler=inverse_sqrt
#forceanneal=102
save_dir=~/checkpoints/lstm-baseline
#restore_file=checkpoint34.pt
data_bin=~/ldc-bin
train(){
CUDA_VISIBLE_DEVICES=$num python train.py $data_bin \
                        --optimizer adam \
                        --min-lr  1e-09 \
                        --lr  0.0005\
                        --clip-norm 0.0 \
                        --criterion $criterion \
                        --label-smoothing $label_smoothing \
                        --lr-scheduler $lrscheduler \
			            -s ch -t en \
                        --dropout $dropout \
                        --arch $arch \
                        --warmup-init-lr 1e-07 \
                        --warmup-updates 4000 \
                        --weight-decay 0.0 \
                        --adam-betas '(0.9, 0.98)' \
                        --max-tokens $max_tokens \
                        --save-dir $save_dir \
                        --max-epoch 40 \
                        --encoder-dropout-out 0.5 \
                        --decoder-dropout-out 0.5 \
#                        --share-all-embeddings \
#                        --restore-file $restore_file

#cp out $save_dir
}

#process
train
