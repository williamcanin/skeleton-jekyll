# --------------------------------------------------------------------
#
# Plugin:       HelloPage Setting
# Description:  This plugin is responsible for making change enable or disable the hellopage page
# Author:       William Canin
#
# Install:      Put into your _plugins dir in your Jekyll site
# Usage:        Add the following to the '_config.yml' file:

#             plugin:
#               hellopage:
#                 enable: <value>
#                 postlist-page: <page>
#
# value: [ true | false ]
# page: Insert post-page with markdown extension. e.g : 2-blog.md
# --------------------------------------------------------------------

module Jekyll
  module HelloPageSettings



    # Class for editing the 'index.md' file and the postlist page in the pages directory.
    class MarkdownChange

      # Index.md change method
      def change_index(dir_source,layout_current,layout_new)
        index = File.read(File.join(dir_source, "/index.md"))
        index.gsub!("layout: #{layout_current}", "layout: #{layout_new}")
        File.write(File.join(dir_source, "/index.md"), index)
      end

      # Postlist page file change method
      def change_page_values(dir_source,folder_pages,value_current,value_new,page_filename)
        page_get = File.read(File.join(dir_source, folder_pages, "/#{page_filename}"))
        page_get.gsub!("published: #{value_current}", "published: #{value_new}")
        page_get.gsub!("menu: #{value_current}", "menu: #{value_new}")
        File.write(File.join(dir_source, folder_pages, "/#{page_filename}"), page_get)
      end

    end



    # Class to start the redirect page process
    class RedirectIndex < Page

      # Method for initializing redirect page values
      def initialize(site, base)
        @site = site
        @base = base
        @name = 'blog.html'
        self.process(@name)
        self.read_yaml(File.join(base, '_layouts'), 'redirect.html')
      end

    end



    # Class that perform generation of methods and change to the project in Jekyll
    class RedirectGenerator < Generator

      priority :low

      # Generator method
      def generate(site)

        # Capture variable of 'hellopage' value in file '_config.yml'
        hellopage_get = site.config['plugin']['hellopage']

        # Comparisons for checking the status of the 'hello page' variable in the '_config.yml' file
        if hellopage_get['enable'] == true
          md = MarkdownChange.new
          md.change_index(site.source,"postlist_home","hellopage")
          md.change_page_values(site.source,site.include[0],"true","false","#{hellopage_get['page-filename']}")
        elsif hellopage_get['enable'] == false
          index = RedirectIndex.new(site, site.source)
          index.render(site.layouts, site.site_payload)
          index.write(site.dest)
          site.pages << index
          md = MarkdownChange.new
          md.change_index(site.source,"hellopage","postlist_home")
          md.change_page_values(site.source,site.include[0],"false","true","#{hellopage_get['page-filename']}")
        else
          puts "[ERROR] Variable 'hellopage' invalid in '_config.yml'"
          abort
        end

      end # end method generator

    end



  end
end