#!/bin/bash

set -e

# Check if there is a tag on the current branch
current_branch=$(git rev-parse --abbrev-ref HEAD)
tag=$(git describe --tags --exact-match 2>/dev/null)

if [ $? -eq 0 ]; then
    echo "There is a tag ($tag) on the current branch ($current_branch)."
else
    echo "There is no tag on the current branch ($current_branch)."
fi