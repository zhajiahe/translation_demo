nist=~/nist
bleu=multi-bleu.perl

perl $bleu -lc $nist/nist02.ref.  < nist02 >nist02.score

perl $bleu -lc $nist/nist03.ref.  < nist03 >nist03.score

perl $bleu -lc $nist/nist04.ref.  < nist04 >nist04.score

perl $bleu -lc $nist/nist05.ref.  < nist05 >nist05.score

perl $bleu -lc $nist/nist08.ref.  < nist08 >nist08.score



cat nist0*.score

