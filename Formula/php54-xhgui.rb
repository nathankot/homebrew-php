require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Xhgui < AbstractPhp54Extension
  init
  homepage 'https://github.com/preinheimer/xhgui'
  url 'https://github.com/preinheimer/xhgui/tarball/ee00acb209d09d3ee0614117971fd3ac517e4097'
  sha1 '8a0d168e90c6939e3260be2d435021a25a5053ba'
  head 'https://github.com/preinheimer/xhgui.git'
  version 'ee00acb'

  depends_on 'php54-xhprof'
  depends_on 'php54-mongo'
  depends_on 'mongodb'

  def install
    prefix.install %w(external web)
    (prefix + 'web/cache').chmod 0777
  end

  def options
    []
  end

  def caveats
    caveats = <<-EOS

  Post Install
  ============

  * Restart your webserver to load the xhprof.so module dependency.
  * Point your webserver to folder "web/webroot"
  * Update you mongodb configuration (username, password, host and/or port)
    if you're not using the default values:

    #{prefix}/web/config/config.php

  * Add indexes to mongodb for increased for performance.

     $ mongo xhprof

     db.results.ensureIndex( { 'meta.SERVER.REQUEST_TIME' : -1 } )
     db.results.ensureIndex( { 'profile.main().wt' : -1 } )
     db.results.ensureIndex( { 'profile.main().mu' : -1 } )
     db.results.ensureIndex( { 'profile.main().cpu' : -1 } )
     db.results.ensureIndex( { 'meta.url' : 1 } )

  Profiling
  =========

  * For system wide random profiling, you can add the following directive in php.ini:

    auto_prepend_file=#{prefix}/external/header.php

  * If you prefer to configure profiling per virtual host:

    Using Apache:

    <VirtualHost *:80>
        php_admin_value auto_prepend_file "#{prefix}/external/header.php"
        DocumentRoot "/Users/markstory/Sites/awesome-thing/app/webroot/"
        ServerName site.localhost
    </VirtualHost>

    Using nginx:

    server {
        listen 80;
        server_name site.localhost;
        root /Users/markstory/Sites/awesome-thing/app/webroot/;
        fastcgi_param PHP_VALUE "auto_prepend_file=#{prefix}/external/header.php";
     }
EOS
    caveats
  end
end
