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
  version "4.1.1"
  sha256 "1d8c344fa9359f941edb766b764b6e9548cd0a2fe460b9895d966037b40371f0"

  # DMG lives on the PUBLIC Jktfe/antchat-releases repo (GitHub release
  # assets — no 100MB git-file limit, anonymous downloads). The embedded
  # ANT server pushed the DMG past GitHub's in-repo file cap, which broke
  # the old antonline-dev git-publish path (v4.1.1, 2026-06-12). Source
  # repo Jktfe/antchat stays private; artifacts are public.
  url "https://github.com/Jktfe/antchat-releases/releases/download/v#{version}/Antchat-#{version}.dmg"
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
