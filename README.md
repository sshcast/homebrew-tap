# Sshcast Homebrew Tap

Official Homebrew tap for [`sshcast-client`](https://github.com/sshcast/sshcast-client), the Roaming SSH Agent workstation CLI and native macOS menu bar tray (`sshcast-tray`).

Supported platforms:
- macOS Apple Silicon (`arm64`)
- macOS Intel (`x86_64`)

## Install

```bash
brew install sshcast/tap/sshcast-client
```

This installs both `sshcast-client` (CLI) and `sshcast-tray` (native macOS menu bar app).

## Login & Enroll

Authenticate with GitHub via the Sshcast Operator to obtain a `UserCert` and enroll this workstation:

```bash
sshcast-client login
```

## Start the Menu Bar Tray Service

Start `sshcast-tray` now and configure it to launch automatically at login:

```bash
brew services start sshcast-client
```

Logs are written to:
- `$(brew --prefix)/var/log/sshcast-client.log`
- `$(brew --prefix)/var/log/sshcast-client.err.log`

To stop or restart the service:

```bash
brew services restart sshcast-client
brew services stop sshcast-client
```

### SSH Agent Integration (`$SSH_AUTH_SOCK`)

`sshcast-client` and `sshcast-tray` connect to your local SSH agent via `$SSH_AUTH_SOCK`, supporting:
- Apple system `ssh-agent`
- **1Password** SSH Agent
- **Secretive**

If you use 1Password or Secretive with `brew services`, ensure `$SSH_AUTH_SOCK` is available to `launchd` GUI services (for example via `launchctl setenv SSH_AUTH_SOCK ...`) or configured explicitly in `~/.config/sshcast/client.toml`.

## Upgrade

```bash
brew update
brew upgrade sshcast/tap/sshcast-client
brew services restart sshcast-client
```

## Uninstall

```bash
brew services stop sshcast-client
brew uninstall sshcast-client
brew untap sshcast/tap
```

## License

Dual-licensed under either of:
- MIT License ([`LICENSE-MIT`](LICENSE-MIT))
- Apache License, Version 2.0 ([`LICENSE-APACHE`](LICENSE-APACHE))
