#!/bin/bash
for f in $(find . -name '*@2x.png'); do
    echo "Converting $f..."
    convert "$f" -resize '50%' "$(dirname $f)/$(basename -s '@2x.png' $f).png"
done
