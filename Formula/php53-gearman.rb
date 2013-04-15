require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Gearman < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/gearman'
  url 'http://pecl.php.net/get/gearman-1.1.1.tgz'
  sha1 '98b8601b7cc921c4894a265aa6731263ecb60037'
  head 'https://svn.php.net/repository/pecl/gearman/trunk/', :using => :svn

  depends_on 'gearman'

  def install
    Dir.chdir "gearman-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-gearman=#{Formula.factory('gearman').opt_prefix}"
    system "make"
    prefix.install "modules/gearman.so"
    write_config_file unless build.include? "without-config-file"
  end
end
