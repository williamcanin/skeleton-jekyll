#encoding: utf-8

# File: config.rb
# Language: Ruby
# Country/State: Brazil/SP
# Author : William C. Canin <http://williamcanin.com>
# Description: Script management.

require "fileutils"
require "json"


# Class to set global variables
class Variables

  SOURCE = "."
  CONFIG = {
    'postsDirBlog' => File.join(SOURCE, "_posts/_blog"),
    'pagesDir' => File.join(SOURCE, "_pages"),
    'projectsDir' => File.join(SOURCE, "_projects"),
    'markdown_ext' => "md"
  }

end # End 'Variables'

class Main < Variables

  # How to create header posts
  def post_create(dirPost)

    # Variables for post/blog
    abort("rake aborted: '#{CONFIG['dirPost']}' directory not found.") unless FileTest.directory?(CONFIG[dirPost])

    # [DEPRECATED]
    # title_post = ENV["TITLE"]
    # category = ENV["CATEGORY"]

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
        open(filename, 'w') do |file|
          file.puts("---")
          file.puts("layout: post")
          file.puts("title: #{title_post.gsub(/-/,' ')}")
          file.puts("subtitle: ")
          file.puts("date: #{date_hour}")
          file.puts("category: #{category}")
          file.puts("tags: ['tag1','tag2','tag3']")
          file.puts("published: false")
          file.puts("comments: false")
          file.puts("share: false")
          file.puts("excerpted: |
  \"Put here your excerpt\"")
          file.puts("# Does not change and does not remove 'script_js' variable.")
          file.puts("script_js: [jekyll-search.min.js, post.js]")
          file.puts("")
          file.puts("# Events Google Analytics")
          file.puts("ga_event: false")
          file.puts("")
          file.puts("# Does not change and does not remove 'script_html' variable.")
          file.puts("script_html: [search.html]")
          file.puts("---")
          puts "Created successfully!"
        end
      end

    rescue Interrupt => e
      puts
      puts "Operation aborted!"
    end

  end # End 'post_create'









  # How to create header page
  def page_create(dirPages)

    # Variables for post/blog
    abort("rake aborted: '#{CONFIG['dirPages']}' directory not found.") unless FileTest.directory?(CONFIG[dirPages])

    # [DEPRECATED]
    # title_page = ENV["TITLE"]
    # layout = ENV["LAYOUT"]

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
        open(filename, 'w') do |file|
          file.puts("---")
          file.puts("layout: #{layout.downcase}")
          file.puts("title: #{title_page}")
          file.puts("date: #{date_hour}")
          file.puts("")
          file.puts("# Enable / Disable this page in the main menu.")
          file.puts("menu: false")
          file.puts("")
          file.puts("# Publishing or not on the server")
          file.puts("published: false")
          file.puts("")
          file.puts("# Does not change and does not remove 'script_js' variables")
          file.puts("# Add the JS name and extension you want for this page. Then add the script to the \"src/js\" folder")
          file.puts("script_js:")
          file.puts("")
          file.puts("# Does not change and does not remove 'script_html' variables")
          file.puts("# Add the name and extension of the HTML you want for this page. Then add the script to the \"_includes/scripts\" folder")
          file.puts("script_html:")
          file.puts("")
          file.puts("permalink: /#{slug}/")
          file.puts("---")
          puts "Created successfully!"
        end
      end

    rescue Interrupt => e
      puts
      puts "Operation aborted!"
    end

  end # End 'page_create'


  # How to create header projects
  def project_create(dirProjects)

    # Variables for post/blog
    abort("rake aborted: '#{CONFIG['dirProjects']}' directory not found.") unless FileTest.directory?(CONFIG[dirProjects])

    # [DEPRECATED]
    # title_project = ENV["TITLE"]

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
        open(filename, 'w') do |file|
          file.puts("---")
          file.puts("layout: projectslist")
          file.puts("title: #{title_project.gsub(/-/,' ')}")
          file.puts("date: #{date_hour}")
          file.puts("published: false")
          file.puts("")
          file.puts("# Do not change the permalink setting")
          file.puts("permalink: /projects/")
          file.puts("---")
          puts "Created successfully!"
        end
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

  # Commands console
  def system_commands(cmd)
    begin
      system(cmd)
    rescue Interrupt => e
      puts
      puts "Operation aborted!"
    end
  end

  # Method for test
  def test_
    puts "Hey, little flower, you did an insignificant test."
  end

  # Function for creating folders [DEPRECATED]
  # def create_folders (options = [])
  #   FileUtils::mkdir_p options
  # end

  # Function for remove folders [DEPRECATED]
  # def remove_folders (options = [])
  #   FileUtils::rm_rf options
  # end

  # Function to create page redirect html file. [DEPRECATED]
  # def create_redirect_page(filename)
  #   File.open(filename, 'w') do |file|
  #     file.puts "<!DOCTYPE html>"
  #     file.puts "<html>"
  #     file.puts "<head>"
  #     file.puts "  <meta http-equiv=\"refresh\" content=\"0; url=/\">"
  #     file.puts "  <title>Redirect</title>"
  #     file.puts "</head>"
  #     file.puts "</html>"
  #   end
  # end

  # Function to apply option (true | false) of the presentation page. [DEPRECATED]
  # def hello_page(value)

  #   page_blog_file = "2-blog.#{CONFIG['markdown_ext']}"
  #   indexmd_file = "index.#{CONFIG['markdown_ext']}"

  #   if value == true

  #     remove_folders(["blog/"])

  #     blog_page = File.read("_pages/#{page_blog_file}")
  #     blog_page.gsub!("published: false", "published: #{value}")
  #     blog_page.gsub!("menu: false", "menu: #{value}")
  #     File.write("_pages/#{page_blog_file}", blog_page)

  #     indexmd = File.read("#{indexmd_file}")
  #     indexmd.gsub!("layout: postlist", "layout: home")
  #     File.write("#{indexmd_file}", indexmd)

  #   elsif value == false

  #     create_folders(["blog/"])
  #     create_redirect_page("blog/index.html")

  #     blog_page = File.read("_pages/#{page_blog_file}")
  #     blog_page.gsub!("published: true", "published: #{value}")
  #     blog_page.gsub!("menu: true", "menu: #{value}")
  #     File.write("_pages/#{page_blog_file}", blog_page)

  #     indexmd = File.read("#{indexmd_file}")
  #     indexmd.gsub!("layout: home", "layout: postlist")
  #     File.write("#{indexmd_file}", indexmd)

  #   else
  #     p "[Error] Usage: true | false "
  #   end
  # end
end
