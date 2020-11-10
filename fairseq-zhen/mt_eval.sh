data_bin=../data-bin
model_dir=../models
model=checkpoint_zh2en_CS.pt
beam=8
CUDA_VISIBLE_DEVICES=0 python translation.py $data_bin -s zh -t en \
    --path $model_dir/$model --beam $beam \
     --remove-bpe 


