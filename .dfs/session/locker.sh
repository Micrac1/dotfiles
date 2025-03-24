#!/bin/sh

LOCK_TIMEOUT="$(xrdb -get dfs.screenTimeout)}"
: "${LOCK_TIMEOUT:=295}"
LOCK_DIM_DURATION="$(xrdb -get dfs.screenDimDuration)}"
: "${LOCK_DIM_DURATION:=5}"

/bin/xset dpms 0 0 0
/bin/xset s "${LOCK_TIMEOUT}" "${LOCK_DIM_DURATION}"
/bin/xset s blank
/bin/xset s noexpose
/bin/env \
    XSECURELOCK_BACKGROUND_COLOR=#444466 \
    XSECURELOCK_WAIT_TIME_MS=0 \
    XSECURELOCK_DIM_ALPHA=1 \
    XSECURELOCK_DIM_TIME_MS="${LOCK_DIM_DURATION}000" \
    XSECURELOCK_SAVER=saver_blank \
    XSECURELOCK_AUTH_TIMEOUT=5 \
    XSECURELOCK_BLANK_TIMEOUT=1 \
    XSECURELOCK_PASSWORD_PROMPT=disco \
    XSECURELOCK_BLANK_DPMS_STATE=off \
    XSECURELOCK_DISCARD_FIRST_KEYPRESS=0 \
  /bin/xss-lock -l -n /usr/lib/xsecurelock/dimmer \
  -- /bin/xsecurelock &
