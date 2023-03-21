#!/bin/bash

set -u

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

for f in .??*; do
    [[ "$f" == "${SCRIPT_DIR}/.git" ]] && continue
    [[ "$f" == "${SCRIPT_DIR}/.github" ]] && continue
    [[ "$f" == "${SCRIPT_DIR}/.DS_Store" ]] && continue

    ln -snfv ${PWD}/"$f" ~
done

