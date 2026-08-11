# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Status

This repository is currently empty — no source code, build configuration, or documentation exists yet.

When the project is scaffolded, update this file with:
- Build, lint, and test commands (including how to run a single test)
- High-level architecture notes covering how major components fit together

## Git workflow

- This repo must be under git version control once code exists (`git init` if not already set up), with a GitHub remote configured for backup.
- Commit regularly as work progresses — after each meaningful, working change — rather than batching large amounts of uncommitted work. Don't let significant work sit uncommitted.
- Write clean, descriptive commit messages: a concise summary line (under ~70 chars) explaining the *why*, with a body if more context is useful. Follow whatever message style is already established in the repo's git log.
- Push to the GitHub remote regularly so work is backed up remotely, not just committed locally.
- Never force-push, amend published commits, or run destructive git operations (reset --hard, etc.) without explicit confirmation first.
- Before committing, review staged changes (`git status` / `git diff`) to avoid committing secrets, credentials, or unintended files.
