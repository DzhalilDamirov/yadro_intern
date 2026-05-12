#!/bin/bash

URLS=(
  "https://httpstat.us/100"
  "https://httpstat.us/200"
  "https://httpstat.us/301"
  "https://httpstat.us/404"
  "https://httpstat.us/500"
)

processed=0

for url in "${URLS[@]}"; do
  echo "INFO | Выполняю запрос: $url"

  response=$(curl -s -w "HTTP_STATUS:%{http_code}" "$url")

  body=$(echo "$response" | sed -e 's/HTTP_STATUS\:.*//g')
  status_code=$(echo "$response" | tr -d '\n' | sed -e 's/.*HTTP_STATUS://')

  if [ "$status_code" -ge 100 ] && [ "$status_code" -lt 400 ]; then
    echo "INFO | Код статуса: $status_code"
    echo "INFO | Тело ответа: $body"
  elif [ "$status_code" -ge 400 ] && [ "$status_code" -lt 555 ]; then
    echo "ERROR | EXCEPTION_HTTP $status_code. Тело ответа: $body"
  else
    echo "ERROR | Неизвестный статус-код: $status_code"
  fi

  ((processed++))
  echo "--------------------------------------------------"
done

echo "Обработано запросов: $processed"
