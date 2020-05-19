#!/bin/bash

# This file is here just to demonstrate how you could use xmllint with this schema

# get dir this script is in
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

SCHEMA_FOLDER="$DIR/cioos_iso_validate/schema"

if [ -e "$1" ]
then
    XML_CATALOG_FILES=$SCHEMA_FOLDER/../catalog.xsd xmllint --noout --schema "$SCHEMA_FOLDER"/standards.iso.org/iso/19115/-3/mds/2.0/mds.xsd "$1"  --nowarning
else
    echo "USAGE: sh $0 myrecord.xml"
fi
