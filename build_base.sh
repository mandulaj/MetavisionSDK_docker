#!/bin/bash

if [ ! -f ./metavision22.list ]; then
	echo "Please download the metavision22.list file"
	exit 1;
fi



docker compose build base

docker compose push base
