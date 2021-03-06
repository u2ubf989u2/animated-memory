class Gitql < Formula
  desc "Git query language"
  homepage "https://github.com/filhodanuvem/gitql"
  url "https://github.com/filhodanuvem/gitql/archive/2.1.0.tar.gz"
  sha256 "bf82ef116220389029ae38bae7147008371e4fc94af747eba6f7dedcd5613010"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e66347dfe8941de456fd25f415291c54ee69e7b335f32098578b0da29c881cf6"
    sha256 cellar: :any_skip_relocation, big_sur:       "cdb95fabef4aa65a6868b9f7967eae64eb2dfea636f66a1c078e54332840324c"
    sha256 cellar: :any_skip_relocation, catalina:      "fbeb1c5d3f24eab8d0cb038fbba6f2900cab2dac9541826f301038f30656b6dd"
    sha256 cellar: :any_skip_relocation, mojave:        "362e70cce840cb4fd4df93de474047957e08bc5e522801d74756840caf3846f9"
    sha256 cellar: :any_skip_relocation, high_sierra:   "d382fa5dd8e22697cb6aea88970c532a2e8c6919d25ed5ed2a0c7ba5fea61eaf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bec7f03813c43fbfc6e1e4c29ff16796305b64c5486ecee1f13a9b8cdda1f34c"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    system "git", "init"
    assert_match "author", shell_output("#{bin}/gitql 'SELECT * FROM commits'")
  end
end
