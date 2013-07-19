require 'formula'

class ClutterGtk < Formula
  homepage 'http://www.clutter-project.org/'
  url 'http://ftp.acc.umu.se/pub/GNOME/sources/clutter-gtk/1.2/clutter-gtk-1.2.2.tar.xz'
  sha1 '595c0f8b583cf085e57e9e8320fec2f5e2effaee'

  depends_on 'pkg-config' => :build
  depends_on 'xz' => :build
  depends_on 'clutter'
  depends_on 'gtk+3'

  def install
    system './configure', '--disable-debug', '--disable-dependency-tracking',
                          "--prefix=#{prefix}"
    system 'make', 'check'
    system 'make', 'install'
  end
end
