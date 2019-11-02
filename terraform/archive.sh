#!/bin/sh

cd "${2}" || exit

zip -r "$1" *.js node_modules/ >/dev/null 2>&1

mv "$1" ../terraform

echo "{}"
