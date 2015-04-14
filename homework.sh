#/bin/bash
#DATE 5/10/2013
#API Variables

nytapi="16b91f70ea44e34abf27120c56090:0:67655429"
s3apikey="AKIAIA72GVHSEUEQ"
s3policy="eyJleHBW9uIjogIjIwMjAtMDEtMDFUMDA6MDA6MDBaIiwgICJjb25kaXRpb25zIjogWyAgICBbImVxIiwgIiRidWNrZXQiLCAiaG9tZXdvcmstdGVtYm9vIl0sICAgIFsic3RhcnRzLXdpdGgiLCAiJGtleSIsICIiXSwgICAgeyJhY2wiOiAicHVibGljLXJlYWQifSwgICAgWyJzdGFydHMtd2l0aCIsICIkQ29udGVudC1UeXBlIiwgIiJdLCAgICBbImNvbnRlbnQtbGVuZ3RoLXJhbmdlIiwgMiwgNTI0Mjg4MF0gIF19"

#Ask For Input

echo "Please Enter a Search Term"
read word

echo "Searching for: $word"

#Query

echo "Running Query"
#Query for encoding
curl -s --get --data-urlencode "api-key=$nytapi" --data-urlencode "query=$word" --data-urlencode "fields=title,body,date,url" http://api.nytimes.com/svc/search/v1/article? > $word-search.txt

#Upload
echo "Uploading Your Results"

curl -F "key=$word-search.txt" -F "acl=public-read" -F "AWSAccessKeyId=$s3apikey" -F "Policy=$s3policy" -F "Signature=KOb7lIHdsaB9eT6Fk6elUean2sA=" -F "Content-Type=text/plain" -F "file=@$word-search.txt" http://homework-temboo.s3.amazonaws.com

#Verifying Upload Happened

checkout=`curl -sI http://homework-temboo.s3.amazonaws.com/$word-search.txt | grep 'HTTP/1.1 200 OK' | cut -c 10-13`

if [[ "$checkout" -eq "200" ]];
        then
        echo "Upload was a Success!"
else    echo "Oh noes something is wrong"
	exit 1
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
	rm $word-search.txt
	exit 1
else	
	echo "Copy and paste then"
	echo "kthxbai"
	rm $word-search.txt
	exit 1

fi
