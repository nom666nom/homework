#/bin/bash

#Ask For Input

echo "Please Enter a Search Term"
read word

echo "Searching for $word"

#Query

#Working Test Query
#curl --data-urlencode "http://api.nytimes.com/svc/search/v1/article?query=$word&api-key=16b91f70ea44e34abf2712004fc56090:0:67655429"


#Query for encoding
curl -v --get --data-urlencode "api-key=16b91f70ea44e34abf2712004fc56090:0:67655429" --data-urlencode "query=$word" http://api.nytimes.com/svc/search/v1/article?



