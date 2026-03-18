#!/usr/bin/env bash

set +e

STATE_FILE="state/progress.state"
LOG_FILE="logs/setup.log"

mkdir -p state logs
touch $STATE_FILE
touch $LOG_FILE

GREEN="\033[32m"
RED="\033[31m"
BLUE="\033[34m"
YELLOW="\033[33m"
RESET="\033[0m"

START_TIME=$(date +%s)

command_exists() {
 command -v "$1" >/dev/null 2>&1
}

retry() {

attempts=3
count=0

until "$@"; do
 exit_code=$?
 count=$((count+1))

 if [ $count -lt $attempts ]; then
   echo "Retrying..."
   sleep 2
 else
   return $exit_code
 fi

done
}

progress_bar() {

FILLED=$((COUNT*30/TOTAL))
EMPTY=$((30-FILLED))

printf "\r["
printf "%0.s#" $(seq 1 $FILLED)
printf "%0.s-" $(seq 1 $EMPTY)
printf "] $COUNT/$TOTAL"
}

run_task() {

TASK=$1

if grep -q "$TASK" "$STATE_FILE"; then
 echo -e "${YELLOW}Skipping $TASK${RESET}"
 return
fi

echo -e "${BLUE}Running $TASK${RESET}"

bash "tasks/$TASK" >> $LOG_FILE 2>&1

if [ $? -eq 0 ]; then
 echo -e "${GREEN}✔ $TASK${RESET}"
 echo "$TASK" >> "$STATE_FILE"
else
 echo -e "${RED}✘ $TASK failed (continuing)${RESET}"
fi
}

show_menu() {

echo ""
echo "Select installation profile:"
echo "1) Core tools"
echo "2) AI stack"
echo "3) Infrastructure tools"
echo "4) Full install"
echo ""

read -p "Enter choice: " choice

case $choice in
1) PROFILE="core";;
2) PROFILE="ai";;
3) PROFILE="infra";;
4) PROFILE="full";;
*) PROFILE="full";;
esac
}

PROFILE=$1

if [ -z "$PROFILE" ]; then
 show_menu
else
 PROFILE=${PROFILE#--}
fi

case $PROFILE in

core)
TASKS=(
system.sh
core_utils.sh
)
;;

ai)
TASKS=(
languages.sh
python_ai.sh
)
;;

infra)
TASKS=(
database.sh
infra.sh
)
;;

full)
TASKS=(
system.sh
core_utils.sh
languages.sh
python_ai.sh
database.sh
devtools.sh
infra.sh
workspace.sh
)
;;

esac

TOTAL=${#TASKS[@]}
COUNT=0

for task in "${TASKS[@]}"
do

COUNT=$((COUNT+1))

progress_bar

run_task $task

done

echo ""

END_TIME=$(date +%s)
ELAPSED=$((END_TIME-START_TIME))

echo -e "${GREEN}Setup complete.${RESET}"
echo "Total time: $ELAPSED seconds"
echo "Logs: $LOG_FILE"