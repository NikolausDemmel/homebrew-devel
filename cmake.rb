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
  homepage 'http://www.cmake.org/'
  url 'http://www.cmake.org/files/v3.0/cmake-3.0.0.tar.gz'
  sha1 '4dfd9ee9b829c77175d655f22322f14747f11ad2'

#  head 'https://github.com/Kitware/CMake.git', :branch => 'master'
  head 'http://cmake.org/cmake.git'

  stable do
    patch do
      url "https://github.com/NikolausDemmel/CMake/pull/3.patch"
      sha1 "77d49adadeafed7cfe8447188cc39b8abd125d94"
    end
  end

  head do
    patch do
      url "https://github.com/NikolausDemmel/CMake/pull/4.patch"
      sha1 "e5fa2c951180657baf3b1e97f19e273591e5f8c3"
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
