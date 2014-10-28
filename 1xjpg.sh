#!/bin/bash
for f in $(find . -name '*@2x.jpg'); do
    echo "Converting $f..."
    convert "$f" -resize '50%' "$(dirname $f)/$(basename -s '@2x.jpg' $f).jpg"
done
