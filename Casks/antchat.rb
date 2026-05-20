# Homebrew Cask for the Antchat Mac app — fresh native SwiftUI build
# from Jktfe/antchat (private SwiftUI source — DMG served via antonline.dev
# under option B: binary public on antonline.dev, source private, license-
# bundle gating enforced in-app at runtime).
#
# Lives in the same tap as the `antchat` CLI Formula (Formula/antchat.rb).
# Homebrew formulas + casks are distinct namespaces, so:
#   brew install antchat            → installs the CLI binary (Formula)
#   brew install --cask antchat     → installs Antchat.app (this Cask)
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
  version "0.1.5"
  sha256 "f0ba845911b17aaceec06ef508a7923d1b83c2994639186de14c6f46d7b010d6"

  url "https://antonline.dev/downloads/antchat/Antchat-#{version}.dmg"
  name "Antchat"
  desc "Native desktop client for ANT rooms and agents"
  homepage "https://www.antonline.dev/"

  # Fresh SwiftUI native build targets macOS 14+ (Sonoma).
  depends_on macos: :sonoma
  depends_on formula: "jktfe/antchat/antchat"

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
end
