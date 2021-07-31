#!/bin/bash
#sort /tmp/test.txt | uniq > /tmp/yote.txt
#homeDir="/home/caleb/Documents/githubrepos/advocado/blocklists/"
#test -d "${homeDir}" && echo "Github repo in correct place, proceeding with repo updates." || echo "Github repo missing, exiting." && exit 1

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
    #IFS=' '
    #URLs=$(readarray -t URLs < $sourceDir$x)
    #URLs=$(<$sourceDir$x)
    URLs=()
    while IFS= read -r line; do
        URLs+=("$line")
    done <$sourceDir$x
    echo -e "\nNow doing $x\n"
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

