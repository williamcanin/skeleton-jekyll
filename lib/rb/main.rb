#encoding: utf-8

# File: config.rb
# Language: Ruby
# Country/State: Brazil/SP
# Author : William C. Canin <http://williamcanin.com>
# Description: Script management.

require "fileutils"
require "json"
require "colorize"

include Version
include ConsolePrint

class Main

  # Include partials - Modules
  include Variables
  include HeaderProject
  include HeaderPage
  include HeaderPost
  include Credits





  def enter_parameters(msg1, value1, value2, condition)

    @value1 = value1
    @value2 = value2

    console_header_print
    puts @HEADER.black.on_green.blink;

    puts "⚠ Press ctrl-C when you get bored\n".yellow
    puts "[ #{msg1} ]".black.on_green.blink
    STDOUT.puts "→ Add #{value1.upcase}:".cyan
    printf "> "
    @value1 = STDIN.gets.chomp
    if @value1.nil? or @value1.empty?
      puts "✖ You must enter the #{value1.upcase} name! Aborted :(".red
      abort
    end
    if condition == true
      STDOUT.puts "→ Add #{value2.upcase}:".cyan
      printf "> "
      @value2 = STDIN.gets.chomp
      if @value2.nil?  or @value2.empty?
        puts "✖ You must enter the #{value2.upcase} name! Aborted :(".red
        abort
      end
    end

  end



  # How to create header posts
  def post_create(dirPost)

    abort("rake aborted: '#{CONFIG['dirPost']}' directory not found.") unless FileTest.directory?(CONFIG[dirPost])

    begin

      enter_parameters("Post header creation", "title", "category", true)

      title = @value1
      category = @value2



      slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      begin
        date_hour = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d %R:%S')
        date = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d')
      rescue => e
        puts "✖ Error - date format must be YYYY-MM-DD, please check you typed it correctly!".red
        exit -1
      end
      filepath = File.join("#{date}-#{slug}.#{CONFIG['markdown_ext']}")
      filename = File.join(CONFIG[dirPost], "#{date}-#{slug}.#{CONFIG['markdown_ext']}")

      if File.exist?(filename)
        abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
      end

      puts "⚠ Creating new file in: #{filename}".yellow



      if dirPost == 'postsDirBlog'
        create_header_post(filename, title, date_hour, category)
      end

    rescue Interrupt => e
      puts
      puts "⚠ Operation aborted!".yellow
    end

  end # End 'post_create'








  # How to create header page
  def page_create(dirPages)

    abort("rake aborted: '#{CONFIG['dirPages']}' directory not found.") unless FileTest.directory?(CONFIG[dirPages])

    begin

      enter_parameters("Page header creation", "title", "layout", true)

      title = @value1
      layout = @value2

      slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      begin
        date_hour = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d %R:%S')
        date = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d')
      rescue => e
        puts "✖ Error - date format must be YYYY-MM-DD, please check you typed it correctly!".red
        exit -1
      end
      filepath = File.join("#{date}-#{slug}.#{CONFIG['markdown_ext']}")

      # Count the number of existing pages and add +1 [DEPRECATED]
      # count_pages = Dir.glob(CONFIG['pagesDir']+"/*.*").size
      # next_number_page = count_pages + 1

      # filename = File.join(CONFIG[dirPages], "#{next_number_page}-#{slug}.#{CONFIG['markdown_ext']}") # DEPRECATED

      filename = File.join(CONFIG[dirPages], "#{slug}.#{CONFIG['markdown_ext']}")

      if File.exist?(filename)
        abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
      end

      puts "⚠ Creating new file in: #{filename}".yellow
      if dirPages == 'pagesDir'
        create_header_page(filename, layout, title, date_hour, slug)
      end

    rescue Interrupt => e
      puts "\n⚠ Operation aborted!".yellow
    end

  end # End 'page_create'








  # How to create header projects
  def project_create(dirProjects)

    abort("rake aborted: '#{CONFIG['dirProjects']}' directory not found.") unless FileTest.directory?(CONFIG[dirProjects])

    begin

      enter_parameters("Project header creation", "title", nil, false)

      title = @value1

      slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      begin
        date_hour = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d %R:%S')
        date = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d')
      rescue => e
        puts "✖ Error - date format must be YYYY-MM-DD, please check you typed it correctly!".red
        exit -1
      end
      filepath = File.join("#{date}-#{slug}.#{CONFIG['markdown_ext']}")
      filename = File.join(CONFIG[dirProjects], "#{date}-#{slug}.#{CONFIG['markdown_ext']}")

      if File.exist?(filename)
        abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
      end

      puts "⚠ Creating new file in: #{filename}".yellow
      if dirProjects == 'projectsDir'
        create_header_pr(filename, title, date_hour)
      end

    rescue Interrupt => e
      puts
      puts "⚠ Operation aborted!".yellow
    end

  end # End 'projects_create'








  # Method for reading the json file
  def read_json(filename)
    json_file_config = File.read("#{filename}")
    @parse_json_config = JSON.parse(json_file_config)
  end








  # Changes the url for production, that is, when starting the server.
  def url_serve
    if not File.exist?("url.json")
      puts "✖ [ERROR] The file 'url.json' not exist. Aborted!".red
      exit
    end
    read_json("url.json")
    url = @parse_json_config['website']['url']
    baseurl = @parse_json_config['website']['baseurl']
    if not File.exist?("lib/json/gulp.json")
      puts "✖ [ERROR] The file 'lib/json/gulp.json' not exist. Aborted!".red
      exit
    end
    read_json("lib/json/gulp.json")
    port = @parse_json_config['browserSync']['port']

    config_yml = File.read("./_config.yml")
    config_yml.gsub!("url: \"#{url}\"", "url: \"http://localhost:#{port}\"")
    config_yml.gsub!("baseurl: \"#{baseurl}\"", "baseurl: \"\"")
    File.write("./_config.yml", config_yml)
  end

  # Change the url to build, that is, to perform deploy on the hosting server.
  def url_build
    if not File.exist?("url.json")
      puts "✖ [ERROR] The file 'url.json' not exist. Aborted!".red
      exit
    end
    read_json("url.json")
    url = @parse_json_config['website']['url']
    baseurl = @parse_json_config['website']['baseurl']
    if not File.exist?("lib/json/gulp.json")
      puts "[ERROR] The file 'lib/json/gulp.json' not exist. Aborted!".red
      exit
    end
    read_json("lib/json/gulp.json")
    port = @parse_json_config['browserSync']['port']

    config_yml = File.read("./_config.yml")
    config_yml.gsub!("url: \"http://localhost:#{port}\"", "url: \"#{url}\"")
    config_yml.gsub!("baseurl: \"\"", "baseurl: \"#{baseurl}\"")
    File.write("./_config.yml", config_yml)
  end








  # Commands system
  def system_commands(cmd)
    begin
      system(cmd)
    rescue Interrupt => e
      puts "\n⚠ Operation aborted!".yellow
    end
  end



def install
  console_header_print
  puts @HEADER.black.on_green.blink;
  puts "⚠ Press ctrl-C when you get bored\n".yellow
  puts "[ Dependency installer ]".black.on_green.blink
  puts "→ Starting.Wait ...".cyan
  system("gem install bundle")
  system("bundle install")
  puts "\n✔ Finished installation process!\n".green
end




  # Method for print version
  def version
    puts "Script version: #{VERSION}".cyan
  end








  # Method for test
  def test_
    puts "Hey, little flower, you did an insignificant test.".cyan
  end









end # end class 'main'
