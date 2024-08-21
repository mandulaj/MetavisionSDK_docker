#!/bin/bash

if [ -z $USER_ID ]; then
	export USER_ID=`id -u`
	echo "USER_ID varibale not set. Setting to `id -u`: $USER_ID"
fi

if [ -z $GROUP_ID ]; then
	export GROUP_ID=`id -g`
	echo "GROUP_ID varible not set. Setting to `id -g`: $GROUP_ID"
fi

docker compose build metavisionsdk
