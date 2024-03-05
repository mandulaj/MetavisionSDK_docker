#!/bin/bash

if [ -z $USER_ID ]; then
	echo "USER_ID varibale not set"
	exit 1;
fi

if [ -z $GROUP_ID ]; then
	echo "GROUP_ID varible not set"
	exit 1;
fi

docker compose build metavisionsdk
