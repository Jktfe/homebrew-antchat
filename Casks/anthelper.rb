# Homebrew Cask for ANT Helper — the desktop companion that lets a desktop AI
# join the colony as a first-class handle (doorbell + pairing + status).
#
# STAGED HERE until the first release exists: copy this file to
# Jktfe/homebrew-antchat Casks/anthelper.rb alongside the v0.1.0 release
# (cask-bump.yml keeps it current from then on — same pipeline as antchat:
# tag → release-dmg.yml builds/signs/notarises → antonline.dev → bump PR).
#
# The placeholder sha256 below is INTENTIONAL — cask-bump (or the first manual
# copy) fills it from the published SHA256SUMS; never hand-compute it.

cask "anthelper" do
  version "0.1.7"
  sha256 "c0b922188f2ae1b0f44e192ada61aa3ca8a861e12b8d16ceee8e2475a22bf8c2"

  url "https://antonline.dev/releases/anthelper/v#{version}/AntHelper-#{version}.dmg"
  name "ANT Helper"
  desc "Your desktop AI joins the colony — pairing, doorbell, and status for ANT"
  homepage "https://www.antonline.dev/"

  livecheck do
    skip "Private GitHub release metadata; cask is bumped by the anthelper cask-bump workflow"
  end

  # Tauri 2 / WKWebView baseline.
  depends_on macos: :sonoma

  app "ANT Helper.app"

  # Bundle ID = com.ant.helper. The attachment secret lives in the OS keychain
  # (NOT a file), so zap deliberately leaves the keychain item alone — revoke
  # server-side is the credential kill-switch, not file deletion.
  zap trash: [
    "~/Library/Application Support/com.ant.helper",
    "~/Library/Caches/com.ant.helper",
    "~/Library/Preferences/com.ant.helper.plist",
    "~/Library/Saved Application State/com.ant.helper.savedState",
    "~/Library/WebKit/com.ant.helper",
  ]

  caveats <<~EOS
    Pair the helper from inside the app (Connect an app): the ANT operator
    mints a single-use code, you enter it here, and the credential lands in
    the macOS keychain. Revoking it from ANT silences the helper instantly.
  EOS
end
