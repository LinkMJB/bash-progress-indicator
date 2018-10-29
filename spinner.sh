#!/bin/bash -e

declare -x SPINNER
declare -x SPINNER_INTERVAL

set_spinner() {
  case $1 in
    spinner1)
      SPINNER=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
      SPINNER_INTERVAL=0.1
      ;;
    spinner2)
      SPINNER=("-" "\\" "|" "/")
      SPINNER_INTERVAL=0.25
      ;;
    spinner3)
      SPINNER=("◐" "◓" "◑" "◒")
      SPINNER_INTERVAL=0.5
      ;;
    spinner4)
      SPINNER=(":(" ":|" ":)" ":D")
      SPINNER_INTERVAL=0.5
      ;;    
    spinner5)
      SPINNER=("^" ">" "v" "<")
      SPINNER_INTERVAL=0.5
      ;;    
    spinner6)
      SPINNER=("<('-'<)" "^('-')^" "(>'-')>" "v('-')v")
      SPINNER_INTERVAL=0.5
      ;;    
    spinner7)
      SPINNER=($(x=1; while [ ${x} -le 10 ]; do echo $((${RANDOM} % $x)); x=$(($x+1)); done))
      SPINNER_INTERVAL=0.3
      ;;    
    spinner8)
      SPINARR=("^" ">" "v" "<")
      SPINNER=($(x=1; while [ ${x} -le 20 ]; do echo ${SPINARR[$((${RANDOM} % ${#SPINARR[@]}))]}; x=$(($x+1)); done))
      SPINNER_INTERVAL=0.1
      ;;    
    spinner9)
      SPINARR=("<('-'<)" "^('-')^" "(>'-')>" "v('-')v")
      SPINNER=($(x=1; while [ ${x} -le 20 ]; do echo ${SPINARR[$((${RANDOM} % ${#SPINARR[@]}))]}; x=$(($x+1)); done))
      SPINNER_INTERVAL=0.1
      ;;    
    *)
      echo "No spinner is defined for $1"
      exit 1
  esac
}

start() {
  local step=0

  tput civis -- invisible

  while [ "$step" -lt "${#CMDS[@]}" ]; do
    ${CMDS[$step]} & pid=$!

    SPACES=$(echo ${SPINNER[0]} | sed 's/./ /g')

    while ps -p $pid &>/dev/null; do
      echo -ne "\\r[ ${SPACES} ] ${STEPS[$step]} ..."

      for k in "${!SPINNER[@]}"; do
        echo -ne "\\r[ ${SPINNER[k]} ]"
        sleep $SPINNER_INTERVAL
      done
    done

    echo -ne "\\r[ ✔ ] ${STEPS[$step]} ${SPACES}   \\n"
    step=$((step + 1))
  done

  tput cnorm -- normal
}
