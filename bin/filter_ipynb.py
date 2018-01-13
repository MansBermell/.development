#!/usr/bin/env python

# The code is based on:
# https://github.com/toobaz/ipynb_output_filter

import sys
import json

from nbformat import reads, write


class Assign:
    def __init__(self, value):
        self.value = value

    def __call__(self, object, key):
        object[key] = self.value

class Delete:
    def __call__(self, object, key):
        del object[key]

class Command:
    def __init__(self, path, action):
        self.path = path
        self.action = action

    def __call__(self, object):
        path = self.path
        while True:
            if not path[0] in object: return
            if len(path) == 1: break
            object, path = object[path[0]], path[1:]
        self.action(object, path[0])

sheet_commands = [
    Command(['metadata', 'language_info', 'version'], Delete()),
]

cell_commands = [
    Command(['execution_count'], Assign(None)),
    Command(['outputs'], Assign([])),
]

def clean(sheet):
    for command in sheet_commands: command(sheet)
    for cell in sheet.cells:
        for command in cell_commands: command(cell)

content = sys.stdin.read()
version = json.loads(content)['nbformat']
content = reads(content, version)
clean(content)

write(content, sys.stdout, version)
