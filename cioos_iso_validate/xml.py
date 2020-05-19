#!/usr/bin/env python3

'''

This stage just tests for well formed XML.

I incuded this check separate in case we wanted a separate
first stage check of xml validity. Otherwise its redundant
as xsd.py will also do these checks

'''

from typing import List
from lxml import etree


def xml_validate(xml_str: str) -> List[dict]:
    '''Check for well formed XML. Returns empty list of list of errors'''
    try:
        etree.fromstring(xml_str)
        return []
    except etree.XMLSyntaxError as xml_error:
        return [{"type": 'xml',
                 "message": xml_error.msg,
                 "lines": [xml_error.lineno],
                 "column": xml_error.position}]
