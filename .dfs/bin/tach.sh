#!/bin/sh
shopt -s nullglob
_DIR="${1:-$PWD}"
_ONAME=$(basename "${_DIR}")
_IMAGES=""

for chapter in "${_DIR}/"* ; do
  if [ -d "${chapter}" ]; then
    for image in "${chapter}"/*.{jpg,jpeg,png}; do
      _IMAGES+=$(printf "%q" "${image}")$'\n'
    done
  fi
done
_IMAGES=$(echo "${_IMAGES}" | sort)
echo "$_IMAGES"
echo "Output: ${_ONAME}.pdf"
eval convert -monitor -limit Memory 8192 ${_IMAGES} \"${_ONAME}.pdf\"
