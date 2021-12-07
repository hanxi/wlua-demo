#!/bin/bash

cd /wlua/wlua-demo
wlua start
tail -F log/wlua.log

