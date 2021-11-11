#!/bin/bash

FILE=$1 #=/tmp/blacklist.txt

check_url () {
    # Remove HTTP prefix
    URL=$(echo $1 | sed 's/http:\/\///g')
    VAR=$(echo -e "$URL" | md5sum)
    RET=0
    echo "Checking status for URL:" 
    echo "  URL: $URL"
    echo "  MD5: $VAR"
    
    if cat "$FILE" | grep -q "$VAR";
    then
        echo "  Result: blacklisted. DO NOT VISIT THE SITE."
        RET=1
    else
       # echo "  Result: not blacklisted according to ahmia.fi."
        RET=0
    fi

    return $RET
}

if [  -z $1  ]; 
then
    # Display Help - not implemented yet.
    echo "Check if an .onion URL is blacklisted."
    echo " "
    echo "Syntax: ccsam.sh [-u|b|w|r]"
    echo "Example: ./ccsam.sh url.onion -b /home/user/blacklist.spamhaus"
    echo
    echo "Options:"
    echo "u     URL to be checked. Could be a file with URLs as well."
    echo "b     Blacklist file to used. Default: /tmp/blacklist.txt"
    echo "w     Get blacklist from alternative source. Default: ahmia.fi"
    echo "r     Refresh, i.e. update blacklist."

else
    # Set blacklist 
    if [ -f $FILE ];
    then 
        echo "Black list exists. Continuing."
    else
        wget -O /tmp/blacklist.txt "https://ahmia.fi/blacklist/banned/"
        FILE=/tmp/blacklist.txt
    fi

    # Check if $2 is a file or a string
    if [ -f "$2" ]; 
    then
        while IFS= read -r line; 
        do
            # Read URL line and check the URL against the database
            check_url "$line"
        done < "$2"
    # Otherwise we assume it is a URL string
    else 
        check_url $2
    fi
fi
