#!/bin/bash


if [ "$#" -eq 2 ]; then
    period=$1
    exp_list=$2
else
    echo Enter period, "ref exp1 exp2 ..."!
    exit
fi
echo condition in movero-ch-GLOB is on!!!!!
echo CLCT-extraction of CLCT from mod is per gridpoint, not diskaverage as usual!!


if [ $period = period1 ];
then
range="2019021300,2019022000"
range_dir="2019021300-2019022000"
fi

if [ $period = period2 ];
then
range="2019062300,20190629"
range_dir="2019062300-20190629"
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

w_dir="/scratch/juckerj/verify/synop/wd/${range_dir}_CLCT"

echo "############ moving to $w_dir #############"
cd $w_dir

for exp in $exp_list ; do
    
    echo "###### moving to C2E_${exp}@ch ########"
    cd C2E_${exp}@ch
    

    exe="../mod_data/C2E_${exp}_ch_f/<bt_yyyy><bt_mm><bt_dd><bt_hh>syn.atab"
    sed "26 s|$exe|mod01-24_<name>.dat|" movero01-24_syn.nl > movero01-24_syn_tmp.nl
    sed '39 s|mod01-24_<name>.dat|mod01-24_<name>_jj.dat|' movero01-24_syn_tmp.nl > movero01-24_syn.nl 
    sed '93 s|mod(CLCT)|obs(CLCT)|' movero01-24_syn.nl > movero01-24_syn_tmp.nl
    mv movero01-24_syn_tmp.nl movero01-24_syn.nl
            
    exe="../mod_data/C2E_${exp}_ch_f/<bt_yyyy><bt_mm><bt_dd><bt_hh>syn.atab"
    sed "26 s|$exe|mod25-48_<name>.dat|" movero25-48_syn.nl > movero25-48_syn_tmp.nl
    sed '39 s|mod25-48_<name>.dat|mod25-48_<name>_jj.dat|' movero25-48_syn_tmp.nl > movero25-48_syn.nl
    sed '93 s|mod(CLCT)|obs(CLCT)|' movero25-48_syn.nl > movero25-48_syn_tmp.nl
    mv movero25-48_syn_tmp.nl movero25-48_syn.nl        

    exe="../mod_data/C2E_${exp}_ch_f/<bt_yyyy><bt_mm><bt_dd><bt_hh>syn.atab"
    sed "26 s|$exe|mod49-72_<name>.dat|" movero49-72_syn.nl > movero49-72_syn_tmp.nl
    sed '39 s|mod49-72_<name>.dat|mod49-72_<name>_jj.dat|' movero49-72_syn_tmp.nl > movero49-72_syn.nl
    sed '93 s|mod(CLCT)|obs(CLCT)|' movero49-72_syn.nl > movero49-72_syn_tmp.nl
    mv movero49-72_syn_tmp.nl movero49-72_syn.nl

    cd ..
done

echo "######### all namelists changed ###########"






