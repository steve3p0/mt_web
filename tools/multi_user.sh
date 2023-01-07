#!/bin/bash
url=$1
number_of_users=$2
number_of_calls=$3 
src=$3
tgt=$4
txt=$5

echo $url
echo $number_of_users
echo $number_of_calls
echo $4
echo $5
# exit()

while true
do
  # start threads
  for i in $(seq 1 $number_of_users)
  do
    echo "started instance no: $i"
    # /path/to/script/A &
	nohup time python ~/mt_web/tools/load_testing.py $url $number_of_users $number_of_calls &
  done
  # sleep 1 second
  sleep 1
done

