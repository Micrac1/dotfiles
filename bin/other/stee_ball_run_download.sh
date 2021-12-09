#!/bin/bash

#placed in steel-ball-run/manga/

for i in {1..95}; do
	CHAP="jojos-bizarre-adventure-steel-ball-run-chapter-$i"
	for j in `grep ".jpg" "$CHAP/index.html" | cut -d '"' -f 4 | grep "\.\."`; do
		echo $i
		cp `echo ${j} | cut -d '/' -f 2-100` "sbr/"`printf "%02d" ${i}`_`basename ${j}`
	done
done
