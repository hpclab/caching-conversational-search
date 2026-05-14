#!/bin/bash

CURR_DIR=
RR_FILE=$1   
METHOD=$1

DATA_DIR=
QREL=${DATA_DIR}/eval_topics.qrel

cat ${CURR_DIR}/${RR_FILE} | awk -v method="$METHOD" '{print $1, "Q0", $2, $3, 1000-$3, method}' > ${CURR_DIR}/${RR_FILE}.trec

TREC_PATH=../../trec_eval/trec_eval
./$TREC_PATH -m map -m recip_rank -m ndcg_cut.3 -m P.1,3 -m recall.200 -q ${QREL} ${CURR_DIR}/${RR_FILE}.trec > ${CURR_DIR}/${RR_FILE}.trec.eval.6m
