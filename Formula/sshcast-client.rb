class SshcastClient < Formula
  desc "Roaming SSH Agent workstation client and native macOS menu bar tray"
  homepage "https://sshcast.net"
  license any_of: ["MIT", "Apache-2.0"]
  version "0.1.4"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/sshcast/sshcast-client/releases/download/v#{version}/sshcast-client-macos-arm64.tar.gz"
      sha256 "2e7cfd0c37fa9d767641f7442886f62d29cc42e25ce10d6a6b5ca6dcb492ed1a" # auto-updated by CI on release
    end

    on_intel do
      url "https://github.com/sshcast/sshcast-client/releases/download/v#{version}/sshcast-client-macos-x86_64.tar.gz"
      sha256 "8810d00471bf71b3be2611354b5ce77b7d5039816897fe69e93420cba5f5f065" # auto-updated by CI on release
    end
  end

  def install
    bin.install "sshcast-client"
    bin.install "sshcast-tray"
    doc.install "README.md"
  end

  service do
    run [opt_bin/"sshcast-tray"]
    keep_alive true
    process_type :interactive
    log_path var/"log/sshcast-client.log"
    error_log_path var/"log/sshcast-client.err.log"
  end

  def caveats
    <<~EOS
      To authenticate with Sshcast and enroll this workstation:
        sshcast-client login

      To start the native macOS menu bar tray and run it at login:
        brew services start sshcast-client

      sshcast-client and sshcast-tray integrate with your local SSH agent
      (system ssh-agent, 1Password, Secretive, etc.) via $SSH_AUTH_SOCK.
      If you use 1Password or Secretive, ensure $SSH_AUTH_SOCK is exported
      to launchd (e.g., via `launchctl setenv SSH_AUTH_SOCK ...`) or configured
      in ~/.config/sshcast/client.toml.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sshcast-client --version")
  end
end
