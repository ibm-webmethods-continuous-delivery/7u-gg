# Git Guardian

A single point of management for any number of git repositories.

This repository implements IBM's rules for open-source contributions, helping the contributor to easily start with proper compliance.

In particular, it:

- manages ssh keys
- uses the same ssh keys for interactions with the git server(s) and for the digital commit signature
- offers aliases for common git operations
- provides precommit git hooks, for example to scan with trivy for secrets and vulnerabilities before making a commit
- offers minimalistic git and editing tools (lazygit and neovim)

Make your own repository starting from this template.

## Quick Start

The machine where this framework runs must have docker and docker compose.

1. Prepare two git remote repositories with one of the following options:

    - **Option A**: create two repositories on github.com, starting from the templates in [this repository](https://github.com/ibm-webmethods-continuous-delivery/7u-gg) and the [AI Overwatch](https://github.com/ibm-webmethods-continuous-delivery/7u-aio) one.
    - **Option** B: initialize two empty repositories in any git server of your choice. This server MUST support ssh interactions and signatures for the commits.

2. Clone the git guardian repository on your machine.

    By convention, we clone in `c:\gg` or `/gg`, but you can clone it wherever you want. We will use the convention in the documentation and demos for simplicity and conciseness of the paths.
    The repository to clone is:

    - **Option A**: [this repository](https://github.com/ibm-webmethods-continuous-delivery/7u-gg). You may change the origin or add a separate remote later. It is important to note that the local changes will not be allowed to be pushed on the template.
    - **Option B**: Your own `7u-gg` repository initialized after the above template.

3. Run the git guardian quick start tool

    - Go into the folder `.sbx/gg-quick-start` (e.g. `c:\gg\.sbx\gg-quick-start` or `/gg/.sbx/gg-quick-start`)
    - copy `EXAMPLE.env` to `.env`
    - change the values of the git origin as needed:
      - **Option A**: change both values
      - **Option B**: change only the second value
    - run the command in `run.bat`
    - You should observe now on your box the following images:
      - s-alpine:git-guardian
      - t-alpine:git-guardian
      - u-alpine:git-guardian
