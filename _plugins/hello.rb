require "fileutils"
require "yaml"

module Jekyll
  class HelloPage < Jekyll::Generator
    def generate(site)
      @site = site

      # Loading and Capture config file _config.yml
      data_hash_yml = YAML::load_file(File.join(File.dirname(File.expand_path(__FILE__)), '../_config.yml'))
      hellopage = data_hash_yml['hellopage']
      path_root = File.join(File.expand_path(__FILE__), '../')

     if hellopage == false
        indexmd = File.read(File.join(File.dirname(File.expand_path(__FILE__)), '../index.md'))
        indexmd.gsub!("layout: home", "layout: postlist")
        File.write("index.md", indexmd)

        blog_page = File.read(File.join(File.dirname(File.expand_path(__FILE__)), '../_pages/2-blog.md'))
        blog_page.gsub!("published: true", "published: false")
        blog_page.gsub!("menu: true", "menu: false")
        File.write("_pages/2-blog.md", blog_page)
     end
    end
  end

  class Main < Jekyll::StaticFile
    def initialize(tag_name, input, tokens)
      system("bundle exec jekyll b")
    end
  end

end

