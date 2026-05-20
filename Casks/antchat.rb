# Homebrew Cask for the Antchat Mac app — fresh native SwiftUI build
# from Jktfe/antchat (private SwiftUI source — DMG served via antonline.dev).
#
# Lives in the same tap as the `antchat` CLI Formula (Formula/antchat.rb).
# Homebrew formulas + casks are distinct namespaces, so:
#   brew install antchat            → installs the CLI binary (Formula)
#   brew install --cask antchat     → installs Antchat.app (this Cask)
#
# Release pipeline (per ObsidiANT/plans/antchat-dmg-release-pipeline-v0.md
# from @evolveanttauri + audit §F13/F14):
#   1. Tag `v<version>`.
#   2. GitHub Actions workflow `release-dmg.yml` in Jktfe/antchat:
#        xcodebuild archive → exportArchive → create-dmg → codesign →
#        notarytool submit → stapler staple → re-zip → publish release.
#   3. Cask url + sha256 bumped to point at the new release asset.
#   4. User: `brew upgrade --cask antchat` → Gatekeeper accepts (notarised).
#
# Bundle ID changed from antios (`vc.newmodel.ant.chat`) to the fresh
# Jktfe/antchat target (`vc.newmodel.antchat`) — different product, distinct
# Preferences/Caches paths in the zap block below.
#
# Current state: v0.1.4 release DMG signed, notarised, stapled,
# and hosted at https://antonline.dev/downloads/antchat/v0.1.4/Antchat-0.1.4.dmg.

cask "antchat" do
  version "0.1.4"
  sha256 "da941b82aad472701c7724152446b1e7969ac9d0fd38b8056e20502f5fb7247c"

  url "https://antonline.dev/downloads/antchat/v#{version}/Antchat-#{version}.dmg"
  name "Ant Chat"
  desc "Native macOS antchat — chat with ANT rooms + agents from your Mac"
  homepage "https://github.com/Jktfe/antchat"

  # Fresh SwiftUI native build targets macOS 14+ (Sonoma).
  depends_on macos: ">= :sonoma"
  depends_on formula: "jktfe/antchat/antchat"

  app "Antchat.app"

  # Uninstall: also clear preferences + caches so brew uninstall is clean.
  # Bundle ID = vc.newmodel.antchat (NOT vc.newmodel.ant.chat which was the
  # antios Catalyst dev artefact's id — distinct paths).
  zap trash: [
    "~/Library/Application Support/Antchat",
    "~/Library/Caches/vc.newmodel.antchat",
    "~/Library/Preferences/vc.newmodel.antchat.plist",
    "~/Library/Saved Application State/vc.newmodel.antchat.savedState"
  ]
end
