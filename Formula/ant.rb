class Ant < Formula
  desc "Fresh ANT CLI for rooms, accounts, handles, and agent routing"
  homepage "https://github.com/Jktfe/a-nice-terminal"
  license "AGPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://antonline.dev/releases/ant/v#{version}/ant-#{version}-darwin-universal.tar.gz"
      sha256 "367cc1c49663385579047bc1b5bdeedbed9c6fe48a5392fba41606cc2e9e7ea5"
    end

    on_intel do
      url "https://antonline.dev/releases/ant/v#{version}/ant-#{version}-darwin-universal.tar.gz"
      sha256 "367cc1c49663385579047bc1b5bdeedbed9c6fe48a5392fba41606cc2e9e7ea5"
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
