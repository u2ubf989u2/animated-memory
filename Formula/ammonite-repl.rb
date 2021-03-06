class AmmoniteRepl < Formula
  desc "Ammonite is a cleanroom re-implementation of the Scala REPL"
  homepage "https://ammonite.io/"
  url "https://github.com/lihaoyi/Ammonite/releases/download/2.3.8/2.13-2.3.8"
  sha256 "e7af76416202ff02b8faece785740d957e3ca6351f8d56cf69a749ec4d25484b"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, x86_64_linux: "376399e1a06d675716e8ddf899e7160be48e7ce23aedbf0d7529ae8351152b63"
  end

  depends_on "openjdk"

  def install
    (libexec/"bin").install Dir["*"].first => "amm"
    chmod 0755, libexec/"bin/amm"
    (bin/"amm").write_env_script libexec/"bin/amm", Language::Java.overridable_java_home_env
  end

  test do
    output = shell_output("#{bin}/amm -c 'print(\"hello world!\")'")
    assert_equal "hello world!", output.lines.last
  end
end
