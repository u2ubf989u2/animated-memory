class Goad < Formula
  desc "AWS Lambda powered, highly distributed, load testing tool built in Go"
  homepage "https://goad.io/"
  url "https://github.com/goadapp/goad.git",
      tag:      "2.0.4",
      revision: "e015a55faa940cde2bc7b38af65709d52235eaca"
  license "MIT"

  bottle do
    rebuild 2
    sha256 cellar: :any_skip_relocation, big_sur:      "0f576b680ef04f935c3af7fd7e1ababdfd8b073659594ad81243018ef3b6cc76"
    sha256 cellar: :any_skip_relocation, catalina:     "89367dad83660f1fc7deae319233bc4b554b92bb0faf406d14ff5145d70226d3"
    sha256 cellar: :any_skip_relocation, mojave:       "9f491e354dc372c864fa2ea747ec3f514071b5fe0ad5f2649818c1e788ce97d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "59cb009dc269b34c5eca144b097102947a09fe0ccae9cb4619993bc8569e8a1c"
  end

  deprecate! date: "2020-11-27", because: :repo_archived

  depends_on "go" => :build
  depends_on "go-bindata" => :build

  uses_from_macos "zip" => :build

  def install
    ENV["GOPATH"] = buildpath
    dir = buildpath/"src/github.com/goadapp/goad"
    dir.install buildpath.children

    cd dir do
      system "make", "build"
      bin.install "build/goad"
      prefix.install_metafiles
    end
  end

  test do
    system "#{bin}/goad", "--version"
  end
end
