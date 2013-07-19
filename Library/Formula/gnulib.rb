require 'formula'

class Gnulib < Formula
  homepage 'http://www.gnu.org/software/gnulib/'
  head 'git://git.savannah.gnu.org/gnulib.git'

  def install
    prefix.install Dir['*']
    ln_s "#{prefix}/gnulib-tool", "#{HOMEBREW_PREFIX}/bin"
  end

  test do
    system "false"
  end
end
