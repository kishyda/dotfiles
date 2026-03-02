---
name: git-commit-gen
description: Analyzes staged git changes and generates a commit message. Use when the user has staged changes in a git repository and wants a summary or a commit message based on those changes.
---

# Git Commit Gen

## Overview

This skill provides a streamlined workflow for generating professional, structured git commit messages by analyzing staged changes. It uses the "Conventional Commits" specification to ensure consistency and clarity.

## Workflow

To generate a commit message, follow these steps:

1.  **Read Staged Changes**: Use the `scripts/get_staged_changes.sh` script to retrieve the list of staged files and their diff.
2.  **Analyze Context**: Review the diff to understand the nature of the changes (features, fixes, refactors, etc.).
3.  **Consult Style Guide**: Refer to `references/commit_style.md` for the Conventional Commits format and rules.
4.  **Propose Message**: Generate a commit message that accurately reflects the staged changes.
5.  **Confirm with User**: Present the proposed commit message to the user for approval or refinement.

## Resources

### scripts/

- `get_staged_changes.sh`: A shell script that outputs the staged files and their `git diff --cached` output.

### references/

- `commit_style.md`: A guide to the Conventional Commits specification, including types (feat, fix, refactor, etc.) and formatting rules.
