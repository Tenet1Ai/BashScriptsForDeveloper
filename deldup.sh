#!/bin/bash -x
/Applications/Tools/fdupes . | awk '{if(NR%3==1) print}' | xargs rm -f
