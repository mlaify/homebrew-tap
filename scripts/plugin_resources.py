#!/usr/bin/env python3
"""Print Homebrew `resource` blocks for AttackMap's official analyzer plugins.

Reads OFFICIAL_PLUGINS from src/attackmap/plugins_lock.py at a given AttackMap
tag (the same pins the `[all]` extra and `-m --install-missing` use), and points
each resource at the GitHub archive tarball of the pinned commit, with its
sha256. No PyPI involved.

Usage: plugin_resources.py v0.4.31 > /tmp/plugins.rb
"""
from __future__ import annotations

import ast
import hashlib
import sys
import urllib.request

ORG = "mlaify"


def fetch(url: str) -> bytes:
    with urllib.request.urlopen(url, timeout=60) as resp:  # noqa: S310 - fixed https URLs
        return resp.read()


def main() -> None:
    tag = sys.argv[1]
    src = fetch(f"https://raw.githubusercontent.com/{ORG}/AttackMap/{tag}/src/attackmap/plugins_lock.py").decode()
    tree = ast.parse(src)
    plugins = next(
        ast.literal_eval(node.value)
        for node in tree.body
        if isinstance(node, (ast.Assign, ast.AnnAssign))
        and getattr(node.targets[0] if isinstance(node, ast.Assign) else node.target, "id", "") == "OFFICIAL_PLUGINS"
    )
    for p in sorted(plugins, key=lambda e: e["package"]):
        url = f"https://github.com/{ORG}/{p['repo']}/archive/{p['git_sha']}.tar.gz"
        sha = hashlib.sha256(fetch(url)).hexdigest()
        print(f'  resource "{p["package"]}" do')
        print(f'    url "{url}"')
        print(f'    version "{p["version"]}"')
        print(f'    sha256 "{sha}"')
        print("  end\n")


if __name__ == "__main__":
    main()
