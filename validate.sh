#!/bin/bash
# get dir this script is in
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

SCHEMA_FOLDER="$DIR/validator/schema"

if [ -e "$1" ]
then
    XML_CATALOG_FILES=$SCHEMA_FOLDER/../catalog.xsd xmllint --noout --schema "$SCHEMA_FOLDER"/standards.iso.org/iso/19115/-3/mds/2.0/mds.xsd "$1"  --nowarning
else
    echo "USAGE: sh $0 myrecord.xml"
fi
