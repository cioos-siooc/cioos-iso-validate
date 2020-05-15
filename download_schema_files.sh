#!/bin/sh

# Download .xsd files needed for validation.

# requires unzip, wget
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )" || return
SCHEMA_FOLDER="$SCRIPTPATH/cioos_iso_validate/schema"
rm -rf "$SCHEMA_FOLDER"
mkdir "$SCHEMA_FOLDER"
cd "$SCHEMA_FOLDER" || return

wget http://standards.iso.org/iso/19115/19115AllNamespaces.zip
wget http://schemas.opengis.net/gml/gml-3_2_1.zip

# -x to make directory structure from URL
wget -x http://www.w3.org/1999/xlink.xsd
wget -x http://www.w3.org/2001/xml.xsd
wget http://schemas.opengis.net/iso/19139/iso19139-20070417.zip
unzip -q iso19139-20070417.zip
unzip -q iso19139-20070417_4-v20180321.zip -d schemas.opengis.net

unzip gml-3_2_1.zip
mkdir -p standards.iso.org/ittf/PubliclyAvailableStandards
unzip -q -d standards.iso.org/ittf/PubliclyAvailableStandards -j gml-3_2_1_2.zip

mkdir -p standards.iso.org/iso
unzip -q 19115AllNamespaces.zip -d standards.iso.org/iso

# clean up
rm -f ./*.zip



