#!/bin/sh
toHex()
{
	str=$1
	sub_str=`echo ${str}|awk '{print substr($0,1,2)}'`
	if [ $sub_str != "0x" ]; then
		str=`echo ${str}|sed s/0x//g`
		echo "ibase=10;obase=16;$str"|bc
		return
	fi
	echo ${str}|sed s/0x//g
}

hexAdd()
{
	str1=$1
	str2=$2
	str1=`echo ${str1}|sed s/0x//g|tr '[a-z]' '[A-Z]'`
	str2=`echo ${str2}|sed s/0x//g|tr '[a-z]' '[A-Z]'`
	
	ret=`echo "ibase=obase=16;${str1} + ${str2}"|bc`
	echo "0x"${ret}
}

help()
{
	echo "Go to .xcarchive directory,"
	echo "Usage: read_dsym.sh [arch] [stack address]"
	echo "For example: read_dsym.sh armv7 790799"
	exit
}

if [ $# != 2 ]; then
	help
fi
if [ $1 == "--help" ]; then
	help
fi

ARCH=$1
CODE=$2

if [ $ARCH != "armv7" -a $ARCH != "armv7s" -a $ARCH != "armv6" -a $ARCH != "arm64" ]; then
	echo "arch is error,must be arm64/armv7s/armv7/armv6"
	help
	exit
fi

APPPATH=`find . -name "*.app"`
APPNAME=`echo $APPPATH|awk -F'/' '{print $4}'|sed s/\.app//g`
echo $APPNAME

CODE=`toHex $CODE`
cd $APPPATH
SLIDE=`otool -arch ${ARCH} -l ./"$APPNAME"| grep -B 3 -A 8 -m 2 "__TEXT"|grep vmaddr|awk '{print $2}'`
SLIDE=`toHex $SLIDE`
SYMBOLADDR=`hexAdd $CODE $SLIDE`

cd -
echo "dwarfdump --lookup ${SYMBOLADDR} --arch ${ARCH} dSYMs/${APPNAME}.app.dSYM/Contents/Resources/DWARF/${APPNAME}" | bash -x
