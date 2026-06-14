class Ant < Formula
  desc "Fresh ANT CLI for rooms, accounts, handles, and agent routing"
  homepage "https://github.com/Jktfe/a-nice-terminal"
  # Universal (arm64+x86_64) tarball on the PUBLIC antchat-releases repo.
  # The per-arch a-nice-terminal ant-v0.1.14 assets were a stale 0.1.14 that
  # predates the `connect` verb (version-stamped but pre-cutover). This
  # universal is freshly built from current main and verified to carry
  # `connect` + witness identity (2026-06-14).
  url "https://github.com/Jktfe/antchat-releases/releases/download/ant-v0.1.14-2/ant-0.1.14-darwin-universal.tar.gz"
  sha256 "2880025b04f78ab044ece2c9378b585c802036023c566ba41df52fc2a4cb931e"
  license "AGPL-3.0-or-later"

  depends_on :macos

  def install
    bin.install "ant"
  end

  test do
    assert_match "ant #{version}", shell_output("#{bin}/ant --version")
    assert_match "fresh-ant CLI", shell_output("#{bin}/ant --help")
  end
end
