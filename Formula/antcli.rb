class Antcli < Formula
  desc "ossANT headless CLI for Desks, rooms, plans, and agent routing"
  homepage "https://github.com/Jktfe/antOSS"
  url "https://github.com/Jktfe/antchat-releases/releases/download/antcli-v0.1.3/antcli-0.1.3-darwin-universal.tar.gz"
  sha256 "56a13b09545572ecd63e069d648fbf1f4de3eae86d02489ea4488a25ac378f9d"
  version "0.1.3"

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
    assert_equal "0.1.2", shell_output("#{bin}/antcli --version").strip
  end
end
