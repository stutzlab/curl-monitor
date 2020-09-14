# curl-monitor

Monitor sites remotelly by issuing curl commands periodically and monitoring results in Prometheus

## Usage

* Create docker-compose.yml

```yml
version: '3.5'
services:
  curlmonitor:
    image: flaviostutz/curl-monitor
    environment:
      CURL1_CMD: |-
        curl -s --fail -m 60 'https://www.uol.com.br'
        -H 'authority: alunos-backend.edidatico.com'
        -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.102 Safari/537.36'
        -H 'accept: */*'
        -H 'sec-fetch-site: same-site'
        -H 'sec-fetch-mode: cors'
        -H 'sec-fetch-dest: empty'
        -H 'accept-language: en-US,en;q=0.9,pt;q=0.8,da;q=0.7'
        -H 'if-none-match: W/"26f9a-5grr2u3PIDxMm2goW0cjl7f9QwU"'
        --compressed > /dev/null
      CURL1_NAME: uol-home
      CURL1_SLEEP: 1
      CURL1_PARALLEL: 2
```

* Run `docker-compose up -d`

* Get metrics at `curl localhost:8880/metrics`

ENVs

* CURL1_CMD - curl command to be executed from time to time. Ex.: curl --fail https://yahoo.com. required
* CURL1_NAME - label name on metrics for this job. defaults to job number (curl-3, curl-1)
* CURL1_SLEEP - sleep time between calls in seconds. defaults to 5
* CURL1_PARALLEL - how many curl tasks to run in parallel. defaults to 1

You can add multiple instructions for multiple curls running in parallel by incrementing numbers in labels. Ex: CURL1_CMD, CURL2_CMD, CURL3_CMD...