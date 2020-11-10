# translation_demo
This is a simple online translation system, which is build on fairseq(0.9.0).
## Requirement
- python 3
- fairseq 0.9.0
- fastBPE : for applybpe
- jieba : for chinese segmentation
- mosesdecoder : for preprocess and post process
- jionlp : for data process 
## Instruction for components
- data-bin : Model vocabulary, Bpe codes
- fairseq-zhen : fairseq original file 
- models : Model checkpoints
## Usage
```
cd fairseq-zhen
nohup bash mt_eval.sh > log.online.zh2en 2>&1 &
curl -d '{
	"str": query,
	"prefix" : prefix.
	"key" : user_key,
	"value" : user_value
}' http:/address
```
