#!/bin/bash

for i in {01..95}; do
	echo "${i}"
	convert "${i}_"*".jpg" "${i}.pdf"
done
