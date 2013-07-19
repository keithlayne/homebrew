require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Keybinder30 < Formula
  homepage ''
  head 'https://github.com/engla/keybinder.git'
  url 'https://github.com/engla/keybinder/archive/keybinder-3.0-v0.3.0.tar.gz'
  sha1 '784e839e726e58511116cf247707d60fe5fa16fe'
  version '0.3.0'

  depends_on 'automake' => :build
  depends_on 'autoconf' => :build
  depends_on 'gtk-doc' => :build
  depends_on 'libtool' => :build
  depends_on 'pkg-config' => :build
  depends_on 'gnome-doc-utils' => :build
  depends_on 'gtk+3'
  depends_on 'gobject-introspection'
  depends_on 'gnome-common'

  def install
    inreplace 'configure.ac', /^(GTK_DOC_CHECK)/, '# \1'
    inreplace 'configure.ac', /^(docs\/)[^\n]*\n/m, ''
    inreplace 'Makefile.am', /^(SUBDIRS.*) docs/, '\1'
    rm_rf 'docs'
    ENV['LIBTOOLIZE'] = 'glibtoolize'
    ENV['AUTOCONF'] = 'autoconf'
    ENV['AUTOMAKE'] = 'automake-1.14'
    ENV['GTKDOCIZE'] = 'gtkdocize'
    #ENV['LIBTOOLIZE'] = '/usr/local/Cellar/libtool/2.4.2/bin/glibtoolize'
    #ENV['AUTOCONF'] = '/usr/local/Cellar/autoconf/2.69/bin/autoconf'
    #ENV['AUTOMAKE'] = '/usr/local/Cellar/automake/1.14/bin/automake'
    #ENV['ACLOCAL'] = '/usr/local/Cellar/automake/1.14/bin/aclocal'
    #ENV['GTKDOCIZE'] = '/usr/local/bin/gtkdocize'
    ENV['ACLOCAL_FLAGS'] = "#{ENV['ACLOCAL_FLAGS']} -I #{HOMEBREW_PREFIX}/share/aclocal"
    #system 'env', 'ACLOCAL=/usr/local/Cellar/automake/1.14/bin/aclocal', 
    system './autogen.sh', '--disable-gtk-doc'
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install" 
  end

  test do
    system "false"
  end
end
