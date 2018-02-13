module UrlServer
  # Changes the url for production, that is, when starting the server.
  def url_serve
    if not File.exist?(CONFIG['urlWebsite'])
      puts "✖ [ERROR] The file 'url.json' not exist. Aborted!".red
      exit
    end
    read_json(CONFIG['urlWebsite'])
    url = @parse_json_config['website']['url']
    baseurl = @parse_json_config['website']['baseurl']
    if not File.exist?(CONFIG['gulpConfig'])
      puts "✖ [ERROR] The file 'lib/json/gulp.json' not exist. Aborted!".red
      exit
    end
    read_json(CONFIG['gulpConfig'])
    local_server = @parse_json_config['browserSync']['proxy']['target']
    port = @parse_json_config['browserSync']['port']

    config_yml = File.read("./_config.yml")
    config_yml.gsub!("url: \"#{url}\"", "url: \"#{local_server}:#{port}\"")
    config_yml.gsub!("baseurl: \"#{baseurl}\"", "baseurl: \"\"")
    File.write("./_config.yml", config_yml)
  end
end
