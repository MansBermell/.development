#!/usr/bin/env python

# The code is based on:
# https://github.com/toobaz/ipynb_output_filter

import sys
import json

from nbformat import reads, write

mapping = {
    'execution_count': None,
    'outputs': [],
}

def clean(sheet):
    for cell in sheet.cells:
        for field in mapping:
            if field in cell:
                cell[field] = mapping[field]

content = sys.stdin.read()
version = json.loads(content)['nbformat']
content = reads(content, version)
clean(content)

write(content, sys.stdout, version)
