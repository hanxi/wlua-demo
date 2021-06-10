#!/bin/sh

curl -i http://127.0.0.1:8081/foo?a=b

curl -i http://127.0.0.1:8081/foobar

curl -H "Content-Type: application/json" -d '{"username":"xyz","password":"xyz"}' -i http://127.0.0.1:8081/foo/?b=c

curl -i http://127.0.0.1:8081/json

