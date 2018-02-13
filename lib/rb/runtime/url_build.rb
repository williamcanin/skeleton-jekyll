require "fileutils"
require "json"
require "yaml"
require "colorize"
require "./lib/rb/utils/variables.rb"
require "./lib/rb/utils/utilities.rb"


class UrlBuild

    include Variables
    include Utilities

    # Change the url to build, that is, to perform deploy on the hosting server.
    def url_build
      vConfig(CONFIG['configWebsite'])
      read_json(CONFIG['configWebsite'])
      url = @parse_json_config['website']['url']
      baseurl = @parse_json_config['website']['baseurl']
      vConfig(CONFIG['gulpConfig'])
      read_json(CONFIG['gulpConfig'])
      local_server = @parse_json_config['browserSync']['proxy']['target']
      port = @parse_json_config['browserSync']['port']

      yml_File = File.read(CONFIG['configYML'])

      yml_values = read_yml_value(CONFIG['configYML'])

      yml_File.gsub!("url: \"#{yml_values['url']}:#{port}\"", "url: \"#{url}\"")
      yml_File.gsub!("url: \"#{local_server}:#{port}\"", "url: \"#{url}\"")
      yml_File.gsub!("baseurl: \"\"", "baseurl: \"#{baseurl}\"")
      yml_File.gsub!("baseurl: \"#{yml_values['baseurl']}\"", "baseurl: \"#{baseurl}\"")
      File.write(CONFIG['configYML'], yml_File)
    end

end

# Start
run = UrlBuild.new
run.url_build
