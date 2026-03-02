# Commit Message Style Guide: Conventional Commits

Use the following format for all generated commit messages:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

## Types

- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation only changes
- **style**: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **perf**: A code change that improves performance
- **test**: Adding missing tests or correcting existing tests
- **build**: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **ci**: Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- **chore**: Other changes that don't modify src or test files
- **revert**: Reverts a previous commit

## Rules

1.  **Subject line**:
    - Use the imperative, present tense: "change" not "changed" nor "changes"
    - Don't capitalize the first letter
    - No dot (.) at the end
2.  **Body**:
    - Use the imperative, present tense: "change" not "changed" nor "changes"
    - Explain the "what" and "why" of the change, as opposed to the "how"
3.  **Footer**:
    - List any breaking changes and issue references
