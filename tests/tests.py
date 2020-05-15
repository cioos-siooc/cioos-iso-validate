#!/usr/bin/env python3

import unittest
import lxml
from cioos_iso_validate.validate import (validate)

basic_valid_schema = """<?xml version="1.0" encoding="UTF-8"?>
                <MD_Metadata xmlns="http://standards.iso.org/iso/19115/-3/mdb/2.0">
                    <contact></contact>
                    <dateInfo></dateInfo>
                    <identificationInfo></identificationInfo>
                </MD_Metadata>
                """


class TestValidationFunctions(unittest.TestCase):

    def test_invalid_xml(self):
        bad_xml = "<xml></yml>"
        log = validate(bad_xml)
        self.assertEqual(log[0]['type'], 'xml')

    def test_valid_xml(self):
        good_xml = "<xml></xml>"
        log = validate(good_xml, level='xml')
        self.assertFalse(log)

    def test_valid_xsd(self):
        log = validate(basic_valid_schema, level='schema')
        self.assertFalse(log)

    def test_invalid_schema(self):
        bad_xml = "<xml></xml>"
        log = validate(bad_xml)
        self.assertEqual(log[0]['type'], 'xsd')

    def test_invalid_cioos(self):
        log = validate(basic_valid_schema)
        self.assertEqual(log[0]['type'], 'schematron')


if __name__ == '__main__':
    unittest.main()
