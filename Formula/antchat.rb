# Homebrew formula for antchat — the lightweight ANT chat client.
#
# This file lives in the source repo for reference + CI bookkeeping.
# The version that users actually install lives in the tap repo:
#   https://github.com/Jktfe/homebrew-antchat (Formula/antchat.rb)
#
# The release workflow (.github/workflows/release-antchat.yml) emits a
# GitHub Release tagged `antchat-v<version>` with two binary tarballs and
# a SHA256SUMS file. After tagging, the tap formula's `url` and `sha256`
# fields below are bumped to the new release. Until the first real
# release lands, the sha256 entries are placeholders — see PLACEHOLDER.
#
# Install (after tap exists + first release published):
#   brew tap jktfe/antchat
#   brew install antchat
#
# Or directly:
#   brew install jktfe/antchat/antchat
class Antchat < Formula
  desc "Lightweight ANT chat client — single binary, no Bun/Node required on host"
  homepage "https://github.com/Jktfe/a-nice-terminal"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jktfe/a-nice-terminal/releases/download/antchat-v#{version}/antchat-#{version}-darwin-arm64.tar.gz"
      sha256 "19c69591b50b949cf2524346e9f089621d5cb7c5505f3f3c675f887d06b394ea"
    end
    on_intel do
      url "https://github.com/Jktfe/a-nice-terminal/releases/download/antchat-v#{version}/antchat-#{version}-darwin-x64.tar.gz"
      sha256 "da164640f352e660c1891e93362e9049e9ab68b5a7f97ac7c98f4eff45b85578"
    end
  end

  def install
    bin.install "antchat"
  end

  test do
    # Two cheap, network-free assertions: the binary boots, and its
    # self-reported version matches the formula version. If either is
    # wrong the formula is broken before users ever touch it.
    assert_match version.to_s, shell_output("#{bin}/antchat --version")
    assert_match "antchat — lightweight ANT chat client",
                 shell_output("#{bin}/antchat --help")
  end
end
