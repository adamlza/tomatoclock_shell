#!/usr/bin/bash
lth(){
	local c=$1
	local st=$2
	l=${#st}
	if [ $c == $l ];then
		echo $st
	else
		printf "%0.s0" `seq 1 $(($c-$l))`
		echo $st
	fi
}
s2t(){
	local sec=$1
	d=$(($sec/86400))
	h0=$(($sec%86400/3600))
	hh=`lth 2 $h0`
	m0=$(($sec%3600/60))
	mm=`lth 2 $m0`
	s0=$(($sec%60))
	ss=`lth 2 $s0`
	if [ $d != 0 ];then
		echo "$d"d"$hh"h"$mm"m"$ss"s
	elif [[ $d0 == 0 && $h0 != 0 ]];then
		echo "$hh"h"$mm"m"$ss"s
	elif [[ $(($d0+$h0)) == 0 && $m0 != 0 ]];then
		echo "$mm"m"$ss"s
	elif [[ $(($d0+$h0+$m0)) == 0 ]];then
		echo "$ss"s
	fi
}
greenclock(){
	local m=$1
	for time in `seq 0 $(($m*60))`;do
		if [ $time -lt $(($m*60)) ];then
			printf "         \r\e[1;32m %s \e[0m" `s2t $(($m*60-$time))`
			sleep 1
		else
			printf "         \r\e[1;32m %s \e[0m\n" `s2t $(($m*60-$time))`
		fi
	done
}
tomatoclock(){
	local mw=$1
	local mr=$2
	local mlr=$3
	local cyc=$4
	for ro in `seq 1 $cyc`;do
		if [ $ro -lt $cyc ];then
			echo round \#"$ro"/$cyc
			printf "\rStart to Work?[y]:"
			read -e judge
			if [ $judge == y ];then
				greenclock $mw
				espeak It's time to having rest'
			fi
			printf "\rStart to Rest?[y]:"
                        read -e judge1
			if [ $judge == y ];then
                                greenclock $mr
				espeak It's time to work'
			fi
		else
			echo round \#"$ro"/$cyc
                        printf "\rStart to Work?[y]:"
                        read -e judge
                        if [ $judge == y ];then
                                greenclock $mw
				espeak It's time to having long rest'
			fi
			printf "\rStart to Long Rest?[y]:"
                        read -e judge1
                        if [ $judge == y ];then
                                greenclock $mlr
                                espeak It's time to start a new turns'
                        fi
		fi
	done
}

tomatoclock 25 5 15 3
# 朴实无华的番茄钟，只需根据自己需要改最后一行就好
# tomatoclock $工作时长 $休息时长 $长休息时长 $循环轮数
# espeak 可替换为mpv/mplayer
