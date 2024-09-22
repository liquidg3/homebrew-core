require "language/node"

class Spruce < Formula
  desc "World Class, Open Source, Test tools for Typescript and Visual Studio Code!"
  homepage "https://cli.spruce.bot"
  url "https://registry.npmjs.org/@sprucelabs/spruce-cli/-/spruce-cli-22.0.1.tgz"
  sha256 "8136e43f031399c3b0d75dc6812ac7c7de6a9ba51e483517b8b35cc6fe3e16cb"
  license "BSD-2-Clause"

  depends_on "node"
  depends_on "yarn"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    Dir.chdir(testpath) do
      # Run the spruce command
      system bin/"spruce", "create.module", "testing", "--name", "taco", "--description", "coming soon"

      # Check if the "testing" directory exists
      assert_predicate testpath/"testing", :directory?, "The 'testing' directory was not created"

      # Check if the "node_modules" directory exists inside "testing"
      assert_predicate testpath/"testing/node_modules", :directory?, "The 'node_modules' not found"
    end
  end
end
