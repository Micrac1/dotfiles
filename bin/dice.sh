#!/bin/sh

usage() {
  echo "Roll a dice"
  echo "Example: 5d2"
}

if [ "$1" = "" ]; then
  usage
  exit
fi

# test for valid format
case "$1" in
  *[0-9]d*[0-9]);;
  *) echo "Bad format"; usage; exit;;
esac

COUNT="${1%%d*}"
TYPE="${1##*d}"

if [ "${COUNT}" -le 0 ] || [ "${TYPE}" -le 0 ]; then
  echo "Invalid dice count or type"
  usage
  exit
fi

SUM="0"
i="0"
ROLLS=""

while [ "${i}" -lt "${COUNT}" ]; do
  ROLL=$(( 1 + "$(hexdump -n 2 -e '2/1 "%u"' /dev/random)" % "${TYPE}" ))
  ROLLS="${ROLLS} ${ROLL}"
  SUM=$(( "${SUM}" + "${ROLL}" ))
  i=$(( "${i}" + 1 ))
done

echo "${SUM}: ${ROLLS}"
