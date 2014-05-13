require "formula"

class QtCreator < Formula
  homepage "https://qt-project.org/wiki/Category:Tools::QtCreator"
  url "http://download.qt-project.org/official_releases/qtcreator/3.1/3.1.0/qt-creator-opensource-src-3.1.0.tar.gz"
  sha1 "1a4f7e938b3f9afc35c948e3fbefa3b9467eaf43"

  head "https://git.gitorious.org/qt-creator/qt-creator.git", :branch => "3.1"

  depends_on "qt5"

  def install
    system "#{Formula["qt5"].opt_prefix}/bin/qmake", "-r"
    system "make"

    Pathname.glob("bin/*.app") { |app| mv app, prefix }
  end
end
