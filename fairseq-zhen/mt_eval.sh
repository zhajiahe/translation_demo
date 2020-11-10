data_bin=../data-bin
model=checkpoint_news.pt
beam=8
CUDA_VISIBLE_DEVICES=0 python translation.py $data_bin -s zh -t en \
    --path checkpoints/$model --beam $beam \
     --remove-bpe 


