class Pando < Formula
  desc "One repo. Every branch alive."
  homepage "https://mertkaradayi.github.io/pando/"
  version "0.11.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mertkaradayi/pando/releases/download/v0.11.2/pando-cli-aarch64-apple-darwin.tar.xz"
      sha256 "f790645a80a294a1814d80f0ccbe29eed4fd6347ab4adcf800bf17c01ca0a88b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mertkaradayi/pando/releases/download/v0.11.2/pando-cli-x86_64-apple-darwin.tar.xz"
      sha256 "35bfb618ff4daef88659c8beb64ee18340f7c9bb2d1aebae7dbcf8557882bfba"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mertkaradayi/pando/releases/download/v0.11.2/pando-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "e5b2c9a4bfeb99f5b1f9d89226d3a7e5d7d0043a9b7b17ad63513849dc17619a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mertkaradayi/pando/releases/download/v0.11.2/pando-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "4398c21837ddcfe087f1426391fbd905262b845af323c9817bd1f6cd010cca7d"
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
