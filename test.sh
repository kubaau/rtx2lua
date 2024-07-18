#!/bin/sh

for f in MISSIONS/*
do
    python rtx2lua.py $f > /dev/null
    echo $f $?
    python rtx2lua.py $f campaign_name > /dev/null
    echo $f $?
done

for f in MISSIONS_fanpaign/*
do
    python rtx2lua.py $f fanpaign TXT_fanpaign > /dev/null
    echo $f $?
done
