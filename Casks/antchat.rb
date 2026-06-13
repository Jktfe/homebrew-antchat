# Homebrew Cask for the Antchat Mac app — fresh native SwiftUI build
# from Jktfe/antchat (private SwiftUI source — DMG served via the public
# Jktfe/antchat-releases release channel, source private, license-bundle
# gating enforced in-app at runtime).
#
# Installs both the native app and the fresh `ant` CLI. The `antchat` Formula
# is only a compatibility command so `antchat --version` matches the app
# version and forwards terminal workflows to `ant`.
#
# Release pipeline (Jktfe/antchat .github/workflows/release-dmg.yml):
#   1. Tag `v<version>` on Jktfe/antchat.
#   2. release-dmg.yml builds, signs, notarises, staples the DMG, then
#      uploads the notarized DMG to Jktfe/antchat-releases.
#   3. cask-bump.yml opens a PR against this tap bumping version + url
#      + sha256 (computed by re-downloading the published artefact).
#   4. User: `brew upgrade --cask antchat` → Gatekeeper accepts (notarised).
#
# Bundle ID changed from antios (`vc.newmodel.ant.chat`) to the fresh
# Jktfe/antchat target (`vc.newmodel.antchat`) — different product, distinct
# Preferences/Caches paths in the zap block below.

cask "antchat" do
  version "4.1.3"
  sha256 "88b88299bdc13627e9e3427810fab4cee4b056efee8cad9fb3c8c035f8378b7f"

  # DMG lives in the public binary-only release channel because the embedded
  # server pushes it past GitHub's 100MB blob limit for git-tracked assets.
  url "https://github.com/Jktfe/antchat-releases/releases/download/v#{version}/Antchat-#{version}.dmg",
      verified: "github.com/Jktfe/antchat-releases/"
  name "Antchat"
  desc "Native desktop client for ANT rooms and agents"
  homepage "https://www.antonline.dev/"

  livecheck do
    skip "Private GitHub release metadata; cask is bumped by release workflow/manual checksum verification"
  end

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
