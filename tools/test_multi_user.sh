#!/bin/bash


date +%s%N | cut -b1-13

date +%s%3N

# start_date=date+%s000
# echo $start_date


url=$1
users=$2
calls_per_user=$3

filename="load_test.$users.$calls_per_user"
tran_file="$filename.trn"
secs_file="$filename.sec"
lines_file="$filename.lines"
info_file="$filename.info"

rm $filename 2> /dev/null
rm $avg_file 2> /dev/null

for ((i=1;i<=users-1;i++)); do
    #nohup python load_testing.py $url $calls_per_user >> $filename </dev/null &>/dev/null &
	nohup python load_testing.py $url $calls_per_user >> $filename &
done

python load_testing.py "https://localhost" $calls_per_user > $filename 2>&1 

# strip out the blank lines and take the first column
sed '/^\s*$/d' $filename > $tran_file

# Get the number of lines in the file
gawk -F"\t" '{ print $1 + "\n"}' $tran_file > $secs_file
lines=($(wc -l $secs_file))

# Sum up all the lines in the 
sum=`gawk -F"\t" '{sum += $1 } END { print "sum:" + sum }' $secs_file`


# Get the Average
printf "Average Time: " >> $info_file
echo "scale=4;($sum)/($lines)" | bc >> $info_file
echo "scale=4;($sum)/($lines)" | bc 
# Clean up
rm $filename
rm $secs_file

end_date=date
elapsed_time=$((end_date - start_date))
echo $elapsed_time

exit


#average=$((${sum}00/$lines))
#echo "${RESULT:0:-2}.${RESULT: -2}"


#bc <<< 'scale=2; 100/3'
#bc <<< 'scale=4; sum/lines'
#echo $((sum / lines))


#gawk -F"\t" '{sum += $1; ave=(sum / ' + $lines + ') } END { print "ave:" + ave }' $secs_file

#sed '/^\s*$/d' $input_file | gawk -F"\t" '{ print $1 + "\n"}' > $secs_file



sed '/^\s*$/d' $input_file | gawk -F"\t" '{ print $1 + "\n"}' | lines=($(wc -l $1))
echo $lines

# lines 
# sed '/^\s*$/d' lines_files | gawk -F"\t" '{sum += $1 ; lines=wc -l < $1 ; ave=(sum / lines) }  END { print "01 user: ave }'

#echo $no_lines
exit
 
 
END=5
i=0
for ((i=1;i<=END-1;i++)); do
    nohup python load_testing.py "https://localhost" safe &
done
filename="load_test.$i"
python load_testing.py "https://localhost" safe > $filename 2>&1 

#cat $filename | sed '/^\s*$/d' | wc
read lines words chars filename <<< $(wc x)
echo $lines

# gawk -F"\t" '{sum += $1 ; lines=wc -l < $1 ; ave=(sum / lines) }  END { print "01 user: ave }'

wc -l < sed '/^\s*$/d' load_test.5 | gawk -F"\t" '{ print $1 }'
sed '/^\s*$/d' load_test.5 | gawk -F"\t" '{ print $1 }'
sed '/^\s*$/d' load_test.5 | gawk -F"\t" '{ print $1 }'
sed '/^\s*$/d' load_test.5 | gawk -F"\t" '{ print $1 }'
sed '/^\s*$/d' load_test.5 | gawk -F"\t" '{ print $1 }'
sed '/^\s*$/d' load_test.5 | gawk -F"\t" '{ print $1 }'
sed '/^\s*$/d' load_test.5 | gawk -F"\t" '{ print $1 }'
sed '/^\s*$/d' load_test.5 | gawk -F"\t" '{ print $1 }'

sum += $1 ; lines=wc -l < $1 ; ave=(sum / lines) }  END { print "04 users: ave }'

gawk -F"\t" '{dsum += $1 ; ave=(sum / lines) }  END { print "04 users: ave }'

exit

python load_testing.py "https://localhost" safe > load_test.01 2>&1 

cat $ | sed '/^\s*$/d' | gawk -F"\t" '{sum += $1 ; lines=wc -l < $1 ; ave=(sum / lines) }  END { print "01 user: ave }'

nohup python load_testing.py "https://localhost" safe &
python load_testing.py "https://localhost" safe > load_test.02 2>&1 
cat load_test.02 | sed '/^\s*$/d' | gawk -F"\t" '{sum += $1 ; lines=wc -l < $1 ; ave=(sum / lines) }  END { print "02 users: ave }'

nohup python load_testing.py "https://localhost" safe &
python load_testing.py "https://localhost" safe > load_test.03 2>&1
cat load_test.03 | sed '/^\s*$/d' | gawk -F"\t" '{sum += $1 ; lines=wc -l < $1 ; ave=(sum / lines) }  END { print "03 users: ave }'

nohup python load_testing.py "https://localhost" safe &
python load_testing.py "https://localhost" safe > load_test.04 2>&1 
cat load_test.04 | sed '/^\s*$/d' | gawk -F"\t" '{sum += $1 ; lines=wc -l < $1 ; ave=(sum / lines) }  END { print "04 users: ave }'

nohup python load_testing.py "https://localhost" safe &
python load_testing.py "https://localhost" safe > load_test.05 2>&1 
cat load_test.05 | sed '/^\s*$/d' | gawk -F"\t" '{sum += $1 ; lines=wc -l < $1 ; ave=(sum / lines) }  END { print "05 users:" + ave }'


killall python

exit

nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
python load_testing.py "https://localhost" safe > load_test.10 2>&1
sleep 10

nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
python load_testing.py "https://localhost" safe & load_test.20 2>&1
sleep 10



awk '{for(i=1;i<=NF;i++) a[$i]++} END {for(k in a) print k,a[k]}' load_test.01



nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
load_testing.py "https://localhost" safe > load_test.30 2>&1
sleep 10









nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
python load_testing.py "https://localhost" safe > load_test.40 2>&1
sleep 10









nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
python load_testing.py "https://localhost" safe > load_test.50 2>&1

sleep 10
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
python load_testing.py "https://localhost" safe > load_test.75 2>&1
sleep 10

nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
nohup python load_testing.py "https://localhost" safe &
python load_testing.py "https://localhost" safe > load_test.100 2>&1
sleep 10
