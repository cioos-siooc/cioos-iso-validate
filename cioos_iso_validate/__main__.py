import sys
import click
import json
from cioos_iso_validate.validate import validate

'''

Command line interface

'''


# TODO why is it so complicated to change the useage line "Usage: __main__.py"?
@click.command()
@click.argument('filename')
@click.option('-l', '--level', type=click.Choice(['schema', 'cioos'],
                                                 case_sensitive=False),
              default='cioos'
              )
def main(filename: str, level: str) -> None:
    """cioos_iso_validate - validate CIOOS ISO XML."""
    with open(filename) as f:
        xml_str = f.read()
        validation_log = validate(xml_str, level)

        if validation_log:
            print(json.dumps(validation_log, indent=5))
            sys.exit(1)
        print(f'{filename} is valid.')


if __name__ == '__main__':
    main()
