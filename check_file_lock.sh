########################################
# File: check_file_lock.sh             #
# Author:  Rajeev Kilaru               #
# Date:  06/28/2021                    #
# Purpose: Simple non-zero bytes size  #
#      file as lock and with a time out#
########################################

#! /usr/bin/bash 

function status_check {

  ITERATIONS=15   # change this one to suite your requirement
  SLEEP=5          # time interval between each iterations in seconds
  STATUS_FILE=/tmp/status.txt # if you are waiting for a for a job complettion, with file as lock.

  FLAG=false
  COUNT=0
  while [ ${COUNT} -lt ${ITERATIONS} ]
  do
    # Break the loop if the file is none zero size
    if test -s ${STATUS_FILE} ; then
      FLAG=true
      break
    fi

    sleep ${SLEEP}
    echo "End of iteration: $COUNT"
    ((COUNT=COUNT+1))

  done

  ${FLAG} && return 0 || return 1

}

STATUS_FILE=/tmp/status.txt # if you are waiting for a for a job complettion, with file as lock.
rm ${STATUS_FILE}

# call funciton 
status_check
# get return code
rc=$?

if [ ${rc} -eq 0 ]
then
  echo "< CALL YOUR SCRIPT HERE >"
  exit 0 # success
else 
  echo "time out after all the iterations"
  echo "write code here to handle the failure"
  exit 1  #failure
fi
