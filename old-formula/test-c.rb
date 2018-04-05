require 'formula'

class TestC < Formula
  homepage 'http://ppss.googlecode.com'
  url 'http://ppss.googlecode.com/files/ppss-2.83.tgz'
  sha1 'b4e76800ebaaf04c0d66e91d697ffd279654aab6'
  head 'http://ppss.googlecode.com/svn/trunk/'
  
  devel do
    url 'http://ppss.googlecode.com/files/ppss-2.85.tgz'
    sha1 '3b21f873fe38a36df9d4214b191c6944ed244462'
  end

  option 'with-foo'
  option 'with-bar'

  def install
  end
end
