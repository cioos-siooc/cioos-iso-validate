# CIOOS ISO XML validation

- [Installation](#installation)
- [Running](#running)
- [Development](#development)
- [Running tests](#tests)

This is a Python3 module and command line tool to validate XML documents that adhere to [CIOOS's ISO profile of ISO 19115-3](https://cioosatlantic.ca/profile/).

This validator has three steps of validation

- Check for well formed XML that is parseable
- Validates ISO 19115-3 using <https://standards.iso.org/iso/19115/-3/mds/2.0/mds.xsd>
- CIOOS validation using custom schematron definition. This section not fully implemented

## Installation

1. Download the schema files. This way they don't have to be included in this repo.

   `sh download_schema_files.sh`

2. If needed, install and activate virtualenv.

   ```bash
   pip install virtualenv --user
   virtualenv -p python3 venv
   source venv/bin/activate
   ```

3. From this directory, run:

   ```bash
   pip install .
   ```

## Running

To test an individual file, run

```bash
python -m cioos_iso_validate sample_records/valid.xml
# or just validate ISO 19115-3 without the CIOOS component:
python -m cioos_iso_validate sample_records/valid.xml --level schema
```

## Development

Install with:

```bash
pip install -e .
```

## Tests

```bash
python -m unittest tests/tests.py
```

or using Docker:

```bash
sh run_docker_tests.sh
```
