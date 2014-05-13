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
  url 'http://www.cmake.org/files/v2.8/cmake-2.8.12.2.tar.gz'
  sha1 'cca70b307aa32a6a32c72e01fdfcecc84c1c2690'

  head 'https://github.com/Kitware/CMake.git', :branch => 'master'

  stable do
    patch do
      url "https://github.com/NikolausDemmel/CMake/pull/2.patch"
      sha1 "0e21491d5846ddb9b177403eae495bb2105b046e"
    end
  end

  head do
    patch do
      url "https://github.com/NikolausDemmel/CMake/pull/1.patch"
      sha1 "1f859658668739984e01fc9e83516324b4138022"
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
