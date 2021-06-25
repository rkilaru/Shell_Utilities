#! /usr/bin/bash 

function status_check {

ITERATIONS=15   # change this one to suite your requirement
SLEEP=2          # time interval between each iterations
STATUS_FILE=status.txt # if you are waiting for a for a job complettion, with file as lock.

FLAG=false
COUNT=0
while [ ${COUNT} -lt ${ITERATIONS} ]
do
  STATUS=`cat ${STATUS_FILE} 2>/dev/null`
  if [ "${STATUS}" = "SUCCESS" ] 
    then
      FLAG=true
      break
  fi
  sleep ${SLEEP}
  echo "End of iteration: $COUNT"
  ((COUNT=COUNT+1))
done

  ${FLAG} && return 0 || return 1

}

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



