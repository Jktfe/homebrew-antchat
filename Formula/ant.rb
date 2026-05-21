class Ant < Formula
  desc "Fresh ANT CLI for rooms, accounts, handles, and agent routing"
  homepage "https://github.com/Jktfe/a-nice-terminal"
  version "0.1.4"
  license "AGPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/Jktfe/a-nice-terminal/releases/download/ant-v#{version}/ant-#{version}-darwin-arm64.tar.gz"
      sha256 "4a1ae771eca33ea977b92353704776491103e8626d6d0469d70bae37ce5044c8"
    end

    on_intel do
      url "https://github.com/Jktfe/a-nice-terminal/releases/download/ant-v#{version}/ant-#{version}-darwin-x64.tar.gz"
      sha256 "7f3a47f4e63729587b92efffc0b3c15589f1e56b3c048f38210f945cbf602737"
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
