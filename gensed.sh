#!/bin/sh

### CONFIG
#pattern to match missing chars
substchar='?'
#set of possible replacement chars
diachars='áčďéěíňóöřšťúůüýžÁČĎÉĚÍŇÓÖŘŠŤÚŮÜÝŽ'
#file with dictionary
dictionary='syn2005_word-antidelky.txt'


cat "$dictionary" |
grep "[$diachars]" |
grep -vi "[^/a-zA-Z${diachars}-]" |
awk '{
	gsub(/\//, "\\/");
	orig=$1;
	nodia=$1;
	gsub(/['"$diachars"']/, "'"$substchar"'", nodia);
	print "s/" nodia "/" orig "/g;";

	#Prvni velkym
	sub(/^./, substr(toupper(nodia),1,1), nodia);
	sub(/^./, substr(toupper(orig),1,1), orig);
	print "s/" nodia "/" orig "/g;";

	#Vsechny velkejma
	nodia=toupper(nodia);
	orig=toupper(orig);
	print "s/" nodia "/" orig "/g;";
}';


#head syn2005_word-antidelky.txt | while read i; do
#	j="$(echo "$i" | tr -c '[:print:]' '?')";
#	echo "s/$j/$i/gi;"
#done;

