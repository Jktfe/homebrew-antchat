class Antcli < Formula
  desc "ossANT headless CLI for Desks, rooms, plans, and agent routing"
  homepage "https://github.com/Jktfe/antOSS"
  url "https://github.com/Jktfe/antchat-releases/releases/download/antcli-v0.1.1/antcli-0.1.1-darwin-universal.tar.gz"
  sha256 "7737add88b21b1359049fc6ecbfd67e196e03ecf7b18feca13b86fad7190321c"
  version "0.1.1"

  # No license field: ossANT ships proprietary / all-rights-reserved by default (James's ruling
  # 2026-07-17). The Apache-2.0 flip is a later, deliberate open-core act — do NOT add an open licence
  # here. Omitting the field denotes all-rights-reserved; brew install does not require it.

  # Universal (x86_64 + arm64) self-contained binary — bun-compiled, embeds its runtime, so no node or
  # bun is needed on the host (matches the sibling `ant`). Installs ALONGSIDE `ant`, never replacing it.
  depends_on :macos

  def install
    bin.install "antcli"
  end

  def caveats
    <<~EOS
      antcli ships with NO credentials. Point it at your own org server:
        antcli login --server https://your-org.example --email you@example.com

      This installs alongside `ant` and does not replace it.
      If you have a dev checkout, ~/.local/bin may shadow this binary — check: which -a antcli
    EOS
  end

  test do
    assert_equal "0.1.1", shell_output("#{bin}/antcli --version").strip
  end
end
