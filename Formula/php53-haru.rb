require File.join(File.dirname(__FILE__), 'abstract-php-extension')

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Php53Haru < AbstractPhp53Extension
  init
  homepage ''
  url 'http://pecl.php.net/get/haru'
  sha1 'e56a2d5c9b7c7f02a840b80db0b87496a3b67793'
  version '1.0.4'

  # depends_on 'cmake' => :build
  depends_on 'libharu' # if your formula requires any X11/XQuartz components

  def install
    # ENV.j1  # if your formula's build system can't parallelize
    Dir.chdir "haru-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/haru.so"
    write_config_file unless build.include? "without-config-file"
  end

end
