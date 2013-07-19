require 'formula'

class Mx < Formula
  head 'https://github.com/clutter-project/mx.git'
  homepage 'http://clutter-project.org/'
  url 'https://github.com/downloads/clutter-project/mx/mx-1.4.7.tar.xz'
  sha1 'e7cc39a9a50248f388d0c3dcab26add3f575e911'

  if build.head?
    depends_on 'automake' => :build
    depends_on 'autoconf' => :build
    depends_on 'libtool' => :build
    depends_on 'gtk-doc' => :build
  end
  depends_on 'pkg-config' => :build
  depends_on 'xz' => :build
  depends_on 'intltool' => :build
  depends_on 'glib'
  depends_on 'gtk+'
  depends_on 'clutter'
  depends_on 'vala'
  #depends_on 'gobject-introspection'

  def patches
    DATA
  end

  def install
    if build.head?
      system './autogen.sh',  "--prefix=#{prefix}", '--disable-gtk-doc',
                              '--enable-vala'#, '--enable-introspection',
                              #'--with-winsys=none'
    end
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", #'--with-winsys=none',
                          '--enable-vala'#, '--enable-introspection'
    system "make", "install"
  end

  test do
    # definitely need something reasonable here.
    system "false"
  end
end

__END__
Subject: don't use GL types directly
Bug-Debian: http://bugs.debian.org/709914
Author: Emilio Pozuelo Monfort <pochu@debian.org>
--- a/mx/mx-deform-texture.c
+++ b/mx/mx-deform-texture.c
@@ -493,9 +493,9 @@
 static void
 mx_deform_texture_init_arrays (MxDeformTexture *self)
 {
-  GLushort *idx, *bf_idx;
+  gushort *idx, *bf_idx;
   gint x, y, direction;
-  GLushort *static_indices, *static_bf_indices;
+  gushort *static_indices, *static_bf_indices;
   MxDeformTexturePrivate *priv = self->priv;

   mx_deform_texture_free_arrays (self);
@@ -503,8 +503,8 @@
   priv->n_indices = (2 + 2 * priv->tiles_x) *
                     priv->tiles_y +
                     (priv->tiles_y - 1);
-  static_indices = g_new (GLushort, priv->n_indices);
-  static_bf_indices = g_new (GLushort, priv->n_indices);
+  static_indices = g_new (gushort, priv->n_indices);
+  static_bf_indices = g_new (gushort, priv->n_indices);

 #define MESH_INDEX(X, Y) (Y) * (priv->tiles_x + 1) + (X)

--- a/mx/mx-texture-frame.c
+++ b/mx/mx-texture-frame.c
@@ -200,7 +200,7 @@


   {
-    GLfloat rectangles[] =
+    gfloat rectangles[] =
     {
       /* top left corner */
       0, 0,
