#!/bin/sh

FILE=$1 #=/tmp/blacklist.txt

if [  -z $1  ]; 
then

    # Display Help
    echo "Check if an .onion URL is blacklisted."
    echo " "
    echo "Syntax: ccsam.sh [-u|b|w|r]"
    echo "Example: ./ccsam.sh url.onion -b /home/user/blacklist.spamhaus"
    echo
    echo "Options:"
    echo "u     URL to be checked"
    echo "b     Blacklist file to used. Default: /tmp/blacklist.txt"
    echo "w     Get blacklist from alternative source. Default: ahmia.fi"
    echo "r     Refresh, i.e. update blacklist."

else 
    # Check if $2 is a file or a string

    #MD5=$(echo -e "$2" | md5sum)
    VAR=$(echo -e "$2" | md5sum )
    echo "Checking status for URL MD5: $VAR in file $1" 
    
    if [ -f $FILE ];
    then 
        echo "Black list exists. Continuing."
    else
        wget -O /tmp/blacklist.txt "https://ahmia.fi/blacklist/banned/"
    fi
    
    # Result 
    RESULT=$(cat $FILE | grep -q $VAR)
    echo "Res: $RESULT"

    if cat "$FILE" | grep -q "$VAR";
    then
        echo "$2 : $VAR is blacklisted. DO NOT VISIT THE SITE."
    else
        echo "$2 : $VAR is not blacklisted according to ahmia.fi."
    fi 
fi
