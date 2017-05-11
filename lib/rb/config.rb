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
    else

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
    end

  end # End 'post_create'

  def create_folders (options = [])
    FileUtils::mkdir_p options
  end

  def remove_folders (options = [])
    FileUtils::rmdir options
  end

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

  def presentation_page(value)
    if value == true

      remove_folders(["blog/"])

      blog_page = File.read("_pages/2-blog.md")
      blog_page.gsub!("published: false", "published: #{value}")
      blog_page.gsub!("menu: false", "menu: #{value}")
      File.write("_pages/2-blog.md", blog_page)

      indexmd = File.read("index.md")
      indexmd.gsub!("layout: postlist", "layout: home")
      File.write("index.md", indexmd)

    elsif value == false

      create_folders(["blog/"])
      create_redirect_page("blog/index.html")

      blog_page = File.read("_pages/2-blog.md")
      blog_page.gsub!("published: true", "published: #{value}")
      blog_page.gsub!("menu: true", "menu: #{value}")
      File.write("_pages/2-blog.md", blog_page)

      indexmd = File.read("index.md")
      indexmd.gsub!("layout: home", "layout: postlist")
      File.write("index.md", indexmd)

    end
  end

end