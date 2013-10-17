#!/bin/bash -x

i=0
sizes=(60 57 40 29)

iconset="${1%.*}".iconset
rm -rf $iconset
mkdir -p $iconset

cp $1 $iconset/orig.png

while [ $i -lt ${#sizes[@]} ]; do
base=icon_${sizes[$i]}x${sizes[$i]}
cp $iconset/orig.png $iconset/$base@2x.png
cp $iconset/orig.png $iconset/$base.png 
size2x=`expr ${sizes[$i]} \* 2` 
sips -z ${size2x} ${size2x} $iconset/$base@2x.png &>/dev/null
sips -z ${sizes[$i]} ${sizes[$i]} $iconset/$base.png &>/dev/null

: $[ i++ ]
done

rm -f $iconset/orig.png
#rm $iconset/icon_{x,6}*

#iconutil -c icns $iconset
#rm -rf $iconset
