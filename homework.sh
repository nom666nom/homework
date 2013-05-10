#/bin/bash

#Ask For Input

echo "Please Enter a Search Term"
read word

echo "Searching for $word"

#Query

#Working Test Query
#curl --data-urlencode "http://api.nytimes.com/svc/search/v1/article?query=$word&api-key=16b91f70ea44e34abf2712004fc56090:0:67655429"

echo "Running Query"
#Query for encoding
curl -v --get --data-urlencode "api-key=16b91f70ea44e34abf2712004fc56090:0:67655429" --data-urlencode "query=$word" http://api.nytimes.com/svc/search/v1/article? > $word-search.txt

#Upload
echo "Uploading Your Results"

curl -F "key=$word-search.txt" -F "acl=public-read" -F "AWSAccessKeyId=AKIAIA72G2ZKFVHSEUEQ" -F "Policy=eyJleHBpcmF0aW9uIjogIjIwMjAtMDEtMDFUMDA6MDA6MDBaIiwgICJjb25kaXRpb25zIjogWyAgICBbImVxIiwgIiRidWNrZXQiLCAiaG9tZXdvcmstdGVtYm9vIl0sICAgIFsic3RhcnRzLXdpdGgiLCAiJGtleSIsICIiXSwgICAgeyJhY2wiOiAicHVibGljLXJlYWQifSwgICAgWyJzdGFydHMtd2l0aCIsICIkQ29udGVudC1UeXBlIiwgIiJdLCAgICBbImNvbnRlbnQtbGVuZ3RoLXJhbmdlIiwgMiwgNTI0Mjg4MF0gIF19" -F "Signature=KOb7lIHdsaB9eT6Fk6elUean2sA=" -F "Content-Type=text/plain" -F "file=@$word-search.txt" http://homework-temboo.s3.amazonaws.com

#Verifying Upload Happened

checkout=`curl -sI http://homework-temboo.s3.amazonaws.com/$word-search.txt | grep 'HTTP/1.1 200 OK'`

echo $checkout

#Results
echo "You can see your JSON file here: http://homework-temboo.s3.amazonaws.com/$word-search.txt"

