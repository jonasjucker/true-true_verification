#!/bin/bash


if [ "$#" -eq 4 ]; then
    period=$1
    stations=$2
    CLCT=$3
    exp_list=$4
else
    echo Enter period, enter TRUE/FALSE for station_based verification, enter TRUE/FALSE for CLCT-based verification, enter "ref exp1 exp2 ..."!
    exit
fi

if [ $period = period1 ];
then
range="2019021300,2019022000"
range_dir="2019021300-2019022000"
fi

if [ $period = period2 ];
then
range="2019062300,2019062900"
range_dir="2019062300-2019062900"
fi

if [ $period = period3 ];
then
range="2018120100,2018120700"
range_dir="2018120100-2018120700"
fi

if [ $period = period4 ]; then
range="2018060600,2018061200"
range_dir="2018060600-2018061200"
fi

if [ $period = period4_extended ]; then
range="2018060100,2018061500"
range_dir="2018060100-2018061500"
fi

if [ $period = period4_short ]; then
range="2018061500,2018061500"
range_dir="2018061500-2018061500"
fi
if [ $period = period5 ];
then
range="2019040100,2019041000"
range_dir="2019040100-2019041000"
fi

if [ $period = period6 ];
then
range="2019060100,2019063000"
range_dir="2019060100-2019063000"
fi

#True-True verifiaction
if [ $CLCT = TRUE ]; then
    execute="--base-time=${range} --force=make_html --config=c2e_cloudrad.exp --directory=${range_dir}_CLCT ${exp_list}"
    echo "execute: $execute"
    batchPP -p pp-serial "./syn_verify $execute"

#station-based verification
elif [ $stations = TRUE ] && [ $CLCT = FALSE ];then
    execute="--station-selection=flat --base-time=${range}  --station-list-action=R  --config=c2e_cloudrad.exp ${exp_list}"
    echo "execute: $execute"
    sbatch ./syn_verify $execute 

#normal verification
elif [ $stations = FALSE ] && [ $CLCT = FALSE ];then
    execute="--base-time=${range}  --force=make_html --config=c2e_cloudrad.exp ${exp_list}"
    echo "execute: $execute"
    batchPP -p pp-serial  "./syn_verify $execute" 

else
    echo "WARNING: Not a valid parameter combination"

fi
