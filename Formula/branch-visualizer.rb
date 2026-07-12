class BranchVisualizer < Formula
  desc "macOS menu bar app for git branches, worktrees, and commit graphs"
  homepage "https://github.com/wannabeepolymath/git-branch-Visualizer"
  url "https://github.com/wannabeepolymath/git-branch-Visualizer/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "6c41f29c1a2c800033a3c7cfcb820fc15bb2a623a203a7a97d87b09c92dfd24f"
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
