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


SHEET_COMMANDS = [
    Command(['metadata', 'language_info'], Delete()),
]

CELL_COMMANDS = [
    Command(['execution_count'], Assign(None)),
    Command(['metadata'], Assign({})),
    Command(['outputs'], Assign([])),
]


def run():
    content = sys.stdin.read()
    version = json.loads(content)['nbformat']
    content = reads(content, version)
    for command in SHEET_COMMANDS:
        command(content)
    for cell in content.cells:
        for command in CELL_COMMANDS:
            command(cell)
    write(content, sys.stdout, version)


if __name__ == '__main__':
    run()
