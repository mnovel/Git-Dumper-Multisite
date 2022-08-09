#!/usr/bin/env bash

command -v git-dumper >/dev/null 2>&1 || { echo >&2 "git-dumper is not installed.  Aborting."; exit 1; }

# shellcheck disable=SC2034 # https://github.com/koalaman/shellcheck/wiki/SC2034

BLA_modern_metro=( 0.15 ▰▱▱▱▱▱▱ ▰▰▱▱▱▱▱ ▰▰▰▱▱▱▱ ▱▰▰▰▱▱▱ ▱▱▰▰▰▱▱ ▱▱▱▰▰▰▱ ▱▱▱▱▰▰▰ ▱▱▱▱▱▰▰ ▱▱▱▱▱▱▰ ▱▱▱▱▱▱▱ ▱▱▱▱▱▱▱ ▱▱▱▱▱▱▱ ▱▱▱▱▱▱▱ )

declare -a BLA_active_loading_animation

BLA::play_loading_animation_loop() {
  while true ; do
    for frame in "${BLA_active_loading_animation[@]}" ; do
      printf "\r%s" "${frame}"
      sleep "${BLA_loading_animation_frame_interval}"
    done
  done
}

BLA::start_loading_animation() {
  BLA_active_loading_animation=( "${@}" )
  # Extract the delay between each frame from array BLA_active_loading_animation
  BLA_loading_animation_frame_interval="${BLA_active_loading_animation[0]}"
  unset "BLA_active_loading_animation[0]"
  tput civis # Hide the terminal cursor
  BLA::play_loading_animation_loop &
  BLA_loading_animation_pid="${!}"
}

BLA::stop_loading_animation() {
  kill "${BLA_loading_animation_pid}" &>/dev/null
  printf "\n"
  tput cnorm # Restore the terminal cursor
}

BLUE='\033[0;34m'
RED='\033[0;31m'
GREEN='\033[00;32m'
NC='\033[0m'
CHECK_MARK='\u2714'
CROSS_MARK='\u2718' 
DIR=$(pwd)
READ=$(cat)

while 
    read i
do 
    TARGET="${i/\/config/""}" #CLEAR CONFIG ON TARGET
    NAMEFILE="${i/https:\/\//""}"
    NAMEFILE="${NAMEFILE/http:\/\//""}"
    NAMEFILE="${NAMEFILE/\/\.git\/config/""}"

    printf "${BLUE}[*] Try to download $NAMEFILE\n${NC}"

    if [ -d "$NAMEFILE" ] 
    then
        printf "${RED}[${CROSS_MARK}] Skipped: $NAMEFILE directory exists\n"
    else
        BLA::start_loading_animation "${BLA_modern_metro[@]}"
        (git-dumper $TARGET $DIR/$NAMEFILE &>/dev/null) &
        wait $!
        BLA::stop_loading_animation
        printf "\033[1A\033[K" #This will clear the last line
        printf "${GREEN}[${CHECK_MARK}] successfully download $NAMEFILE\n"
    fi
done <<< "$READ"
