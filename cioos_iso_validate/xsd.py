
from typing import List
from lxml import etree
import os

'''
XSD validation is the second stage of validation. It can return multiple
errors.

It checks the XML document against the schema starting at XSD_PATH

It uses the catalog.xsd to translate URLs to folder directories, so it doesn't
need to do any HTTP requests

'''


folder_path = os.path.dirname(os.path.realpath(__file__))
XSD_PATH = folder_path+'/schema/standards.iso.org/iso/19115/-3/mds/2.0/mds.xsd'

catalog_path = folder_path + "/catalog.xsd"

if not os.path.isfile(catalog_path):
    raise Exception("Cant find catalog file at " + catalog_path)

os.environ['XML_CATALOG_FILES'] = catalog_path


def XSDValidate(xml_to_validate: str) -> List[dict]:
    'Gets list of validation errors for this document'
    xmlschema = etree.parse(XSD_PATH)
    xsd_validator = etree.XMLSchema(xmlschema)

    xml_tree = etree.fromstring(xml_to_validate)

    try:
        xsd_validator.assertValid(xml_tree)
    except etree.DocumentInvalid as xml_errors:
        errors = [{"type": 'xsd',
                   "message": error.message,
                   "lines": [
                       error.line],
                   "column": error.column}
                  for error in xml_errors.error_log]
        return errors
