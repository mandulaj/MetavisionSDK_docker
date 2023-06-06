#!/bin/bash

docker-compose build --build-arg username="$USER" --build-arg password="password" --build-arg user_id="$UID"