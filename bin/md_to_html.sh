#!/bin/sh
CSS=''
INPUT=''
OUTPUT=''

case "${1}" in
  "-c" | "--css")
    shift
    CSS="${1}"
    if [ -z "${CSS}" ]; then
      echo "Error: --css needs an argument."
      exit 1
    fi
    shift
    ;;
esac



pandoc --highlight-style espresso --standalone --toc --toc-depth=6 \
  -f markdown -t html5 \
  -H <(echo '<style>' "$(cat markdown.css)" '</style>') \
  "${INPUT}" -o "${2:-${1}.html}"
