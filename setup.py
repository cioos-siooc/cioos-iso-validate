#!/usr/bin/env python

from setuptools import setup, find_packages

setup(
    name="cioos_iso_validate",
    version="0.1",
    packages=['cioos_iso_validate', ],
    include_package_data=True,

    install_requires=[
        'Click',
        "lxml",
        "bs4"
    ],
)
