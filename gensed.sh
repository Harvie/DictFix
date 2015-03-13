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
	pre="\\([^'"$substchar$diachars"'a-Z]\\|^\\)"
	pos="\\([^'"$substchar$diachars"'a-Z]\\|$\\)"
	gsub(/['"$diachars"']/, "'"$substchar"'", nodia);
	print "s/" pre nodia pos "/\\1" orig "\\2/g;";

	#Prvni velkym
	sub(/^./, substr(toupper(nodia),1,1), nodia);
	sub(/^./, substr(toupper(orig),1,1), orig);
	print "s/" pre nodia pos "/\\1" orig "\\2/g;";

	#Vsechny velkejma
	nodia=toupper(nodia);
	orig=toupper(orig);
	print "s/" pre nodia pos "/\\1" orig "\\2/g;";
}';


#head syn2005_word-antidelky.txt | while read i; do
#	j="$(echo "$i" | tr -c '[:print:]' '?')";
#	echo "s/$j/$i/gi;"
#done;

