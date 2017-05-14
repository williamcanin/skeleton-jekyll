module Jekyll

  # class ArchiveIndex < Page
  #   def initialize(site, name, dir)
  #     @site = site
  #     @name = name
  #     @dir = dir

  #     p @site.dest
  #   end
  # end

  class HelloPage < Generator

    # def permalink_pplist(dir_source,folder_pages)
    #   pplist_filename = "2-blog.md"
    #   pplist = File.read(File.join(dir_source, folder_pages, "/#{pplist_filename}"))
    # end

    # Function to create page redirect html file.
    def create_redirect_page(dir, filename)
       FileUtils::mkdir_p dir
      File.open("#{dir}/#{filename}", 'w') do |file|
        file.puts "<!DOCTYPE html>"
        file.puts "<html>"
        file.puts "<head>"
        file.puts "  <meta http-equiv=\"refresh\" content=\"0; url=/\">"
        file.puts "  <title>Redirect</title>"
        file.puts "</head>"
        file.puts "</html>"
      end
    end

    def change_index(dir_source,layout_current,layout_new)
      index = File.read(File.join(dir_source, "/index.md"))
      index.gsub!("layout: #{layout_current}", "layout: #{layout_new}")
      File.write(File.join(dir_source, "/index.md"), index)
    end

    def setting_pplist(dir_source,folder_pages,value_current,value_new)
      pplist_filename = "2-blog.md"
      pplist = File.read(File.join(dir_source, folder_pages, "/#{pplist_filename}"))
      pplist.gsub!("published: #{value_current}", "published: #{value_new}")
      pplist.gsub!("menu: #{value_current}", "menu: #{value_new}")
      File.write(File.join(dir_source, folder_pages, "/#{pplist_filename}"), pplist)
    end

    def generate(site)

       @lpage = site.config['hellopage']
        if @lpage == true
          change_index(site.source,"postlist","home")
          setting_pplist(site.source,site.include[0],"false","true")
        elsif @lpage == false
          change_index(site.source,"home","postlist")
          setting_pplist(site.source,site.include[0],"true","false")
          # create_redirect_page(File.join(site.dest, "/blog"),"/index.html")
          # p site.pages
          # p site.site_payload.site.data['data']['website']['title']
          # permalink_pplist(site.source,site.include[0])
          # ArchiveIndex.new (site,name,dir)
        end
    end

  end



end