class Openhmd < Formula
  desc "Free and open source API and drivers for immersive technology"
  homepage "http://openhmd.net"
  url "https://github.com/OpenHMD/OpenHMD/archive/0.3.0.tar.gz"
  sha256 "ec5c97ab456046a8aef3cde6d59e474603af398f1d064a66e364fe3c0b26a0fa"
  license "BSL-1.0"
  head "https://github.com/OpenHMD/OpenHMD.git"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "19e9b946bbefe306dc41aa803e5cb48aec3ab62bf334b8975e660f4a3644c0c7"
    sha256 cellar: :any, big_sur:       "875f651a4d9b710ce00e899928b2b9dab6f26cbfee670135566821e524d5337a"
    sha256 cellar: :any, catalina:      "351e8d9e6bfa22b63b035c0f9c0c7e37be52b9e4058c50d7b7ac321eca880e5b"
    sha256 cellar: :any, mojave:        "796c1a6f06715aa8a3304cca0083378d5fe2a1006b55da8727938922b5408c8d"
    sha256 cellar: :any, high_sierra:   "1c54727de5836916bca42065d0ed53f0a796d07ec6866408a69213c94b151092"
    sha256 cellar: :any, sierra:        "97f5dff1e77b6b615544ed6611aa6d8c3395e3c6dc759c4576084d87a4e976ad"
    sha256 cellar: :any, x86_64_linux:  "1c76125523d08577fba3e0f1ed47825b78c7040a5185798feb042833ab95fb84"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "hidapi"

  conflicts_with "cspice", because: "both install `simple` binaries"
  conflicts_with "libftdi0", because: "both install `simple` binaries"

  def install
    system "./autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
    (pkgshare/"tests").install bin/"unittests"
  end

  test do
    system pkgshare/"tests/unittests"
  end
end
