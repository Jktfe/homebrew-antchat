# homebrew-antchat

Homebrew tap for **antchat** — the ANT chat client family. Two install paths:

| What you get | Command | Path |
| --- | --- | --- |
| **CLI binary** (single-binary chat client, no Bun/Node host required) | `brew install antchat` | `/opt/homebrew/bin/antchat` |
| **macOS app** (native SwiftUI app — chat UI on your Mac) | `brew install --cask antchat` | `/Applications/Antchat.app` |

Both share the brand. Formulas and Casks are distinct Homebrew namespaces — they co-exist without collision.

## Install

```sh
# Tap once
brew tap jktfe/antchat

# Pick whichever you want (or both)
brew install antchat           # CLI
brew install --cask antchat    # Mac app
```

Direct, without tapping first:

```sh
brew install jktfe/antchat/antchat              # CLI
brew install --cask jktfe/antchat/antchat       # Mac app
```

## First-cut Mac app — signed release

The first native Mac app drop is a **Developer ID signed, notarised, stapled DMG** published from `Jktfe/antchat` GitHub Releases. Homebrew downloads the same DMG that can be emailed directly to colleagues.

```sh
brew install --cask jktfe/antchat/antchat
```

The app identity is `Ant Chat` / `vc.newmodel.antchat`; this is the fresh SwiftUI native app, not the older antios Catalyst dogfood bridge.

## Verify

```sh
# CLI
antchat --version
antchat --help

# Mac app — confirm cask is registered
brew list --cask antchat
ls -l /Applications/Antchat.app
```

## Update

```sh
brew update
brew upgrade antchat                # CLI
brew upgrade --cask antchat         # Mac app
```

## Uninstall

```sh
brew uninstall antchat              # CLI (binary only)
brew uninstall --cask antchat       # Mac app — also runs the `zap` block to clear:
                                    #   ~/Library/Application Support/Antchat
                                    #   ~/Library/Caches/vc.newmodel.ant.chat
                                    #   ~/Library/Preferences/vc.newmodel.ant.chat.plist
                                    #   ~/Library/Saved Application State/vc.newmodel.ant.chat.savedState

# Untap if you want to clean up:
brew untap jktfe/antchat
```

## Configuration

The CLI reads `~/.ant/config.json` for its server URL + api key. See `antchat --help` for the full subcommand surface (`join`, `rooms`, `msg`, `chat`, `tasks`, `plan`, `doc`, `deck`, `sheet`, `mcp`, `watch`, `web`).

The Mac app reuses the same `~/.ant/config.json` when present and falls back to in-app server-url + sign-in if absent.

## Troubleshooting

| Symptom | Cause | Fix |
| --- | --- | --- |
| `brew install --cask antchat` fails with `sha256 mismatch` | The GitHub Release DMG changed but the cask was not bumped | Update `Casks/antchat.rb` with the current release sha256. |
| `Apple could not verify "Antchat" is free of malware` | The DMG was not notarised or the local install is an old dogfood build | Reinstall from the GitHub Release-backed cask; the v0.1.2 DMG is notarised + stapled. |
| App opens then immediately quits | Probably missing server/login state | Sign in with the dev-team email, password, and `NEW-MODEL-ANT-DEV-<email>` licence code. |
| Cask install can't find `Antchat.app` | The .app product name in the cask might not match what xcodebuild produced | Check `app 'Antchat.app'` line in `Casks/antchat.rb` matches the actual bundle name produced by the build pipeline. |

## Release pipeline (maintainer reference)

CLI: `Jktfe/a-nice-terminal/.github/workflows/release-antchat.yml` emits `antchat-v<version>` tags with two binary tarballs + SHA256SUMS. The Formula here is bumped on each release.

Mac app: `Jktfe/antchat/.github/workflows/release-dmg.yml` emits a signed, notarised, stapled DMG on `v*.*.*` tags and attaches it to the matching GitHub Release. The cask points at:

```sh
https://github.com/Jktfe/antchat/releases/download/v#{version}/Antchat-#{version}.dmg
```

## Repo

- Tap repo: <https://github.com/Jktfe/homebrew-antchat>
- antchat CLI source: <https://github.com/Jktfe/a-nice-terminal>
- Mac app source: <https://github.com/Jktfe/antchat>

## License

MIT for the tap files. CLI + Mac app licenses live in their respective source repos.
