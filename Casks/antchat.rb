# Homebrew Cask for the Antchat Mac app — fresh native SwiftUI build
# from Jktfe/antchat (private SwiftUI source — DMG served via antonline.dev
# under option B: binary public on antonline.dev, source private, license-
# bundle gating enforced in-app at runtime).
#
# Installs both the native app and the fresh `ant` CLI. The `antchat` Formula
# is only a compatibility command so `antchat --version` matches the app
# version and forwards terminal workflows to `ant`.
#
# Release pipeline (Jktfe/antchat .github/workflows/release-dmg.yml):
#   1. Tag `v<version>` on Jktfe/antchat.
#   2. release-dmg.yml builds, signs, notarises, staples the DMG, then
#      uploads the private Actions artefact to Jktfe/antonline-dev at
#      static/downloads/antchat/Antchat-<version>.dmg.
#   3. cask-bump.yml opens a PR against this tap bumping version + url
#      + sha256 (computed by re-downloading the published artefact).
#   4. User: `brew upgrade --cask antchat` → Gatekeeper accepts (notarised).
#
# Bundle ID changed from antios (`vc.newmodel.ant.chat`) to the fresh
# Jktfe/antchat target (`vc.newmodel.antchat`) — different product, distinct
# Preferences/Caches paths in the zap block below.

cask "antchat" do
  version "0.2.3"
  sha256 "339457cadd210dd8c22336c811f94f3280c44f0d7d47054ed2730cf65870d3bb"

  url "https://antonline.dev/releases/antchat/v#{version}/Antchat-#{version}.dmg"
  name "Antchat"
  desc "Native desktop client for ANT rooms and agents"
  homepage "https://www.antonline.dev/"

  # Fresh SwiftUI native build targets macOS 14+ (Sonoma).
  depends_on macos: :sonoma
  depends_on formula: "jktfe/antchat/ant"

  app "Antchat.app"

  # Uninstall: also clear preferences + caches so brew uninstall is clean.
  # Bundle ID = vc.newmodel.antchat (NOT vc.newmodel.ant.chat which was the
  # antios Catalyst dev artefact's id — distinct paths).
  zap trash: [
    "~/.ant/account",
    "~/.ant/active-workspace.json",
    "~/Library/Application Support/Antchat",
    "~/Library/Caches/vc.newmodel.antchat",
    "~/Library/Preferences/vc.newmodel.antchat.plist",
    "~/Library/Saved Application State/vc.newmodel.antchat.savedState",
  ]

  caveats <<~EOS
    The fresh ANT CLI is installed by the `ant` formula as:
      ant

    The `antchat` command is a compatibility wrapper for the Mac app version.
  EOS
end
