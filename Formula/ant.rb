class Ant < Formula
  desc "Fresh ANT CLI for rooms, accounts, handles, and agent routing"
  homepage "https://github.com/Jktfe/a-nice-terminal"
  version "0.1.14"
  license "AGPL-3.0-or-later"

  depends_on :macos

  # Universal (arm64+x86_64) tarball on the PUBLIC antchat-releases repo.
  # The per-arch a-nice-terminal ant-v0.1.14 assets were a stale 0.1.14 that
  # predates the `connect` verb (version-stamped but pre-cutover). This
  # universal is freshly built from current main and verified to carry
  # `connect` + witness identity (2026-06-14).
  url "https://github.com/Jktfe/antchat-releases/releases/download/ant-v#{version}/ant-#{version}-darwin-universal.tar.gz"
  sha256 "f859f9dea8ea69c1537587d86a110eb980848142fa6061b0168c04a2efadb8e6"

  def install
    bin.install "ant"
  end

  test do
    assert_match "ant #{version}", shell_output("#{bin}/ant --version")
    assert_match "fresh-ant CLI", shell_output("#{bin}/ant --help")
  end
end
