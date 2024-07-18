#!/bin/sh

for f in MISSIONS_roman/*
do
    mkdir -p lua_roman
    python rtx2lua.py $f > lua_roman/$(basename ${f}).lua
    echo $f $?
    python rtx2lua.py $f roman > /dev/null
    echo $f $?
done

for f in MISSIONS_fanpaign/*
do
    mkdir -p lua_fanpaign
    python rtx2lua.py $f fanpaign TXT_fanpaign > lua_fanpaign/$(basename ${f}).lua
    echo $f $?
done
