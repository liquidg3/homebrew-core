require "language/node"

class Spruce < Formula
  desc "World Class, Open Source, Test tools for Typescript and Visual Studio Code!"
  homepage "https://cli.spruce.bot"
  url "https://registry.npmjs.org/@sprucelabs/spruce-cli/-/spruce-cli-22.1.3.tgz"
  sha256 "d575942a5e160f2fdae24df10534c1ebb06ede344eb5c4a8d393af3bf1a2af87"
  license "BSD-2-Clause"

  depends_on "node"
  depends_on "yarn"

  on_linux do
    depends_on "libx11"
    depends_on "musl"
  end

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    Dir.chdir(testpath) do
      # Run the spruce command
      system bin/"spruce", "create.module", "testing", "--name", "taco", "--description", "coming-soon"

      # Check if the "testing" directory exists
      assert_predicate testpath/"testing", :directory?, "The 'testing' directory was not created"

      # Check if the "node_modules" directory exists inside "testing"
      assert_predicate testpath/"testing/node_modules", :directory?, "The 'node_modules' not found"
    end
  end
end
