#encoding: utf-8

# File: config.rb
# Language: Ruby
# Country/State: Brazil/SP
# Author : William C. Canin <http://williamcanin.com>
# Description: Script management.

require "fileutils"
require "json"

class Main

  # Include partials - Modules
  include Version
  include Variables
  include HeaderProject
  include HeaderPage
  include HeaderPost








  # How to create header posts
  def post_create(dirPost)

    abort("rake aborted: '#{CONFIG['dirPost']}' directory not found.") unless FileTest.directory?(CONFIG[dirPost])

    # Variables for post/blog
    title_post = ''
    category = ''

    begin
      puts "Press ctrl-C when you get bored"

      STDOUT.puts "Add TITLE:"
      title_post = STDIN.gets.chomp

      if title_post.nil? or title_post.empty?
        abort("You must enter the TITLE name! Aborted :(")
      end

      STDOUT.puts "Add CATEGORY:"
      category = STDIN.gets.chomp

      if category.nil?  or category.empty?
        abort("You must enter the CATEGORY name! Aborted :(")
      end

      slug = title_post.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      begin
        date_hour = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d %R:%S')
        date = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d')
      rescue => e
        puts "Error - date format must be YYYY-MM-DD, please check you typed it correctly!"
        exit -1
      end
      filepath = File.join("#{date}-#{slug}.#{CONFIG['markdown_ext']}")
      filename = File.join(CONFIG[dirPost], "#{date}-#{slug}.#{CONFIG['markdown_ext']}")

      if File.exist?(filename)
        abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
      end

      puts "Creating new post: #{filename}"
      if dirPost == 'postsDirBlog'
        create_header_post(filename, title_post, date_hour, category)
      end

    rescue Interrupt => e
      puts
      puts "Operation aborted!"
    end

  end # End 'post_create'








  # How to create header page
  def page_create(dirPages)

    abort("rake aborted: '#{CONFIG['dirPages']}' directory not found.") unless FileTest.directory?(CONFIG[dirPages])

    # Variables for post/blog
    title_page = ''
    layout = ''

    begin
      puts "Press ctrl-C when you get bored"

      STDOUT.puts "Add TITLE:"
      title_page = STDIN.gets.chomp

      if title_page.nil? or title_page.empty?
        abort("You must enter the TITLE name! Aborted :(")
      end

      STDOUT.puts "Add LAYOUT:"
      layout = STDIN.gets.chomp

      if layout.nil?  or layout.empty?
        abort("You must enter the CATEGORY name! Aborted :(")
      end


      slug = title_page.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      begin
        date_hour = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d %R:%S')
        date = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d')
      rescue => e
        puts "Error - date format must be YYYY-MM-DD, please check you typed it correctly!"
        exit -1
      end
      filepath = File.join("#{date}-#{slug}.#{CONFIG['markdown_ext']}")

      # Count the number of existing pages and add +1 [DEPRECATED]
      count_pages = Dir.glob(CONFIG['pagesDir']+"/*.*").size
      next_number_page = count_pages + 1

      # filename = File.join(CONFIG[dirPages], "#{next_number_page}-#{slug}.#{CONFIG['markdown_ext']}") # DEPRECATED

      filename = File.join(CONFIG[dirPages], "#{slug}.#{CONFIG['markdown_ext']}")

      if File.exist?(filename)
        abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
      end

      puts "Creating new page: #{filename}"
      if dirPages == 'pagesDir'
        create_header_page(filename, layout, title_page, date_hour, slug)
      end

    rescue Interrupt => e
      puts
      puts "Operation aborted!"
    end

  end # End 'page_create'








  # How to create header projects
  def project_create(dirProjects)

    abort("rake aborted: '#{CONFIG['dirProjects']}' directory not found.") unless FileTest.directory?(CONFIG[dirProjects])

    # Variables for post/blog
    title_project = ''

    begin
      puts "Press ctrl-C when you get bored"

      STDOUT.puts "Add TITLE:"
      title_project = STDIN.gets.chomp

      if title_project.nil? or title_project.empty?
        abort("You must enter the TITLE name! Aborted :(")
      end

      slug = title_project.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      begin
        date_hour = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d %R:%S')
        date = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d')
      rescue => e
        puts "Error - date format must be YYYY-MM-DD, please check you typed it correctly!"
        exit -1
      end
      filepath = File.join("#{date}-#{slug}.#{CONFIG['markdown_ext']}")
      filename = File.join(CONFIG[dirProjects], "#{date}-#{slug}.#{CONFIG['markdown_ext']}")

      if File.exist?(filename)
        abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
      end

      puts "Creating new post: #{filename}"
      if dirProjects == 'projectsDir'
        create_header_pr(filename, title_project, date_hour)
      end

    rescue Interrupt => e
      puts
      puts "Operation aborted!"
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
      p "[ERROR] The file 'url.json' not exist. Aborted!"
      exit
    end
    read_json("url.json")
    url = @parse_json_config['website']['url']
    baseurl = @parse_json_config['website']['baseurl']
    if not File.exist?("lib/json/gulp.json")
      p "[ERROR] The file 'lib/json/gulp.json' not exist. Aborted!"
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
      p "[ERROR] The file 'url.json' not exist. Aborted!"
      exit
    end
    read_json("url.json")
    url = @parse_json_config['website']['url']
    baseurl = @parse_json_config['website']['baseurl']
    if not File.exist?("lib/json/gulp.json")
      p "[ERROR] The file 'lib/json/gulp.json' not exist. Aborted!"
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
      puts
      puts "Operation aborted!"
    end
  end








  # Method for print version
  def version
    puts "Script version: #{VERSION}"
  end








  # Method for test
  def test_
    puts "Hey, little flower, you did an insignificant test."
  end









end # end class 'main'
