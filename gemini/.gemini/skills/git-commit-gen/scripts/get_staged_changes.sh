#!/bin/bash
# Script to get staged changes and status for commit message generation

# Check if we are in a git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo "Error: Not a git repository."
  exit 1
fi

# Get the list of staged files
staged_files=$(git diff --cached --name-only)

if [ -z "$staged_files" ]; then
  echo "No staged changes found."
  exit 0
fi

echo "Staged files:"
echo "$staged_files"
echo ""
echo "Diff of staged changes:"
git diff --cached --no-color
