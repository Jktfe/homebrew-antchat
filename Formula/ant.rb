class Ant < Formula
  desc "Fresh ANT CLI for rooms, accounts, handles, and agent routing"
  homepage "https://github.com/Jktfe/a-nice-terminal"
  license "AGPL-3.0-or-later"
  url "https://antonline.dev/releases/ant/v0.1.14/ant-0.1.14-darwin-universal.tar.gz"
  sha256 "367cc1c49663385579047bc1b5bdeedbed9c6fe48a5392fba41606cc2e9e7ea5"

  depends_on :macos

  def install
    bin.install "ant"
  end

  test do
    assert_match "ant #{version}", shell_output("#{bin}/ant --version")
    assert_match "fresh-ant CLI", shell_output("#{bin}/ant --help")
  end
end
