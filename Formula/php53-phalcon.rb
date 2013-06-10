require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Phalcon < AbstractPhp53Extension
  init
  homepage 'http://phalconphp.com/'
  url 'https://github.com/phalcon/cphalcon/tarball/1.1.0'
  sha1 'cc3dbc94885aa6e7b1a87570dbbdac5e831eacd3'
  head 'git://github.com/phalcon/cphalcon.git', :using => :git
  version '1.1.0'

  depends_on 'pcre'

  def install
    if MacOS.prefer_64_bit?
      Dir.chdir 'build/64bits'
    else
      Dir.chdir 'build/32bits'
    end

    ENV.universal_binary if build.universal?
    ENV.gcc
    ENV['CFLAGS'] = '-O2 -fno-delete-null-pointer-checks -finline-functions -fomit-frame-pointer'

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file unless build.include? "without-config-file"
  end
end
