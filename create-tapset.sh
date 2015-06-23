#!/bin/bash

SERVER_LIB_JVM=$1
CLIENT_LIB_JVM=$2

SRC_TAPSET_DIR=tapset-1.9.0
TAPSET_DIR=systemtap-tapset

validateJavaLib() {
	if [ -z "${SERVER_LIB_JVM}" ]
	then
		printf "ERROR: SERVER_LIB_JVM is not provided\n" 1>&2
		usageHelp
	fi
}

processOptional() {
	if [ -z "${CLIENT_LIB_JVM}" ]
	then
		CLIENT_LIB_JVM=$SERVER_LIB_JVM
	fi
}

usageHelp() {
	echo
	echo 'Usage : Script [SERVER_LIB_JVM] optional [CLIENT_LIB_JVM]'
	echo
	echo 'If CLIENT_LIB_JVM is not provided then SERVER_LIB_JVM will be used instead'
	echo 'sample : create-tapset.sh <JAVA_HOME>/lib/amd64/server/libjvm.so <JAVA_HOME>/lib/amd64/client/libjvm.so'
	echo 
	exit 1
}

validateJavaLib
processOptional

# create tapset dir where tapset will be placed
mkdir -p $TAPSET_DIR
cp $SRC_TAPSET_DIR/*.stp $TAPSET_DIR

# replace HEADWORD_SIZE
bits=`getconf LONG_BIT`
headwordsize=$((bits/8))

cd $TAPSET_DIR
sed -i "s/__HEADWORD_SIZE/$headwordsize/g" *
# replace @ABS_CLIENT_LIBJVM_SO@ and @ABS_SERVER_LIBJVM_SO@
sed -i "s|@ABS_CLIENT_LIBJVM_SO@|$CLIENT_LIB_JVM|g" *
sed -i "s|@ABS_SERVER_LIBJVM_SO@|$SERVER_LIB_JVM|g" *
cd ..

