require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Twig < AbstractPhp53Extension
  init
  homepage 'http://twig.sensiolabs.org/'
  url 'https://github.com/fabpot/Twig.git', :tag => 'v1.12.3'
  head 'https://github.com/fabpot/Twig.git'
  version '1.12.3'

  def install
    ENV.universal_binary if build.universal?

    Dir.chdir 'ext/twig' do
      safe_phpize
      system "./configure", "--prefix=#{prefix}",
                            phpconfig
      system "make"
      prefix.install %w(modules/twig.so)
    end
    write_config_file unless build.include? "without-config-file"
  end
end
