class Ant < Formula
  desc "Fresh ANT CLI for rooms, accounts, handles, and agent routing"
  homepage "https://github.com/Jktfe/a-nice-terminal"
  version "0.1.14"
  license "AGPL-3.0-or-later"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/Jktfe/a-nice-terminal/releases/download/ant-v#{version}/ant-#{version}-darwin-arm64.tar.gz"
      sha256 "15913486674919faee0265f02a169880b7545dc8d34792af68d4729f1034e4af"
    end

    on_intel do
      url "https://github.com/Jktfe/a-nice-terminal/releases/download/ant-v#{version}/ant-#{version}-darwin-x64.tar.gz"
      sha256 "31d65ebfb352483b67f06a2eb2a548a1a3a7d0368cf2107e05bcf840af32442a"
    end
  end

  def install
    bin.install "ant"
  end

  test do
    assert_match "ant #{version}", shell_output("#{bin}/ant --version")
    assert_match "fresh-ant CLI", shell_output("#{bin}/ant --help")
  end
end
