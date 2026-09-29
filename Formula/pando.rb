class Pando < Formula
  desc "One repo. Every branch alive."
  homepage "https://mertkaradayi.github.io/pando/"
  version "0.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mertkaradayi/pando/releases/download/v0.6.1/pando-cli-aarch64-apple-darwin.tar.xz"
      sha256 "2aa285e427e7f133dabbd663edccca54aebc811de909ceb5f19b1a905c337b04"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mertkaradayi/pando/releases/download/v0.6.1/pando-cli-x86_64-apple-darwin.tar.xz"
      sha256 "3ee571fa2bdca440c5a72ff2e7a6c5ea3bbc1089cab308f566c4b8a1adee9297"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mertkaradayi/pando/releases/download/v0.6.1/pando-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "88e55b7ce1879fe84b8621c333769cb659ba1992f676bddddeb35226af940329"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mertkaradayi/pando/releases/download/v0.6.1/pando-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "07bfcea55a2adfb361a3da59805f733070ed22361f3640b4f2e2c31845cc8152"
    end
  end
  license "AGPL-3.0-only"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

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
