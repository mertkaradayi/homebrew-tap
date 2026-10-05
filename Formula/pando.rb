class Pando < Formula
  desc "One repo. Every branch alive."
  homepage "https://mertkaradayi.github.io/pando/"
  version "0.9.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mertkaradayi/pando/releases/download/v0.9.0/pando-cli-aarch64-apple-darwin.tar.xz"
      sha256 "a2012d18e877ac18dd3e5a27041eab6f65d3a2f73cc02cac60977d0ba29b17d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mertkaradayi/pando/releases/download/v0.9.0/pando-cli-x86_64-apple-darwin.tar.xz"
      sha256 "9b21a96fbd6b2a0e87472a73fdab43ff5176d3ca96daa44240df0abbf9ea48c1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mertkaradayi/pando/releases/download/v0.9.0/pando-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "341214e4b3e96d3ee7144f521d8441e04b708dfedc23b421e66a584b960a2f1b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mertkaradayi/pando/releases/download/v0.9.0/pando-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "e2f081ea4884d334696032e8e58329454462cb23c1f204fad8af84c6f5498045"
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
