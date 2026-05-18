# homebrew-antchat

Homebrew tap for **antchat** — the ANT chat client family. Two install paths:

| What you get | Command | Path |
| --- | --- | --- |
| **CLI binary** (single-binary chat client, no Bun/Node host required) | `brew install antchat` | `/opt/homebrew/bin/antchat` |
| **macOS app** (native Catalyst .app — chat UI on your Mac) | `brew install --cask antchat` | `/Applications/Antchat.app` |

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

## First-cut Mac app — dogfood build

The first push-window Mac app drop is a **development-signed Mac Catalyst dogfood build** served over JWPK's tailnet from `mac.kingfisher-interval.ts.net:8787`. It is not notarised yet; macOS Gatekeeper may quarantine it. After install:

```sh
xattr -dr com.apple.quarantine /Applications/Antchat.app
open /Applications/Antchat.app
```

Or right-click → Open the first time (System Settings → Privacy & Security → Open Anyway also works).

Properly signed + notarised builds are on the path via the GitHub Actions signing-secrets task; this is the dogfood-tonight cut.

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
| `brew install --cask antchat` cannot connect to `mac.kingfisher-interval.ts.net:8787` | Dogfood artifact server is not running on the Mac mini or laptop is off tailnet | Ask the native room to restart the `antchat-dogfood-http` tmux session, or wait for the signed GitHub Release cutover. |
| `brew install --cask antchat` fails with `sha256 mismatch` | The dogfood zip changed but the cask was not bumped | Ask the native room to update `Casks/antchat.rb` with the current sha256. |
| `Apple could not verify "Antchat" is free of malware` | Dogfood build is development-signed but not notarised | `xattr -dr com.apple.quarantine /Applications/Antchat.app`, or right-click `Antchat.app` → Open, or System Settings → Privacy & Security → Open Anyway |
| `Antchat.app is damaged and can't be opened` | Gatekeeper quarantine on unsigned first-cut | `xattr -dr com.apple.quarantine /Applications/Antchat.app` |
| Right-click → Open shows no "Open" option | macOS 15+ removed legacy quarantine bypass for some bundle types | `sudo spctl --master-disable` (temporarily), or use the `xattr` command above. |
| App opens then immediately quits | Probably missing config + identity-gate 403 | Sign in via the app's `/login` surface; or pre-populate `~/.ant/config.json` from the CLI: `antchat join <share-string>` |
| Cask install can't find `Antchat.app` | The .app product name in the cask might not match what xcodebuild produced | Check `app 'Antchat.app'` line in `Casks/antchat.rb` matches the actual bundle name produced by the build pipeline. |

## Release pipeline (maintainer reference)

CLI: `Jktfe/a-nice-terminal/.github/workflows/release-antchat.yml` emits `antchat-v<version>` tags with two binary tarballs + SHA256SUMS. The Formula here is bumped on each release.

Mac app: first dogfood pipeline — for the first push-window cut, swift ships the .app by hand:

```sh
# from antios root
xcodegen generate
xcodebuild -project ANT.xcodeproj -scheme Antchat \
  -destination 'generic/platform=macOS,variant=Mac Catalyst' \
  -configuration Release -derivedDataPath build/DerivedData build

# zip + checksum
ditto -c -k --keepParent \
  build/DerivedData/Build/Products/Release-maccatalyst/Antchat.app \
  build/Antchat-0.1.0-maccatalyst.zip
shasum -a 256 build/Antchat-0.1.0-maccatalyst.zip

# serve over tailnet until the signed release workflow lands
tmux new-session -d -s antchat-dogfood-http \
  'cd /Users/jamesking/CascadeProjects/antios/build && python3 -m http.server 8787 --bind 0.0.0.0'

# patch Casks/antchat.rb url + sha256
# commit + push
```

When this happens regularly, the `release-antchat-app.yml` workflow will replace the by-hand step and the cask URL will move from the tailnet dogfood server to a signed GitHub Release asset.

## Repo

- Tap repo: <https://github.com/Jktfe/homebrew-antchat>
- antchat CLI source: <https://github.com/Jktfe/a-nice-terminal>
- Mac app source: <https://github.com/Jktfe/antios> (Mac Catalyst target inside the ANT app)

## License

MIT for the tap files. CLI + Mac app licenses live in their respective source repos.
