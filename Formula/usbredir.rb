class Usbredir < Formula
  desc "USB traffic redirection library"
  homepage "https://www.spice-space.org"
  url "https://www.spice-space.org/download/usbredir/usbredir-0.8.0.tar.bz2"
  sha256 "87bc9c5a81c982517a1bec70dc8d22e15ae197847643d58f20c0ced3c38c5e00"
  license "GPL-2.0"

  livecheck do
    url "https://www.spice-space.org/download/usbredir/"
    regex(/href=.*?usbredir[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "71845b18ae16c2ebe1a321d8e7bc8916f5fb99917f08d34927c14118ac8e9d12"
    sha256 cellar: :any, big_sur:       "8f86636870cc889d4a8ef202fdf4d65681e930961e19de50438deb49d1d2065d"
    sha256 cellar: :any, catalina:      "c7182aed390cc4cf96e9a99a728129367714b954062b7f92471a6e3864aed244"
    sha256 cellar: :any, mojave:        "579f1db366d50c027cfd6ea92149878b358d86bb6a9d491320e5f7fd62dfd2e8"
    sha256 cellar: :any, high_sierra:   "0d83ca33451b2c382dcf4b70be515549db139b0960712dc7f213e993ba7973d7"
    sha256 cellar: :any, sierra:        "7feac9566048e308877ef3f3d1b93660433dc8f1611e3daf031eaa4dd90c7238"
    sha256 cellar: :any, x86_64_linux:  "15e3f79c40cd5ed9c0e9443d6a77badacc4f298db4ba1e5205fc8a1d5c9b924a"
  end

  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "libusb"

  # Upstream patch, remove for next release
  # https://gitlab.freedesktop.org/spice/usbredir/issues/9
  patch do
    url "https://gitlab.freedesktop.org/spice/usbredir/commit/985e79d5f98d5586d87204317462549332c1dd46.diff"
    sha256 "21c0da8f6be94764e1e3363f5ed76ed070b5087034420cb17a81da06e4b73f83"
  end

  def install
    system "./configure", "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <usbredirparser.h>
      int main() {
        return usbredirparser_create() ? 0 : 1;
      }
    EOS
    system ENV.cc, "test.cpp",
                   "-L#{lib}",
                   "-lusbredirparser",
                   "-o", "test"
    system "./test"
  end
end
