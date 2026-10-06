class CueCli < Formula
  desc "Cue CLI, the terminal product for Cue OS"
  homepage "https://cueos.ai"
  url "https://cueosai.sfo3.digitaloceanspaces.com/cue-cli/beta/2026.9.28.tgz"
  sha256 "36055b9834eb81564e9393962fb865d566528c0de0fa29598eac3b9b0d4058fa"

  depends_on arch: :arm64
  depends_on :macos
  depends_on "node@24"

  conflicts_with "cue", because: "both install a cue executable"

  def install
    libexec.install Dir["*"]
    (bin/"cue").write_env_script libexec/"bin/cue.js", PATH: "#{formula_opt_bin("node@24")}:$PATH"

    # Use Cue's bundled-installer hook to keep self-update from creating an
    # unrelated npm installation outside Homebrew.
    (libexec/"install.sh").write <<~SH
      #!/bin/sh
      printf '%s\n' 'Update this installation with: brew upgrade cueos/tap/cue-cli' >&2
      exit 1
    SH
  end

  def caveats
    <<~EOS
      Start with: cue onboard
      Update with: brew upgrade cueos/tap/cue-cli

      This formula packages the Cue CLI beta release for Apple Silicon Macs.
    EOS
  end

  test do
    ENV["CUE_CONFIG_DIR"] = testpath/"config"
    assert_match "0.0.1", shell_output("#{bin}/cue --version")

    catalog = JSON.parse(shell_output("#{bin}/cue commands --json"))
    commands = catalog.fetch("commands").map { |command| command.fetch("name") }
    %w[run image web weather].each { |command| assert_includes commands, command }

    result = JSON.parse(shell_output("#{bin}/cue run 'Homebrew installation check' --dry-run --force-new --json"))
    assert_equal true, result.fetch("ok")
    assert_equal true, result.fetch("dryRun")
    assert_equal false, result.fetch("modelRequestSent")

    assert_match "brew upgrade cueos/tap/cue-cli", shell_output("#{bin}/cue update 2>&1", 1)
  end
end
