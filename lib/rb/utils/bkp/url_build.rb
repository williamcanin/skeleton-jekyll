module ModuleUrlBuild

  # Method for reading the json file
  def read_json(filename)
    json_file_config = File.read("#{filename}")
    @parse_json_config = JSON.parse(json_file_config)
  end
    
  # Change the url to build, that is, to perform deploy on the hosting server.
  def url_build
    if not File.exist?(CONFIG['urlWebsite'])
      puts "✖ [ERROR] The file 'url.json' not exist. Aborted!".red
      exit
    end
    read_json(CONFIG['urlWebsite'])
    url = @parse_json_config['website']['url']
    baseurl = @parse_json_config['website']['baseurl']
    if not File.exist?(CONFIG['gulpConfig'])
      puts "[ERROR] The file 'lib/json/gulp.json' not exist. Aborted!".red
      exit
    end
    read_json(CONFIG['gulpConfig'])
    local_server = @parse_json_config['browserSync']['proxy']['target']
    port = @parse_json_config['browserSync']['port']

    config_yml = File.read("./_config.yml")
    config_yml.gsub!("url: \"#{local_server}:#{port}\"", "url: \"#{url}\"")
    config_yml.gsub!("baseurl: \"\"", "baseurl: \"#{baseurl}\"")
    File.write("./_config.yml", config_yml)
  end
end
