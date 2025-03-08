#!/bin/sh
. "$(dirname "${0}")/base.sh"
if [ -z "${BASE_SH_SUCCESS}" ]; then
  echo "Failed to initalize base.sh"; exit 101
fi

# ============================================================================
# Environmental variables
LABEL_PROGRESS="${LABEL_PROGRESS:-*}"
LABEL_PERFORMANCE="${LABEL_PERFORMANCE:-P}"
LABEL_POWERSAVE="${LABEL_POWERSAVE:-S}"
LABEL_SCHEDUTIL="${LABEL_SCHEDUTIL:-s}"
LABEL_UNKNOWN="${LABEL_UNKNOWN:-?}"
BUTTON_PLAY="${BUTTON_PLAY:- ▶ }"
BUTTON_PAUSE="${BUTTON_PAUSE:- ∐ }"
BUTTON_PLAYPAUSE="${BUTTON_PLAYPAUSE:- ⏯ }"
BUTTON_PREV="${BUTTON_PREV:-<<}"
BUTTON_NEXT="${BUTTON_NEXT:->>}"
ENABLE_CONTROLS="${ENABLE_CONTROLS:-true}"
ENABLE_BAR="${ENABLE_BAR:-true}"
PLAYERCTL_FLAGS="${PLAYERCTL_FLAGS}"
BAR_WIDTH="${BAR_WIDTH:-7}"
BAR_RESOLUTION="${BAR_RESOLUTION:-8}"
BAR_EMPTY="${BAR_EMPTY:- }"
BAR_0="${BAR_0:- }"
BAR_1="${BAR_1:-▏}"
BAR_2="${BAR_2:-▎}"
BAR_3="${BAR_3:-▍}"
BAR_4="${BAR_4:-▌}"
BAR_5="${BAR_5:-▋}"
BAR_6="${BAR_6:-▊}"
BAR_7="${BAR_7:-▉}"
BAR_FILL="${BAR_FILL:-█}"
MAX_INTERVAL="${MAX_INTERVAL:-50}"
# ============================================================================

if [ "${ENABLE_CONTROLS}" = true ]; then
  BUTTON_PLAY="%{A1:playerctl ${PLAYERCTL_FLAGS} play-pause:}${BUTTON_PLAY}%{A}"
  BUTTON_PAUSE="%{A1:playerctl ${PLAYERCTL_FLAGS} play-pause:}${BUTTON_PAUSE}%{A}"
  BUTTON_PLAYPAUSE="%{A1:playerctl ${PLAYERCTL_FLAGS} play-pause:}${BUTTON_PLAYPAUSE}%{A}"
  BUTTON_PREV="%{A1:playerctl ${PLAYERCTL_FLAGS} previous:}${BUTTON_PREV}%{A}"
  BUTTON_NEXT="%{A1:playerctl ${PLAYERCTL_FLAGS} next:}${BUTTON_NEXT}%{A}"
fi

make_position_button(){
  if [ "${ENABLE_CONTROLS}" = true ]; then
    echo "%{A1:playerctl ${PLAYERCTL_FLAGS} position $(( $3 * $2 / (BAR_WIDTH * 1000000) )) :}${1}%{A}"
  else
    echo "${1}"
  fi
}

make_bar(){
  LEFT=$(( $1 * BAR_WIDTH / 100 ))
  i=0
  RET=""
  while [ "${i}" -lt "${LEFT}" ]; do
    RET="${RET}$(make_position_button "${BAR_FILL}" ${i} $2)"
    i="$(( i + 1 ))"
  done

  MIDDLE=$(( ($1 * BAR_WIDTH - LEFT * 100) * BAR_RESOLUTION / 100))

  eval "RET=\${RET}\$(make_position_button \"\${BAR_${MIDDLE}}\" \"\${LEFT}\" \$2)"
  RIGHT=$(( BAR_WIDTH - 1 - LEFT ))
  i=0
  while [ "${i}" -lt "${RIGHT}" ]; do
    RET="${RET}$(make_position_button "${BAR_EMPTY}" $((i + LEFT + 1)) $2)"
    i="$(( i + 1))"
  done

  echo "%{T2}${RET}%{T-}"
}

FORMAT=\
'{{default(status,X)}}|{{default(artist,"<unknown>")}}|{{default(title, "<unknown>")}}|'\
'{{default(duration(position), 0)}}|{{default(duration(mpris:length), 0)}}|'\
'{{default(position, 0)}}|{{default(mpris:length, 0)}}|{{shuffle}}|{{volume}}'

poke_function(){
  TIMESTAMP="$(( $(date +'%s%N') / 1000000 ))"

  playerctl ${PLAYERCTL_FLAGS} -F metadata --format "${FORMAT}" |\
  while IFS='|' read -r STATUS ARTIST TITLE POSITION LENGTH RAW_POSITION RAW_LENGTH REST; do
    TIMESTAMP="$(( $(date +'%s%N') / 1000000 ))" # TODO optimize this somehow
    if [ $(( TIMESTAMP - LAST_TIMESTAMP )) -lt "${MAX_INTERVAL}" ]; then
      continue
    fi
    LAST_TIMESTAMP="${TIMESTAMP}"
    case "${STATUS}" in
      "Playing") BUTTON_MIDDLE="${BUTTON_PAUSE}" ;;
      "Paused") BUTTON_MIDDLE="${BUTTON_PLAY}" ;;
      "Stopped") BUTTON_MIDDLE="${BUTTON_PLAY}" ;;
      *) BUTTON_MIDDLE=" ? ";;
    esac
    RAW_LENGTH="${RAW_LENGTH%.*}"
    CONTROLS="%{T2}${BUTTON_PREV}${BUTTON_MIDDLE}${BUTTON_NEXT}%{T-}"
    if [ "${RAW_LENGTH##.}" -gt 0 ]; then
      PERCENT=$(( RAW_POSITION * 100 / RAW_LENGTH ))
    else
      PERCENT=0
    fi
    if [ "${ENABLE_BAR}" = true ]; then
      BAR="$(make_bar ${PERCENT} ${RAW_LENGTH})"
      # BAR="$(make_bar $(cat ~/sandbox/number) ${RAW_LENGTH})"
    fi

    echo "${CONTROLS}%{-u} %{+u}%{T2}$BAR%{T-}%{-u}"\
      "%{+u}${ARTIST} - ${TITLE}%{-u}"\
      "%{+u}(%{T2} ${POSITION} / ${LENGTH} %{T-})"
  done
}

poke_function &
start_loop
