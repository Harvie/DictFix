#DictFix
Set of scripts written ad-hoc to fix broken character encoding of database dump.
All national characters were replaced by question marks during mysql upgrade error, so i've written this to guess missing characters using dictionary.
It's primary made for czech texts, but it can be easily modified by changing proper dictionary and character set.

http://ucnk.ff.cuni.cz/srovnani.php

curl http://ucnk.ff.cuni.cz/doc/seznamy/syn2005_word.gz | zcat | cut -f 2 | enca -x UTF-8 > syn2005_word.txt
time awk '{ print length(), $0 | "sort -n" }' syn2005_word.txt | tee syn2005_word-delky.txt
time awk '{ print length(), $0 | "sort -n" }' syn2005_word.txt | cut -d ' ' -f 2- | tac | tee syn2005_word-delky-reverse.txt
time cat rozhledny.sql | tr -dc '[:print:]\n' | sed -f fixdia2.sed | tee rozhledny-fixed.sql

sed -e 's/),(/),\n(/g'
