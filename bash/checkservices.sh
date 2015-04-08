#!/bin/bash

SERVICES="192.168.0.1:1234 192.168.0.2:4444 192.168.0.3:6789"
FAILED=""
FAILEDCNT="0"

for SERVICE in $SERVICES
do
    nc -z -w 3 `echo $SERVICE | tr ':' ' '`
    if [[ $? != "0" ]]
    then
	echo "$SERVICE FAIL"
	FAILED="$FAILED $SERVICE"
	FAILEDCNT="$(( FAILEDCNT + 1 ))"
    else
	echo "$SERVICE OK"
    fi
done

echo "----------"
echo "FAILED[$FAILEDCNT]:"
echo $FAILED

if [[ "$FAILEDCNT" != "0" ]]
then
    exit 1
else
    exit 0
fi
