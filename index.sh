#!/bin/bash

timeout=0

while :;do

result=$(curl -sfL 'https://www.jr.cyberstation.ne.jp/jcs/Vacancy.do'   -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7'   -H 'Accept-Language: ja,en-US;q=0.9,en;q=0.8'   -H 'Cache-Control: max-age=0'   -H 'Connection: keep-alive'   -H 'Content-Type: application/x-www-form-urlencoded'   -H 'Origin: https://www.jr.cyberstation.ne.jp'   -H 'Referer: https://www.jr.cyberstation.ne.jp/jcs/VacancyInput.do'   -H 'Sec-Fetch-Dest: document'   -H 'Sec-Fetch-Mode: navigate'   -H 'Sec-Fetch-Site: same-origin'   -H 'Sec-Fetch-User: ?1'   -H 'Upgrade-Insecure-Requests: 1'   -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36'   -H 'sec-ch-ua: "Chromium";v="142", "Google Chrome";v="142", "Not_A Brand";v="99"'   -H 'sec-ch-ua-mobile: ?0'   -H 'sec-ch-ua-platform: "macOS"'   --data-raw 'lang=ja&month=11&day=24&hour=16&minute=40&train=1&dep_stnpb=5165&arr_stnpb=4045&script=1' | grep -A 5 '６５８号' | tail -n 1 | grep -E '△|○' || true)

if [[ "${result}" ]];then
  echo "found"
	curl --location --request POST "${SLACK_WEBHOOK_URL}"  --header 'Content-Type: application/json' --data-raw '{"text":"見つかったよ"}'
else
  echo "not found"
fi

if [[ "${timeout}" -ge 1800 ]];then
  echo "timeout reached 1800s"
  exit 0
fi

sleep 5
timeout=$((timeout+5))

done