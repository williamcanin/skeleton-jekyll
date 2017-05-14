module Jekyll
  class ArchiveIndex < Page
    def initialize(site, base, dir)
      @site = site
      @base = base
      @dir = dir
      @name = 'blog.html'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'redirect.html')
    end
  end

  class ArchiveGenerator < Generator
    priority :low
    def generate(site)
         @lpage = site.config['hellopage']
         if @lpage == false
          index = ArchiveIndex.new(site, site.source, '/')
          index.render(site.layouts, site.site_payload)
          index.write(site.dest)
          site.pages << index
          end
    end
  end
end