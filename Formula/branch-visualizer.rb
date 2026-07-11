class BranchVisualizer < Formula
  desc "macOS menu bar app for git branches, worktrees, and commit graphs"
  homepage "https://github.com/wannabeepolymath/git-branch-Visualizer"
  url "https://github.com/wannabeepolymath/git-branch-Visualizer/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "3790424c7b0e1c0893fa9479289d011400c46b5d202633424c9dffb83f76605d"
  license "MIT"

  depends_on "bun" => :build
  depends_on "rust" => :build
  depends_on :macos

  def install
    system "bun", "install", "--frozen-lockfile"
    system "bun", "run", "tauri", "build", "--bundles", "app"
    prefix.install "src-tauri/target/release/bundle/macos/Branch Visualizer.app"
  end

  def caveats
    <<~EOS
      Branch Visualizer is a menu bar app. To make it visible to Spotlight
      and Login Items, link it into /Applications:

        ln -sf "#{opt_prefix}/Branch Visualizer.app" /Applications

      Or launch it directly:

        open "#{opt_prefix}/Branch Visualizer.app"
    EOS
  end

  test do
    assert_path_exists prefix/"Branch Visualizer.app"
  end
end
