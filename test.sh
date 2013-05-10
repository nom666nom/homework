#/bin/bash

checkout=`curl -sI http://homework-temboo.s3.amazonaws.com/monkey2-search.txt | grep 'HTTP/1.1 200 OK' | cut -c 10-13`

echo $checkout

if [[ "$checkout" -eq "200" ]];
        then
        echo "Success"
else    echo "Fail"
fi
