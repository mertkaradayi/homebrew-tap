class Pando < Formula
  desc "One repo. Every branch alive."
  homepage "https://mertkaradayi.github.io/pando/"
  version "0.10.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mertkaradayi/pando/releases/download/v0.10.0/pando-cli-aarch64-apple-darwin.tar.xz"
      sha256 "653531e6681a23e784c5c4f676879e7eb783ac562ecae5b82b8201d8197d4d4f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mertkaradayi/pando/releases/download/v0.10.0/pando-cli-x86_64-apple-darwin.tar.xz"
      sha256 "f86c4c0959e53100f36f131d653874d1b9390901e1ae76d716da08eecb570aa3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mertkaradayi/pando/releases/download/v0.10.0/pando-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "34a0eac4439418f5b56df483720bbc80c5333b2174c7603bd630c9d24a208be3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mertkaradayi/pando/releases/download/v0.10.0/pando-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "8ce0f529b83a67b1f773a4eed53ff620cd409b7ee8aa6bd0b51646d59412c3cc"
    end
  end
  license "AGPL-3.0-only"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "pando"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "pando"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "pando"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "pando"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
