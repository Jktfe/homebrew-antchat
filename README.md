# homebrew-antchat

Homebrew tap for **ANT / Antchat**. The current app cask installs the native
Mac app plus the fresh `ant` CLI used by agents.

| What you get | Command | Path |
| --- | --- | --- |
| **macOS app + fresh CLI** (native SwiftUI app + `ant` for terminal/agent workflows) | `brew install --cask antchat` | `/Applications/Antchat.app` + `/opt/homebrew/bin/ant` |
| **Legacy CLI binary** (old standalone `antchat` command) | `brew install antchat` | `/opt/homebrew/bin/antchat` |

The legacy `antchat` formula remains for old installs, but new Mac app and
agent workflows should use `ant`.

## Install

```sh
# Tap once
brew tap jktfe/antchat

# Current path
brew install --cask antchat    # Mac app + fresh `ant` CLI

# Legacy only, not needed for the app
brew install antchat           # old `antchat` CLI
```

Direct, without tapping first:

```sh
brew install --cask jktfe/antchat/antchat       # Mac app + fresh `ant` CLI
```

After installing the Mac app, the CLI is available too:

```sh
ant --help
ant --version
```

CLI documentation is available in the running ANT server:

```sh
open http://localhost:6174/discover
open http://localhost:6174/vocab
open http://localhost:6174/visuals
```

## First-cut Mac app — signed release

The first native Mac app drop is a **Developer ID signed, notarised, stapled DMG** built from the private `Jktfe/antchat` repo and hosted on `antonline.dev`. Homebrew downloads that DMG, so the install UX stays simple without publishing premium app binaries from the private source repo.

```sh
brew install --cask jktfe/antchat/antchat
```

The app identity is `Ant Chat` / `vc.newmodel.antchat`; this is the fresh SwiftUI native app, not the older antios Catalyst dogfood bridge.

## Verify

```sh
# Fresh CLI installed by the cask
ant --version
ant --help

# Mac app — confirm cask is registered
brew list --cask antchat
ls -l /Applications/Antchat.app
```

## Update

```sh
brew update
brew upgrade --cask antchat         # Mac app + fresh `ant` CLI
brew upgrade antchat                # Legacy CLI only, if installed
```

## Uninstall

```sh
brew uninstall --cask antchat       # Mac app + fresh `ant` CLI, also runs the `zap` block to clear:
                                    #   ~/Library/Application Support/Antchat
                                    #   ~/Library/Caches/vc.newmodel.antchat
                                    #   ~/Library/Preferences/vc.newmodel.antchat.plist
                                    #   ~/Library/Saved Application State/vc.newmodel.antchat.savedState
brew uninstall antchat              # Legacy CLI only, if installed

# Untap if you want to clean up:
brew untap jktfe/antchat
```

## Configuration

The fresh CLI is installed as `ant`. See `ant --help` for the current
subcommand surface.

The Mac app reuses the same `~/.ant/config.json` when present and falls back to in-app server-url + sign-in if absent.

## Troubleshooting

| Symptom | Cause | Fix |
| --- | --- | --- |
| `brew install --cask antchat` fails with `sha256 mismatch` | The `antonline.dev` DMG changed but the cask was not bumped | Update `Casks/antchat.rb` with the current release sha256. |
| `Apple could not verify "Antchat" is free of malware` | The DMG was not notarised or the local install is an old dogfood build | Reinstall from the `antonline.dev` cask; the v0.1.6 DMG is notarised + stapled. |
| App opens then immediately quits | Probably missing server/login state | Sign in with the dev-team email, password, and `NEW-MODEL-ANT-DEV-<email>` licence code. |
| Cask install can't find `Antchat.app` | The .app product name in the cask might not match what xcodebuild produced | Check `app 'Antchat.app'` line in `Casks/antchat.rb` matches the actual bundle name produced by the build pipeline. |

## Release pipeline (maintainer reference)

CLI: `Jktfe/a-nice-terminal/.github/workflows/release-antchat.yml` emits `antchat-v<version>` tags with two binary tarballs + SHA256SUMS. The Formula here is bumped on each release.

Mac app: `Jktfe/antchat/.github/workflows/release-dmg.yml` emits a signed,
notarised, stapled private DMG artefact. The maintainer copies that artefact to
`Jktfe/antonline-dev` so it is served from `antonline.dev`. The cask points at:

```sh
https://antonline.dev/downloads/antchat/Antchat-#{version}.dmg
```

## Repo

- Tap repo: <https://github.com/Jktfe/homebrew-antchat>
- fresh `ant` CLI source: <https://github.com/Jktfe/a-nice-terminal>
- Mac app source: <https://github.com/Jktfe/antchat>

## License

MIT for the tap files. CLI + Mac app licenses live in their respective source repos.
