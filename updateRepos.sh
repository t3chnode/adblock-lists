#!/bin/bash

unset IFS
for x in $(ls -Ut ./sourceLists | xargs -n 1 basename) ; do
    URLs=()
    while IFS= read -r line; do
        URLs+=("$line")
    done <"./sourceLists/$x"
    #Uncomment for debugging
    echo -e "Now doing $x"
    fullList=()
    IFS=' '
    for z in "${URLs[@]}"
    do
        fullList+=$(curl -s "$z")
    done
    fullListClean=$(echo $fullList | sort -u | sed '/^#/d' | sed '/^ /d' | sed '/^$/d')
    echo $fullListClean > "./uploadLists/$x"
    unset IFS
done
git add .
git commit -m "Auto Update: $(date --iso-8601)"
git push origin master --force
