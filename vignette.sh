#!/bin/bash

for filename in *.yml; do
  name=$(node_modules/.bin/js-yaml $filename | jq -r .name)

  if [ ! "$name" == "null" ]; then
    echo
    echo "  ${name}"
    echo

    node_modules/.bin/cartodb-yaml $filename > ${filename}.json
    node_modules/.bin/vignette -o vignettes/${name} -c places.json -w 600 -h 400 cartodb+file://./${filename}.json
  fi
done
