#!/bin/bash

docker build -t registry.git.ee.ethz.ch/pbl/research/armasuisse/armasuisse-2023/metavisionsdk_docker/metavision22:latest -f Dockerfile_base .

docker push registry.git.ee.ethz.ch/pbl/research/armasuisse/armasuisse-2023/metavisionsdk_docker/metavision22:latest