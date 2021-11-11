# Check .onion URLs

A simple script for checking .onion URLs against ahmia.fi's blacklist. Not completely done yet. 

Usage:

<pre>
$ ./check_onion_urls.sh
Check if an .onion URL is blacklisted.

Syntax: ccsam.sh [-u|b|w|r]
Example: ./ccsam.sh url.onion -b /home/user/blacklist.spamhaus

Options:
u     URL to be checked
b     Blacklist file to used. Default: /tmp/blacklist.txt
w     Get blacklist from alternative source. Default: ahmia.fi
r     Refresh, i.e. update blacklist.
</pre>
