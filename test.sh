#!/bin/sh

rm -rf lua_roman
mkdir -p lua_roman

i=0
for f in MISSIONS_roman/*
do
    python rtx2lua.py $f > lua_roman/MISS20$i.lua
    echo $f $?
    python rtx2lua.py $f roman > /dev/null
    echo $f $?
    i=$((i+1))
done

rm -rf lua_fanpaign
mkdir -p lua_fanpaign

i=0
for f in MISSIONS_fanpaign/*
do
    python rtx2lua.py $f FANpaign TXT_fanpaign > lua_fanpaign/MISS20$i.lua
    echo $f $?
    i=$((i+1))
done

rm -rf lua_2ndpaign
mkdir -p lua_2ndpaign

i=0
for f in MISSIONS_2ndpaign/*
do
    python rtx2lua.py $f 2NDpaign TXT_2ndpaign > lua_2ndpaign/MISS20$i.lua
    echo $f $?
    i=$((i+1))
done
