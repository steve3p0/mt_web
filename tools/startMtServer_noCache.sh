#!/bin/bash
# init

#USER_DIR="/home/steve"
USER_DIR="/home/ubuntu"

WWW_PATH="mt_web/mt_cherry"
LOG_PATH="$USER_DIR/mt_web/logs"
#MOSES_DIR="mosesdecoder.NEW"
MOSES_DIR="mosesdecoder"

MOSES_PATH="$USER_DIR/$MOSES_DIR/bin/moses"
MODEL_PATH="$USER_DIR/mt_publish"
MOSES_UNK_WORD_OPTIONS="--mark-unknown --unknown-word-prefix ""__UNK__"" --unknown-word-suffix ""__UNK__"""
MOSES_SERVER_OPTIONS="--server --server-port"
MOSES_INI="moses.ini"

CMD_PREFIX="nohup" # no hang up signal
STDIN="/dev/null"
STDOUT="/dev/null"
STDERR="/dev/null"

LAUNCH_MOSES="$CMD_PREFIX $MOSES_PATH $MOSES_UNK_WORD_OPTIONS $MOSES_SERVER_OPTIONS" 

echo -e "\n>>> Launch Moses Servers: Outbound: English > Target"
# echo -e "\n DEBUG: LAUNCH_MOSES: $LAUNCH_MOSES"
# echo -e "\n DEBUG: MODEL_PATH: $MODEL_PATH"
# echo -e "\n DEBUG: MOSES_INI: $MOSES_INI"
# echo -e "\n DEBUG: STDIN: $STDIN"
# echo -e "\n DEBUG: STDOUT: $STDOUT"
# echo -e "\n DEBUG: STDERR: $STDERR"
# exit 0

$LAUNCH_MOSES 3001 -f $MODEL_PATH/model_enzh_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 3002 -f $MODEL_PATH/model_ende_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 3003 -f $MODEL_PATH/model_enes_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 3004 -f $MODEL_PATH/model_enfr_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 3005 -f $MODEL_PATH/model_enit_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 3006 -f $MODEL_PATH/model_ennl_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 3007 -f $MODEL_PATH/model_enpl_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 3008 -f $MODEL_PATH/model_enpt_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 3009 -f $MODEL_PATH/model_enro_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 3010 -f $MODEL_PATH/model_enru_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 3011 -f $MODEL_PATH/model_ensl_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 3012 -f $MODEL_PATH/model_enhr_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 3013 -f $MODEL_PATH/model_entr_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 3014 -f $MODEL_PATH/model_enar_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 3015 -f $MODEL_PATH/model_enfa_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
echo -e "\n>>> Launch Moses Servers: Inbound: Target > English"
$LAUNCH_MOSES 4001 -f $MODEL_PATH/model_zhen_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 4002 -f $MODEL_PATH/model_deen_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 4003 -f $MODEL_PATH/model_esen_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 4004 -f $MODEL_PATH/model_fren_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 4005 -f $MODEL_PATH/model_iten_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 4006 -f $MODEL_PATH/model_nlen_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 4007 -f $MODEL_PATH/model_plen_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 4008 -f $MODEL_PATH/model_pten_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 4009 -f $MODEL_PATH/model_roen_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 4010 -f $MODEL_PATH/model_ruen_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 4011 -f $MODEL_PATH/model_slen_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 4012 -f $MODEL_PATH/model_hren_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 4013 -f $MODEL_PATH/model_tren_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 4014 -f $MODEL_PATH/model_aren_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &
$LAUNCH_MOSES 4015 -f $MODEL_PATH/model_faen_ted/$MOSES_INI 0> $STDIN 1> $STDOUT 2> $STDERR &

echo -e "\n>>> 1.1 Launch CherryPy Web Server"

#echo -e "\n DEBUG: WWW_PATH: $WWW_PATH"
#echo -e "\n DEBUG: CMD_PREFIX: $CMD_PREFIX"
cd ~/$WWW_PATH
$CMD_PREFIX sudo python translate.py 0> $STDIN 1> $STDOUT 2> $STDERR &
#sudo python translate.py
echo -e "\n\n"



