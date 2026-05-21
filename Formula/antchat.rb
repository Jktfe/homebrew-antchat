class Antchat < Formula
  desc "Compatibility command for the Antchat Mac app"
  homepage "https://www.antonline.dev/"
  url "https://raw.githubusercontent.com/Jktfe/homebrew-antchat/bb9498e/README.md"
  version "0.1.8"
  sha256 "acf2e285ebf1b095bc0042b9f60cb26ac5c0891cf957ea0c60731aa70fb1573f"
  license "AGPL-3.0-or-later"

  depends_on "jktfe/antchat/ant"

  def install
    (bin/"antchat").write <<~EOS
      #!/bin/sh
      if [ "$1" = "--version" ] || [ "$1" = "-v" ]; then
        echo "antchat #{version}"
        exit 0
      fi

      if [ "$1" = "--help" ] || [ "$1" = "-h" ] || [ "$#" -eq 0 ]; then
        cat <<'HELP'
      antchat is the Antchat Mac app compatibility command.

      App version: #{version}
      Terminal workflows use the fresh ANT CLI:
        ant

      Common commands:
        ant --version
        ant chat --help
      HELP
        exit 0
      fi

      exec ant "$@"
    EOS
  end

  test do
    assert_match "antchat #{version}", shell_output("#{bin}/antchat --version")
    assert_match "Antchat Mac app compatibility command", shell_output("#{bin}/antchat --help")
  end
end
