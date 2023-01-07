#!/bin/bash
# init

#WWW_PATH="mt_web/mt_cherry"
WWW_PATH="mt_web"
MOSES_PATH="mosesdecoder"

# VM Networking
# You need to Reset the Virtual Machine's network connection.  Do the following: 
# - Go into Oracle VM Virtual Box Manager
# - Select the VM
# - Right-click on Settings
# - Click on Network
# - Select Adapter 1 tab 
# - Change "Attached to:" from "Bridged Adapter" to "Not Attached"
# - Now set it back to "Bridged Adapter"

####################################################
# Helper Commands
# Kill any zombie SSL Processes
# ps aux | grep "ngrok\|python\|server_ssl\|moses" 
# ps -ef | grep "ngrok\|python\|server_ssl\|moses" | grep -v grep
# sudo kill -9 pid
# 
# sudo ~/$WWW_PATH/tools/mtServerShutdown.sh
# sudo ~/$WWW_PATH/tools/mtServerStart.sh
# cat ~/$WWW_PATH/nohup.out
# cat ~/$WWW_PATH/html/nohup.out
##################################################

clear
echo -e "\n-----------------------------------------";
echo -e " Lovoco MT Startup Script"
echo -e "-----------------------------------------";

### STOP MT Services ############################################

echo -e "\n>>> 0.1 Viewing Running MT Processes" 
ps aux | grep "ngrok\|python\|server_ssl\|moses" 
ps -ef | grep "ngrok\|python\|server_ssl\|moses" | grep -v grep

echo -e "\n>>> 0.2: Shutdown Running MT Services" 
#~/$WWW_PATH/tools/mtServerShutdown.sh
#~/$WWW_PATH/tools/mtServerShutdown.sh
#killall moses
#killall moses2
#killall mosesserver
# killall ngrok
# killall python

echo -e "Press any key to continue..."; read -s -n 1 -p ""

echo -e "\n>>> 0.3 Viewing Running Web Server Processes" 
ps -ef | grep "ngrok\|python\|server_ssl\|moses" | grep -v grep && { echo ">>>>>>>> Couldn't Kill All Running Processes"; }
echo -e "Press any key to continue..."; read -s -n 1 -p ""

echo -e "\\n>>> 0.4 Check the log - Printing any errors"
cat ~/$WWW_PATH/tool/nohup.out 
cat ~/$WWW_PATH/html/nohup.out
echo -e ">>> End of Errors."

echo -e "\n>>> 0.5 Delete old logs" 
rm ~/$WWW_PATH/tool/nohup.out
rm ~/$WWW_PATH/html/nohup.out
echo -e "Press any key to continue... or CTRL-C to quite"; read -s -n 1 -p ""

### START MT Services ##########################################

# echo -e "\n>>> 2.0 Caching Translation Models"
# cat ~/mt_publish/model_enzh_ted/phrase-table.minphr > /dev/null
# cat ~/mt_publish/model_enzh_ted/reordering-table.minlexr > /dev/null
# cat ~/mt_publish/model_enzh_ted/target.blm.zh > /dev/null

# cat ~/mt_publish/model_enar_ted/phrase-table.minphr > /dev/null
# cat ~/mt_publish/model_enar_ted/reordering-table.minlexr > /dev/null
# cat ~/mt_publish/model_enar_ted/target.blm.ar > /dev/null

# cat ~/mt_publish/model_ende_ted/phrase-table.minphr > /dev/null
# cat ~/mt_publish/model_ende_ted/reordering-table.minlexr > /dev/null
# cat ~/mt_publish/model_ende_ted/target.blm.de > /dev/null

# cat ~/mt_publish/model_enhr_ted/phrase-table.minphr > /dev/null
# cat ~/mt_publish/model_enhr_ted/reordering-table.minlexr > /dev/null
# cat ~/mt_publish/model_enhr_ted/target.blm.hr > /dev/null

# cat ~/mt_publish/model_enit_ted/phrase-table.minphr > /dev/null
# cat ~/mt_publish/model_enit_ted/reordering-table.minlexr > /dev/null
# cat ~/mt_publish/model_enit_ted/target.blm.it > /dev/null

# cat ~/mt_publish/model_ennl_ted/phrase-table.minphr > /dev/null
# cat ~/mt_publish/model_ennl_ted/reordering-table.minlexr > /dev/null
# cat ~/mt_publish/model_ennl_ted/target.blm.nl > /dev/null

# cat ~/mt_publish/model_enpl_ted/phrase-table.minphr > /dev/null
# cat ~/mt_publish/model_enpl_ted/reordering-table.minlexr > /dev/null
# cat ~/mt_publish/model_enpl_ted/target.blm.pl > /dev/null

# cat ~/mt_publish/model_enpt_ted/phrase-table.minphr > /dev/null
# cat ~/mt_publish/model_enpt_ted/reordering-table.minlexr > /dev/null
# cat ~/mt_publish/model_enpt_ted/target.blm.pt > /dev/null

# cat ~/mt_publish/model_enro_ted/phrase-table.minphr > /dev/null
# cat ~/mt_publish/model_enro_ted/reordering-table.minlexr > /dev/null
# cat ~/mt_publish/model_enro_ted/target.blm.ro > /dev/null

