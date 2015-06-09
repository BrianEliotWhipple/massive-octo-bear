#!/bin/sh

# Build Java Echo service docker image - assumes shadow jar already built.
cd /services/java/echo
./docker_build.sh
