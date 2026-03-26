#!/usr/bin/env python3
"""Parse stow output and print conflicting src:target pairs."""

import sys
import re

def main():
    stow_output = sys.stdin.read()
    pattern = re.compile(
        r"cannot stow (\S+) over existing target (\S+) since neither a link nor a directory"
    )
    conflicts = pattern.findall(stow_output)
    for src, target in conflicts:
        print(f"{src}:{target}")

if __name__ == "__main__":
    main()
