require 'formula'

class Finalterm < Formula
  homepage 'http://finalterm.org/'
  head 'https://github.com/keithlayne/finalterm.git'

  depends_on 'autoconf' => :build
  depends_on 'automake' => :build
  depends_on 'cmake' => :build
  depends_on 'vala' => :build
  depends_on 'libgee'
  depends_on 'gtk+3'
  depends_on 'clutter'
  depends_on 'clutter-gtk'
  depends_on 'mx'
  depends_on 'keybinder-3.0'

  def install
    mkdir 'build' do
      system "cmake", "..", *std_cmake_args
      system "make", "install" # if this fails, try separate make/make install steps
    end
  end

  test do
    system "false"
  end
end
