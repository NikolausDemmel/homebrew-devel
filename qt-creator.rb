require "formula"

class QtCreator < Formula
  homepage "https://qt-project.org/wiki/Category:Tools::QtCreator"
  url "http://download.qt-project.org/official_releases/qtcreator/3.0/3.0.1/qt-creator-opensource-src-3.0.1.tar.gz"
  sha1 "5c2bb0dddd2e4e721e313d77dcc7ff42d384f76a"

  head "https://git.gitorious.org/qt-creator/qt-creator.git"

  depends_on "qt5"

  def install
    system "#{Formula["qt5"].opt_prefix}/bin/qmake", "-r"
    system "make"

    Pathname.glob("#{bin}/*.app") { |app| mv app, prefix }
  end
end
