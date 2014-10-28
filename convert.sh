#!/bin/bash -x
for i in `ls`
  do cd $i
  echo $?
  if [ $? -eq 0 ]
    then find *.java -exec sh -c "iconv -f GBK -t UTF-8 \"{}\" > \"{}\".txt" \;
    rm -f *.java
    for i in `ls`; do j=`basename $i .txt`; mv $i $j; done
    cd ..
  fi
done
pwd
