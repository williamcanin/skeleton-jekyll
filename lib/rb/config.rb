#encoding: utf-8

# File: config.rb
# Language: Ruby
# Country/State: Brazil/SP
# Author : William C. Canin <http://williamcanin.com>
# Description: Script management.

require "fileutils"

# Class to set global variables
class Variables

  SOURCE = "."
  CONFIG = {
    'postsDirBlog' => File.join(SOURCE, "_posts/_blog"),
    'pagesDir' => File.join(SOURCE, "_pages"),
    'markdown_ext' => "md"
  }

end # End 'Variables'

class Main < Variables

  # How to create posts
  def post_create(dirPost)

    # Variables for post/blog
    abort("rake aborted: '#{CONFIG['dirPost']}' directory not found.") unless FileTest.directory?(CONFIG[dirPost])
    title_post = ENV["TITLE"]

    if title_post.nil?
      abort("You must enter the TITLE name! Aborted :(
Example: rake post:blog TITLE=\"My post\"")
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
          file.puts("categories: blog")
          file.puts("tags: ['tag1','tag2','tag3']")
          file.puts("published: false")
          file.puts("comments: false")
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
  end # End 'post_create'

  # How to create page
  def page_create(dirPages)

    # Variables for post/blog
    abort("rake aborted: '#{CONFIG['dirPages']}' directory not found.") unless FileTest.directory?(CONFIG[dirPages])
    title_page = ENV["TITLE"]
    layout = ENV["LAYOUT"]

    if title_page.nil?
      abort("You must enter the TITLE name! Aborted :(
Example: rake page:create TITLE=\"My page\" LAYOUT=\"page\"")
    end

    if layout.nil?
      abort("You must enter the LAYOUT name! Aborted :(
Example: rake page:create TITLE=\"My page\" LAYOUT=\"page\"
Note: If you do not use layout, leave 'null'")
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

      # Count the number of existing pages and add +1
      count_pages = Dir.glob(CONFIG['pagesDir']+"/*.*").size
      next_number_page = count_pages + 1

      filename = File.join(CONFIG[dirPages], "#{next_number_page}-#{slug}.#{CONFIG['markdown_ext']}")

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
  end # End 'page_create'

  # Function for creating folders
  def create_folders (options = [])
    FileUtils::mkdir_p options
  end

  # Function for remove folders
  def remove_folders (options = [])
    FileUtils::rm_rf options
  end

  # Function to create page redirect html file.
  def create_redirect_page(filename)
    File.open(filename, 'w') do |file|
      file.puts "<!DOCTYPE html>"
      file.puts "<html>"
      file.puts "<head>"
      file.puts "  <meta http-equiv=\"refresh\" content=\"0; url=/\">"
      file.puts "  <title>Redirect</title>"
      file.puts "</head>"
      file.puts "</html>"
    end
  end

  # Function to apply option (true | false) of the presentation page.
  def hello_page(value)

    page_blog_file = "2-blog.#{CONFIG['markdown_ext']}"
    indexmd_file = "index.#{CONFIG['markdown_ext']}"

    if value == true

      remove_folders(["blog/"])

      blog_page = File.read("_pages/#{page_blog_file}")
      blog_page.gsub!("published: false", "published: #{value}")
      blog_page.gsub!("menu: false", "menu: #{value}")
      File.write("_pages/#{page_blog_file}", blog_page)

      indexmd = File.read("#{indexmd_file}")
      indexmd.gsub!("layout: postlist", "layout: home")
      File.write("#{indexmd_file}", indexmd)

    elsif value == false

      create_folders(["blog/"])
      create_redirect_page("blog/index.html")

      blog_page = File.read("_pages/#{page_blog_file}")
      blog_page.gsub!("published: true", "published: #{value}")
      blog_page.gsub!("menu: true", "menu: #{value}")
      File.write("_pages/#{page_blog_file}", blog_page)

      indexmd = File.read("#{indexmd_file}")
      indexmd.gsub!("layout: home", "layout: postlist")
      File.write("#{indexmd_file}", indexmd)

    else
      p "[Error] Usage: true | false "
    end
  end

end
