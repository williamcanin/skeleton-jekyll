require "fileutils"
require "json"
require "yaml"
require "colorize"
require "./lib/rb/utils/variables.rb"
require "./lib/rb/utils/utilities.rb"


class UrlServer

  include Variables
  include Utilities

  # Changes the url for production, that is, when starting the server.
  def url_serve
    vConfig(CONFIG['configWebsite'])
    read_json(CONFIG['configWebsite'])
    # config/config.json
    url = @parse_json_config['website']['url']
    baseurl = @parse_json_config['website']['baseurl']
    vConfig(CONFIG['gulpConfig'])
    read_json(CONFIG['gulpConfig'])
    # lib/json/gulp.json
    local_server = @parse_json_config['browserSync']['proxy']['target']
    port = @parse_json_config['browserSync']['port']

    yml_File = File.read(CONFIG['configYML'])

    yml_values = read_yml_value(CONFIG['configYML'])

    yml_File.gsub!("url: \"#{'url'}\"", "url: \"#{local_server}:#{port}\"")
    yml_File.gsub!("url: \"#{yml_values['url']}\"", "url: \"#{local_server}:#{port}\"")
    yml_File.gsub!("baseurl: \"#{baseurl}\"", "baseurl: \"\"")
    yml_File.gsub!("baseurl: \"#{yml_values['baseurl']}\"", "baseurl: \"\"")
    File.write(CONFIG['configYML'], yml_File)
  end

end

# Start
run = UrlServer.new
run.url_serve