# cat ~/mt_publish/model_enru_ted/phrase-table.minphr > /dev/null
# cat ~/mt_publish/model_enru_ted/reordering-table.minlexr > /dev/null
# cat ~/mt_publish/model_enru_ted/target.blm.ru > /dev/null

# cat ~/mt_publish/model_ensl_ted/phrase-table.minphr > /dev/null
# cat ~/mt_publish/model_ensl_ted/reordering-table.minlexr > /dev/null
# cat ~/mt_publish/model_ensl_ted/target.blm.sl > /dev/null

# cat ~/mt_publish/model_entr_ted/phrase-table.minphr > /dev/null
# cat ~/mt_publish/model_entr_ted/reordering-table.minlexr > /dev/null
# cat ~/mt_publish/model_entr_ted/target.blm.tr > /dev/null
# echo -e "Press any key to continue... or CTRL-C to quite"; read -s -n 1 -p ""

# Start Multi-Threaded Moses Servers
echo -e "\n>>> 3.1 Start Moses Servers: Outbound EN > Target Servers"
# ~/mosesdecoder/contrib/server/bin/gcc-4.8/release/link-static/threading-multi/mosesserver
# -threads 2 
# --server --server-port 3001 
# -f ~/mt_publish/model_enzh_ted/moses.ini 
# --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &

# ~/mosesdecoder/contrib/server/bin/gcc-4.8/release/link-static/threading-multi/mosesserver -threads 2 --server --server-port 3001 -f ~/mt_publish/model_enzh_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &

#nohup ~/mosesdecoder/contrib/server/bin/gcc-4.8/release/link-static/threading-multi/mosesserver -threads 2 --server --server-port 3004 -f ~/mt_publish/model_enfr_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &

# nohup 
# ~/mosesdecoder/contrib/server/bin/gcc-4.8/release/link-static/threading-multi/mosesserver -threads 2 "This is a test" -f ~/mt_publish/model_enfr_ted/moses.ini 
#--mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" 
#
#~/mosesdecoder.NEW/bin/moses2 -threads 2  --server --server-port 3004 -f ~/mt_publish/model_enfr_ted/moses.ini 





# ## Start Moses Servers
# echo -e "\n>>> 3.1 Start Moses Servers: Outbound EN > Target Servers"
nohup ~/$MOSES_PATH/bin/moses --server --server-port 3001 -f ~/mt_publish/model_enzh_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
# nohup ~/$MOSES_PATH/bin/moses2 --server --server-port 3001 -f ~/mt_publish/model_enzh_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
#nohup ~/$MOSES_PATH/bin/moses2 -threads 2 --server --server-port 3001 -f ~/mt_publish/model_enzh_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &

# nohup ~/$MOSES_PATH/bin/moses -threads 2 --server --server-port 3001 -f ~/mt_publish/model_enzh_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 3002 -f ~/mt_publish/model_ende_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 3003 -f ~/mt_publish/model_enes_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
# # # nohup ~/$MOSES_PATH/bin/moses -threads all --server --server-port 3004 -f ~/mt_publish/model_enfr_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 3004 -f ~/mt_publish/model_enfr_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 3005 -f ~/mt_publish/model_enit_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 3006 -f ~/mt_publish/model_ennl_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 3007 -f ~/mt_publish/model_enpl_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 3008 -f ~/mt_publish/model_enpt_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 3009 -f ~/mt_publish/model_enro_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 3010 -f ~/mt_publish/model_enru_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 3011 -f ~/mt_publish/model_ensl_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 3012 -f ~/mt_publish/model_enhr_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 3013 -f ~/mt_publish/model_entr_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 3014 -f ~/mt_publish/model_enar_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 3015 -f ~/mt_publish/model_enfa_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
echo -e "Press any key to continue... or CTRL-C to quite"; read -s -n 1 -p ""

echo -e "\n>>> 3.2 Start Moses Servers: Inbound: Target > English"
nohup ~/$MOSES_PATH/bin/moses --server --server-port 4001 -f ~/mt_publish/model_zhen_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 4002 -f ~/mt_publish/model_deen_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 4003 -f ~/mt_publish/model_esen_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 4004 -f ~/mt_publish/model_fren_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 4005 -f ~/mt_publish/model_iten_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 4006 -f ~/mt_publish/model_nlen_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 4007 -f ~/mt_publish/model_plen_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 4008 -f ~/mt_publish/model_pten_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 4009 -f ~/mt_publish/model_roen_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 4010 -f ~/mt_publish/model_ruen_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 4011 -f ~/mt_publish/model_slen_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 4012 -f ~/mt_publish/model_hren_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 4013 -f ~/mt_publish/model_tren_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 4014 -f ~/mt_publish/model_aren_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
nohup ~/$MOSES_PATH/bin/moses --server --server-port 4015 -f ~/mt_publish/model_faen_ted/moses.ini --mark-unknown --unknown-word-prefix "__UNK__" --unknown-word-suffix "__UNK__" &
echo -e "Press any key to continue... or CTRL-C to quite"; read -s -n 1 -p ""

### START WEB Services ##########################################

#echo -e "\n>>> 1.1 Start CherryPy Web Server" 
cd ~/$WWW_PATH/mt_cherry
sudo python translate.py




