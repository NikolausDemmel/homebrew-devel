class TestFoo < Formula
  desc ""
  homepage ""
  url "http://example.com"
  version "0.0.2"
  sha256 "3587cb776ce0e4e8237f215800b7dffba0f25865cb84550e87ea8bbac838c423"

  def install
    touch 'baz.txt'
    (share/'foo/bar').install 'baz.txt'
  end
end
