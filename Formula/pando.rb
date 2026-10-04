class Pando < Formula
  desc "One repo. Every branch alive."
  homepage "https://mertkaradayi.github.io/pando/"
  version "0.8.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mertkaradayi/pando/releases/download/v0.8.1/pando-cli-aarch64-apple-darwin.tar.xz"
      sha256 "9484d6e72eebc28de906ec23a911a5ddd7f4a5c438955049fe4efff57c4c5d79"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mertkaradayi/pando/releases/download/v0.8.1/pando-cli-x86_64-apple-darwin.tar.xz"
      sha256 "29d11dc99f609900da7726c72b0450f9cef760e6aa2f16f8e58afd471a0d13c4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mertkaradayi/pando/releases/download/v0.8.1/pando-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "6bf0b952298541fcba94f8e6e8c35146a1631b4b476061fee4bef65e227a02b4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mertkaradayi/pando/releases/download/v0.8.1/pando-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "8b50c6e572cceb130e63f9c2c2c1f7f70f5b474bbef0d4598993178e184e81ff"
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
