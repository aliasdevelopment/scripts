#!/bin/bash -e

SEARCH_PATH="${1:-${PWD}}" # specifies where the script should look for git repos
STEPS="${2:-10}" # git log month steps to be generated
SEARCH_DEPTH=2 # search depth with respect to the SEARCH_PATH
OUTPUT_TAGGING="git_log_range"

LOG_PATH=$( mktemp -d --tmpdir=. --suffix="_${OUTPUT_TAGGING}" )

REPO_LIST=$( find "${SEARCH_PATH}" -maxdepth ${SEARCH_DEPTH} -type d -name '.git' -execdir pwd \; )

obtain_git_log()
{
  REPO_PATH="${1}"
  RANGE_START="${2}"
  RANGE_END="${3}"
  
  pushd ${REPO_PATH} >/dev/null 2>&1
    git --no-pager log --pretty="%h - %s" --since=${RANGE_START} --before=${RANGE_END} --no-merges
  popd >/dev/null 2>&1
}

# iteration months backward from current month
for ((i=0;i<STEPS;i++)); do
  
  MONTH_START="$( date --date="$( date +'%Y-%m-01' ) - ${i} month" +%Y-%m-%d )"
  MONTH_END="$( date --date="$MONTH_START + 1 month - 1 second" +%Y-%m-%d )"
  
  OUTPUT_FILE_NAME="${LOG_PATH}/${OUTPUT_TAGGING}_${MONTH_START}_${MONTH_END}.log"
  
  # iterate all git repos found in SEARCH_PATH
  for REPO_PATH in ${REPO_LIST[@]}; do
      
    REPO_NAME=$( basename ${REPO_PATH} )
    
    LOG_CONTENT=$( obtain_git_log "${REPO_PATH}" "${MONTH_START}" "${MONTH_END}" )
    
    if [ "$( echo "${LOG_CONTENT}" | wc -m )" -gt "7" ]; then # ensure one short git hash is found
      printf "\n  Git repo: ${REPO_NAME}\n\n" | tee -a "${OUTPUT_FILE_NAME}"
      echo "${LOG_CONTENT}" | tee -a "${OUTPUT_FILE_NAME}"
    fi
  
  done
  
  printf "\n  Git log range ${MONTH_START} -> ${MONTH_END}\n\n" | tee -a "${OUTPUT_FILE_NAME}"

done
