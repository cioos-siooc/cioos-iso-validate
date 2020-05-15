#!/bin/bash

# Run tests and schema validation using Docker if it's installed

if [ -x "$(command -v docker)" ]; then
   docker build --force-rm . -t cioos_iso_validate && docker image rm cioos_iso_validate
else
    echo "Docker is not installed"
fi