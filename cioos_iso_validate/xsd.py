#!/usr/bin/env python3

'''
XSD validation is the second stage of validation. It can return multiple
errors.

It checks the XML document against the schema starting at XSD_PATH

It uses the catalog.xsd to translate URLs to folder directories, so it doesn't
need to do any HTTP requests

'''

import os
from typing import List
from lxml import etree


FOLDER_PATH = os.path.dirname(os.path.realpath(__file__))
XSD_PATH = FOLDER_PATH+'/schema/standards.iso.org/iso/19115/-3/mds/2.0/mds.xsd'

CATALOG_PATH = FOLDER_PATH + "/catalog.xsd"

if not os.path.isfile(CATALOG_PATH):
    raise Exception("Cant find catalog file at " + CATALOG_PATH)

os.environ['XML_CATALOG_FILES'] = CATALOG_PATH


def xsd_validate(xml_to_validate: str) -> List[dict]:
    'Gets list of validation errors for this document'
    xmlschema = etree.parse(XSD_PATH)
    xsd_validator = etree.XMLSchema(xmlschema)

    xml_tree = etree.fromstring(xml_to_validate)

    xsd_validator.validate(xml_tree)

    errors = [{"type": 'xsd',
               "message": error.message,
               "lines": [error.line],
               "column": error.column}
              for error in list(xsd_validator.error_log)]
    return errors
