#!/bin/sh

cd ../src || exit

yarn install --production >/dev/null 2>&1

echo "{}"
