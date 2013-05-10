#/bin/bash

#Ask For Input

echo "Please Enter a Search Term"
read word

echo "Searching for: $word"

#Query

echo "Running Query"
#Query for encoding
curl -s --get --data-urlencode "api-key=16b91f70ea44e34abf2712004fc56090:0:67655429" --data-urlencode "query=$word" --data-urlencode "fields=title,body,date,url" http://api.nytimes.com/svc/search/v1/article? > $word-search.txt

#Upload
echo "Uploading Your Results"

curl -F "key=$word-search.txt" -F "acl=public-read" -F "AWSAccessKeyId=AKIAIA72G2ZKFVHSEUEQ" -F "Policy=eyJleHBpcmF0aW9uIjogIjIwMjAtMDEtMDFUMDA6MDA6MDBaIiwgICJjb25kaXRpb25zIjogWyAgICBbImVxIiwgIiRidWNrZXQiLCAiaG9tZXdvcmstdGVtYm9vIl0sICAgIFsic3RhcnRzLXdpdGgiLCAiJGtleSIsICIiXSwgICAgeyJhY2wiOiAicHVibGljLXJlYWQifSwgICAgWyJzdGFydHMtd2l0aCIsICIkQ29udGVudC1UeXBlIiwgIiJdLCAgICBbImNvbnRlbnQtbGVuZ3RoLXJhbmdlIiwgMiwgNTI0Mjg4MF0gIF19" -F "Signature=KOb7lIHdsaB9eT6Fk6elUean2sA=" -F "Content-Type=text/plain" -F "file=@$word-search.txt" http://homework-temboo.s3.amazonaws.com

#Verifying Upload Happened

checkout=`curl -sI http://homework-temboo.s3.amazonaws.com/$word-search.txt | grep 'HTTP/1.1 200 OK' | cut -c 10-13`

echo $checkout

if [[ "$checkout" -eq "200" ]];
        then
        echo "Success"
else    echo "Oh noes something is wrong"
fi

#Results
echo "You can see your JSON file here: http://homework-temboo.s3.amazonaws.com/$word-search.txt"

#For the Lazy
echo "If you're on OSX would you like me to open the URL in Safari?"
echo "Type yes otherwise a return will exit the app."

read lazy

if [[ "$lazy" =  "yes" ]]
	then
	echo "To the interwebs!"
	open -a Safari http://homework-temboo.s3.amazonaws.com/$word-search.txt
	exit 1
else	
	echo "Copy and paste then"
	exit 1

fi

echo "kthxbai"
