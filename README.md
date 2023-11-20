Docker environment for the Metavision SDK
=========================================

Includes the full metavision SDK including the metavision_studio app


## Installation
In order to install the metavision_sdk, you have to collect your own metavision.list from the prophesee website.  Sign up at https://www.prophesee.ai/metavision-intelligence-sdk-download/ and save metavision.list from to the root of the repository directory.

```bash

cp ~/Downloads/metavision.list metavision22.list
# Build the docker container
./build_docker.sh

# Start the docker container attached to nvidia gpu
./metavision_docker.sh

```