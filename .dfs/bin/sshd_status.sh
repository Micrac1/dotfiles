#!/bin/sh

_USER="${USER}"
_CURRENT_ALL=`ps auxwww | grep sshd: | grep -v grep | grep '@'`
_CURRENT_USER=`echo "${_CURRENT_ALL}" | grep ${_USER}`

echo $_CURRENT_USER
