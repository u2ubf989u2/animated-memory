class Fig2dev < Formula
  desc "Translates figures generated by xfig to other formats"
  homepage "https://mcj.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/mcj/fig2dev-3.2.8a.tar.xz"
  sha256 "6336ac492d0f71dfb7a1dd8f4d78eae17aa57a34f743d4e5ba9814991c2da7ae"
  license "MIT"

  livecheck do
    url :stable
    regex(%r{url=.*?/fig2dev[._-]v?(\d+(?:\.\d+)+[a-z]?)\.t}i)
  end

  bottle do
    sha256 arm64_big_sur: "8a3e1351d4c8b31e2c538250903ad21cf28e39c2ff4a977f664fb7db5636e30c"
    sha256 big_sur:       "7ad02c0ad95d91a65a80357fa8ff68c832b3a974e39914d5a15ec7d55f539893"
    sha256 catalina:      "6399ec140f9170e5a91e36e1186e597761a6c230cec05449be3d27c0d493632a"
    sha256 mojave:        "ded06a69898ae372ecd05d5a5324f99369fc67876318934a1fd278a5dd03e6bf"
    sha256 x86_64_linux:  "6ee2ffb9e8418468a91c00909bae1709c57ee0373a06dd75af5220c0da1a29df"
  end

  depends_on "ghostscript"
  depends_on "libpng"
  depends_on "netpbm"

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-transfig
      --without-xpm
      --without-x
    ]

    system "./configure", *args
    system "make", "install"

    # Install a fig file for testing
    pkgshare.install "fig2dev/tests/data/patterns.fig"
  end

  test do
    system "#{bin}/fig2dev", "-L", "png", "#{pkgshare}/patterns.fig", "patterns.png"
    assert_predicate testpath/"patterns.png", :exist?, "Failed to create PNG"
  end
end
