#!/bin/bash

set -e

echo -e "Creating a tag for the current branch...\n"

# Check if there is a tag on the current branch
current_branch=$(git rev-parse --abbrev-ref HEAD)
tag=$(git describe --tags --exact-match 2>/dev/null || echo "")

DATE=$(date -u +%Y%m%d)
BASE_TAG="v${DATE}"

# Properly check if a tag exists
if [ -n "$tag" ]; then
    echo "There is a tag ($tag) on the current branch ($current_branch)."
    echo "New tag creation is not needed"
else
    echo "There is no tag on the current branch ($current_branch)."
    COUNT=$(git tag | grep -E "^${BASE_TAG}" | wc -l)
    NEXT_NUM=$((COUNT + 1))
    TAG="${BASE_TAG}.${NEXT_NUM}-Community"
        
    git config --global user.email "bitbucket-pipeline@example.com"
    git config --global user.name "Bitbucket Pipeline"
    
    echo ${TAG}
    git tag ${TAG};
    git push origin ${TAG};
fi