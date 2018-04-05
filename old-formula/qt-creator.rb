require "formula"

class QtCreator < Formula
  homepage "https://qt-project.org/wiki/Category:Tools::QtCreator"
  url "http://download.qt-project.org/official_releases/qtcreator/3.1/3.1.2/qt-creator-opensource-src-3.1.2.tar.gz"
  sha1 "b231ce2311208bec1c61e50ed8e74bb6f8a4cf64"

  head "https://git.gitorious.org/qt-creator/qt-creator.git", :branch => "3.2"

  depends_on "qt5"

  def install
    system "#{Formula["qt5"].opt_prefix}/bin/qmake", "-r"
    system "make"

    Pathname.glob("bin/*.app") { |app| mv app, prefix }
  end
end
