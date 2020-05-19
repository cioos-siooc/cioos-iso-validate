#!/usr/bin/env python3

'''
Schematron is the 3rd stage of validation. It can return multiple errors

This is an example of the XML output from the Schematron validation:

<svrl:schematron-output>
  <svrl:fired-rule context="/mdb:MD_Metadata/mdb:metadataStandard"/>
  <svrl:failed-assert test="cit:CI_Citation/cit:title/gco:CharacterString" location="/*[local-name()='MD_Metadata' and namespace-uri()='http://standards.iso.org/iso/19115/-3/mdb/2.0']/*[local-name()='metadataStandard' and namespace-uri()='http://standards.iso.org/iso/19115/-3/mdb/2.0'][1]">
    <svrl:text/>
  </svrl:failed-assert>
</svrl:schematron-output>

'''

import re
from typing import List
import os
from lxml import isoschematron, etree
from bs4 import BeautifulSoup


FOLDER_PATH = os.path.dirname(os.path.realpath(__file__))

SCHEMATRON_PATH = FOLDER_PATH+"/schematron/cioos.sch"


# TODO how can we remove this definition
# TODO how to validate namespaces
NAMESPACES = {'xsi': "http://www.w3.org/2001/XMLSchema-instance",
              'gml': "http://www.opengis.net/gml/3.2",
              'mpc': "http://standards.iso.org/iso/19115/-3/mpc/1.0",
              'mri': "http://standards.iso.org/iso/19115/-3/mri/1.0",
              'mrl': "http://standards.iso.org/iso/19115/-3/mrl/2.0",
              'mmi': "http://standards.iso.org/iso/19115/-3/mmi/1.0",
              'mdb': "http://standards.iso.org/iso/19115/-3/mdb/2.0",
              'mcc': "http://standards.iso.org/iso/19115/-3/mcc/1.0",
              'msr': "http://standards.iso.org/iso/19115/-3/msr/2.0",
              'mac': "http://standards.iso.org/iso/19115/-3/mac/2.0",
              'cit': "http://standards.iso.org/iso/19115/-3/cit/2.0",
              'mrs': "http://standards.iso.org/iso/19115/-3/mrs/1.0",
              'gco': "http://standards.iso.org/iso/19115/-3/gco/1.0",
              'lan': "http://standards.iso.org/iso/19115/-3/lan/1.0",
              'mco': "http://standards.iso.org/iso/19115/-3/mco/1.0",
              'gex': "http://standards.iso.org/iso/19115/-3/gex/1.0",
              'mdq': "http://standards.iso.org/iso/19157/-2/mdq/1.0",
              'mas': "http://standards.iso.org/iso/19115/-3/mas/1.0",
              'mrd': "http://standards.iso.org/iso/19115/-3/mrd/1.0",
              'mrc': "http://standards.iso.org/iso/19115/-3/mrc/2.0",
              'xlink': "http://www.w3.org/1999/xlink"}


# get just the path out of a combination of the rule context and assert text


def get_parent(xpath: str) -> str:
    'turns /a/b/c into /a/b'
    if not xpath:
        return ""
    return '/'.join(xpath.rstrip('/').split('/')[0:-1]) or '/'


def get_last_valid_path(path: str, doc):
    ''' if a/b/c is given returns the first parent path that
        exist in the document
    '''
    # could look for first missing element, but what if attribute missing?
    parts_of_path = path.strip('/').split('/')
    segment = ''
    for path_segment in parts_of_path:
        segment += '/' + path_segment
        if not doc.xpath(segment, namespaces=NAMESPACES):
            return get_parent(segment)


def strip_path(path: str) -> str:
    'tries to convert xpath query to a more basic xml path'
    matches = re.match(r'(.*?)[=<>!]', path)
    if matches:
        out = matches.group(1)
    else:
        out = path

    return out.replace('[', '/')


def schematron_validate(xml_input: str) -> List[dict]:
    'Validate an xml string using schematron'
    # Example adapted from http://lxml.de/validation.html#id2

    # Parse schema
    sct_doc = etree.parse(SCHEMATRON_PATH)
    schematron = isoschematron.Schematron(sct_doc, store_report=True)

    doc = etree.fromstring(xml_input)

    # Validate against schema
    schematron.validate(doc)

    # Validation report
    report = schematron.validation_report

    xml = str(report)
    root = BeautifulSoup(xml, 'xml')
    errors = []
    for failed_assert in root.select('failed-assert'):
        fired_rule_context = failed_assert.find_previous(
            'fired-rule')['context']

        test = failed_assert['test']

        # location = failed_assert['location']
        path = strip_path(fired_rule_context + "/" + test).replace('///', '/')
        path_exists = bool(doc.xpath(path, namespaces=NAMESPACES))

        line_numbers = []
        last_valid_path = ""

        # if error happened in path that exists
        if path_exists:
            results = doc.xpath(path,
                                namespaces=NAMESPACES, smart_strings=True)
            for res in results:
                if hasattr(res, 'sourceline'):
                    line_numbers.append(res.sourceline)
                else:
                    if res.is_attribute:
                        line_numbers.append(res.getparent().sourceline)

        # error: path doesnt exist (missing required field)
        else:
            last_valid_path = get_last_valid_path(path, doc)

            results = doc.xpath(last_valid_path,
                                namespaces=NAMESPACES)

            line_numbers = [x.sourceline for x in results]

        error_message = failed_assert.text.strip() or 'Missing required field'

        # Location isnt very readable, it's not the xpath
        error = {"type": "schematron",
                 "message": error_message,
                 "path": path,
                 "last_valid_path": last_valid_path,
                 "lines": line_numbers,
                 "is_missing_path": not path_exists
                 }

        errors.append(error)
    return errors
