# Cue OS Homebrew tap

Install [Cue CLI](https://cueos.ai), the terminal product for Cue OS:

```sh
brew install cueos/tap/cue-cli
cue onboard
```

The command is `cue`. This formula currently supports Apple Silicon Macs and
includes Node.js 24 as a dependency. It packages the published Cue CLI beta
release with a pinned archive and SHA-256 checksum.

## Updates

```sh
brew update
brew upgrade cueos/tap/cue-cli
```

Use Homebrew for updates. The in-app `/update` command currently checks npm;
the terminal `cue update` command points back to the Homebrew upgrade command.

## Existing installations

Homebrew's separate `cue` formula provides the CUE configuration language and
also installs a command named `cue`. Homebrew reports this conflict during
installation. Use the full `cueos/tap/cue-cli` name to select Cue CLI.

If you already installed Cue CLI another way, `command -v cue` shows which
installation your shell uses. Homebrew installs its command under
`$(brew --prefix)/bin/cue`.

## Release

The Homebrew version tracks the archive date. `cue --version` reports the
upstream CLI version and build information.

Project: https://cueos.ai
