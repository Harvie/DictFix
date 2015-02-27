#!/bin/bash
in='rozhledny.sql'
out=fixik.sql


echo -n > "$out"
time cat "$in" | sed -e 's/),(/),\n(/g' | while read i; do
	echo "$i" | grep ? >/dev/null &&
	echo "$i" | sed -f dictfix.sed | tee -a "$out" ||
	echo "$i" | tee -a "$out"
done

