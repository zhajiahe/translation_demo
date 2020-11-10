import jionlp as jio
import jieba
import fastBPE
from mosestokenizer import *
from pyltp import SentenceSplitter
import nltk.data
from utils import *
from flashtext import KeywordProcessor
keyword_processor = KeywordProcessor()
keyword_processor.add_keyword('Suzhou University', 'Soochow University')

jieba.initialize()
zh_bpe = fastBPE.fastBPE('../data-bin/codes.zh', '../data-bin/dict.zh.txt')
en_bpe = fastBPE.fastBPE('../data-bin/codes.en', '../data-bin/dict.en.txt')
tokenizer = MosesTokenizer()
detokenizer = MosesDetokenizer()
punc_norm = MosesPunctuationNormalizer()
en_spliter = nltk.data.load('tokenizers/punkt/english.pickle')
user_dict_path = '../data-bin/user_dict'

user_dict = load_user_dict(user_dict_path)

def sep_lines(lines):
    sep = []
    for line in lines:
        sep.append(line.count('ENTER'))
    return sep


def en_tokenize(text):
    tokens = tokenizer(text) # tokenize
    return ' '.join(tokens)

def preprocess(texts, lang='zh'):
    assert lang in ['zh','en']
    results = []
    if lang == 'zh':
        """中文处理"""
        for k, v in user_dict.items():
            texts = texts.replace(k, v)       # 用户字典
        texts = jio.tra2sim(texts)            # 繁体转简体
        texts = jio.convert_full2half(texts)  # 全角转半角
        # 分行处理
        texts = texts.replace('ENTER','\n').rstrip().replace('\n', ' ENTER ')
        lines = jio.split_sentence(texts)
        line_sep = sep_lines(lines)
        for line in lines:
            text = punc_norm(line).replace('ENTER','')              # normalize punctuation
            text = ' '.join(list(jieba.cut(text))) # 中文分词
            text = ' '.join(tokenizer(text))    # tokenize
            text = ' '.join(zh_bpe.apply([text])) # 中文BPE
            results.append(text)
    
    if lang == 'en':
        """英文处理"""
        texts = jio.remove_exception_char(texts)# 去除异常字符
        # 分行处理
        texts = texts.replace('ENTER','\n').rstrip().replace('\n', ' ENTER ')
        lines = en_spliter.tokenize(texts)
        line_sep = sep_lines(lines)
        for line in lines:
            text = punc_norm(line).replace('ENTER','')              # normalize punctuation
            text = en_tokenize(text)    # tokenize
            text = ' '.join(en_bpe.apply([text])) # 英文BPE
            results.append(text)
    
    return results, line_sep

def postprocess(texts, line_sep):

    outputs = []
    line = 0
    for text in texts:
        outputs.append(line_sep[line] * '\n' + detokenizer([text]))
        line += 1
    result = ' '.join(outputs)
    ## 特殊词替换 TODO
    result = keyword_processor.replace_keywords(result)
    return result


if __name__ == '__main__':
    preprocess('今天去苏州大学~！', 'en')

    
