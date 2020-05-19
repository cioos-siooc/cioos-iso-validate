#!/usr/bin/env python3

'''

CIOOS XML validation

- Runs the 3 stages of validation:
  - checking for well formed/parseable XML document
  - xsd schema
  - schematron


There can't be multiple error types, will be just one of them

'''

from typing import List
from .xml import XMLValidate
from .xsd import XSDValidate
from .schematron import SchematronValidate


def validate(xml_str: str, level: str = 'cioos') -> List[dict]:
    '''
    Level will be 'xml', 'schema' or 'cioos'
    '''

    levels = ['xml', 'schema', 'cioos']

    if level not in levels:
        raise Exception("Level must be one of: ", levels)

    xml_str = xml_str.encode()

    # Test 1  - try parsing the text as XML
    xml_errors = XMLValidate(xml_str)

    if xml_errors or level == 'xml':
        return xml_errors

    # Test 2 - validate against ISO 19115-3 schema
    xsd_errors = XSDValidate(xml_str)

    if xsd_errors or level == 'schema':
        return xsd_errors

    # Test 3 - validate against CIOOS schematron
    return SchematronValidate(xml_str)
