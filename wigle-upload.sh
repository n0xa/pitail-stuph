#!/bin/sh
# Upload a Wigle-CSV format file to WiGLE.net.
# YOU NEED TO HAVE AN API KEY.
# Visit https://wigle.net/account and select "Show my token"
# Replace the values below with your actual API credentials
APINAME='deadb33fdeadb33fd34db33fd34db33f000'
APITOKEN='abcdefabcdefabcdefabcdefabcdef00'

curl -i -H 'Accept:application/json' -u ${APINAME}:${APITOKEN} --basic https://api.wigle.net/api/v2/file/upload -F file=@$1
