class Ant < Formula
  desc "Fresh ANT CLI for rooms, accounts, handles, and agent routing"
  homepage "https://github.com/Jktfe/a-nice-terminal"
  version "0.1.4"
  license "AGPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/Jktfe/a-nice-terminal/releases/download/ant-v#{version}/ant-#{version}-darwin-arm64.tar.gz"
      sha256 "aa90c4b26ca53035d141f9403e9e76f46a7327bf5595a98ba4db9411a9d54d85"
    end

    on_intel do
      url "https://github.com/Jktfe/a-nice-terminal/releases/download/ant-v#{version}/ant-#{version}-darwin-x64.tar.gz"
      sha256 "fd25b024e668f9d30ffa8500e372daa38205a10734923e33a5303d62f167b715"
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
