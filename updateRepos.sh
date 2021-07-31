#!/bin/bash
adlistsGitURL="https://raw.githubusercontent.com/seedlessnetwork/advocado/master/blocklists/adlists.txt"
malwareGitURL="https://raw.githubusercontent.com/seedlessnetwork/advocado/master/blocklists/malware.txt"
phishingGitURL="https://raw.githubusercontent.com/seedlessnetwork/advocado/master/blocklists/phishing.txt"
seasonscamsGitURL="https://raw.githubusercontent.com/seedlessnetwork/advocado/master/blocklists/seasonalscams.txt"
trackingGitURL="https://raw.githubusercontent.com/seedlessnetwork/advocado/master/blocklists/tracking.txt"
unclassifiedGitURL="https://raw.githubusercontent.com/seedlessnetwork/advocado/master/blocklists/unclassified.txt"

sourceDir="/home/anon/adlists/sourceLists/"
uploadDir="/home/anon/adlists/uploadLists/"

unset IFS
for x in $(ls -Ut $sourceDir | xargs -n 1 basename) ; do
    URLs=()
    while IFS= read -r line; do
        URLs+=("$line")
    done <$sourceDir$x
    #Uncomment for debugging
    echo -e "Now doing $x"
    fullList=()
    IFS=' '
    for z in "${URLs[@]}"
    do
        fullList+=$(curl -s "$z")
    done
    fullListClean=$(echo $fullList | sort -u | sed '/^#/d' | sed '/^ /d' | sed '/^$/d')
    echo $fullListClean > $uploadDir$x
    unset IFS
done
git add .
git commit -m "Auto Update: $(date --iso-8601)"
git push origin master