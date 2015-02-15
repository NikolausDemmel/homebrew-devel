require 'formula'

class NoExpatFramework < Requirement
  def expat_framework
    '/Library/Frameworks/expat.framework'
  end

  satisfy :build_env => false do
    not File.exist? expat_framework
  end

  def message; <<-EOS.undent
    Detected #{expat_framework}

    This will be picked up by CMake's build system and likely cause the
    build to fail, trying to link to a 32-bit version of expat.

    You may need to move this file out of the way to compile CMake.
    EOS
  end
end

class Cmake < Formula
  homepage "http://www.cmake.org/"
  url "http://www.cmake.org/files/v3.1/cmake-3.1.3.tar.gz"
  sha1 "5b9bb6e6f8c93335a0ef7b6c2d00a5273c2ea6cc"

#  head "https://github.com/Kitware/CMake.git", :branch => "master"
  head "http://cmake.org/cmake.git"

  stable do
    patch do
      url "https://github.com/NikolausDemmel/CMake/pull/5.diff"
      sha1 "72953c9a96b4c8c962073145a35dd2bedd5911ab"
    end
  end

  head do
    patch do
      url "https://github.com/NikolausDemmel/CMake/pull/4.patch"
      sha1 "bcbdc5077202e924c38d32eb8abab10177ee00f7"
    end
  end

  depends_on NoExpatFramework

  def install
    args = %W[
      --prefix=#{prefix}
      --system-libs
      --no-system-libarchive
      --datadir=/share/cmake
      --docdir=/share/doc/cmake
      --mandir=/share/man
    ]

    system "./bootstrap", *args
    system "make"
    system "make install"
  end

  test do
    (testpath/'CMakeLists.txt').write('find_package(Ruby)')
    system "#{bin}/cmake", '.'
  end
end
