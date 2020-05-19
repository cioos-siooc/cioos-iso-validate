from typing import List
from lxml import etree
'''

This stage just tests for well formed XML

'''


def XMLValidate(xml_str: str) -> List[dict]:
    try:
        etree.fromstring(xml_str)
        return []
    except etree.XMLSyntaxError as xml_errors:
        return [{"type": 'xml',
                 "message": error.message,
                 "lines": [error.line],
                 "column": error.column}
                for error in xml_errors.error_log]
