# Development Contribution Guide
A consistent, shared, code style makes code both easier to read, maintain, and understand. We want to spend our time developing, not arguing about code styles or interpreting code!

## General

Discord is used for general communication 
Questions can be asked in the #questions-about-work channel
Tasks are found and distributed in Trello 
## Dart / Flutter practices
This is a few take-outs from the code style from the recommended official Dart code style linked further down:
- Use trailing commas! This keeps the code nicely structured, and the auto-formatting works great with this out of the box.
- Classes, typedefs, enums, should all be named in `UpperCamelCase`.
- Source files, packages, and directories should all be named in `lowercase_with_underscores`
- Variables, parameters, class members should be named with `lowerCamelCase`
-  Use curly brackets for all flow control systems, such as ifs and loops.
- See https://dart.dev/guides/language/effective-dart/style for full formatting and naming conventions.

Comment things that are harder to understand right away, and leave a top-level comment summarizing the widget.

## Git practices
Some general notes
- We work with feature branches. Each new feature should be developed in new branch, and merged with `main`when done.
- All PRs should be reviewed and accepted by at least one other team member
- Try to edit as few files as possible per commit.
- Refactor and fix code when needed, but keep these changes as a separate commit to keep it clear and separate from direct feature implementation in the branch. See commit structure further down.
### Creating branches
Naming: `category/ref/what-is-being-done`

- Example branch: `feature/map-markers/add-markers-to-flag-positions`
-  Feature branches are named in `kebab-case`
-   `feature` is for adding, refactoring or removing a feature
-   `bugfix` is for fixing a bug
-   `hotfix` is for changing code with a temporary solution and/or without following the usual process (usually because of an emergency)
-   `test` is for experimenting outside of an issue/ticket
- Write `no-ref`if the branch is not directly linked to a Trello card
### Commits
These categories should cover most things. Naming: `category: did something`
- Example commit: `feat: added new button`
-   `feat` is for adding a new feature
-   `fix` is for fixing a bug
-   `refactor` is for changing code for performance or convenience purpose (e.g. readability)
-   `chore` is for everything else (writing documentation, formatting, adding tests, cleaning useless code etc.)
