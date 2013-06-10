require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Xhprof < AbstractPhp53Extension
  init
  homepage 'http://mirror.facebook.net/facebook/xhprof/doc.html'
  url 'http://pecl.php.net/get/xhprof-0.9.2.tgz'
  sha1 'cef6bfb3374e05c7b7445249a304e066d4fd8574'

  conflicts_with 'php53-xhgui'

  depends_on 'pcre'

  def install
    Dir.chdir "xhprof-#{version}/extension" do
      ENV.universal_binary if build.universal?

      safe_phpize
      system "./configure", "--prefix=#{prefix}",
                            phpconfig
      system "make"
      prefix.install "modules/xhprof.so"
    end

    Dir.chdir "xhprof-#{version}" do
      prefix.install %w(xhprof_html xhprof_lib)
    end
    write_config_file unless build.include? "without-config-file"
  end
end
