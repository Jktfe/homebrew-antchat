# Homebrew Cask for the Antchat Mac app — Mac Catalyst build of the
# antios SwiftUI antchat surface.
#
# Lives in the same tap as the `antchat` CLI Formula (Formula/antchat.rb).
# Homebrew formulas + casks are distinct namespaces, so:
#   brew install antchat            → installs the CLI binary (Formula)
#   brew install --cask antchat     → installs Antchat.app (this Cask)
#
# Dogfood build, 2026-05-18:
#   - Served over JWPK's tailnet from the Mac mini on port 8787.
#   - Development-signed, not notarised.
#   - Replace this URL with a signed GitHub Release URL once the Actions
#     signing/notarisation workflow lands.

cask "antchat" do
  version "0.1.0"
  sha256 "aac380ace9713e914bebe1a4a87a4844b89f0a1d7bf22ba2a2e38a141ca1e4d4"

  url "http://mac.kingfisher-interval.ts.net:8787/Antchat-#{version}-maccatalyst.zip",
      verified: "mac.kingfisher-interval.ts.net:8787/"
  name "Antchat"
  desc "Native macOS antchat — chat with ANT rooms + agents from your Mac"
  homepage "https://github.com/Jktfe/antios"

  # Mac Catalyst app — first cut targets macOS 14+.
  depends_on macos: ">= :sonoma"

  app "Antchat.app"

  # Uninstall: also clear preferences + caches so brew uninstall is clean.
  zap trash: [
    "~/Library/Application Support/Antchat",
    "~/Library/Caches/vc.newmodel.ant.chat",
    "~/Library/Preferences/vc.newmodel.ant.chat.plist",
    "~/Library/Saved Application State/vc.newmodel.ant.chat.savedState"
  ]
end
