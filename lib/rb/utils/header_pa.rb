module HeaderPage
  def create_header_page(filename, layout, title_page, date_hour, slug)
    open(filename, 'w') do |file|
      file.puts("---")
      file.puts("layout: #{layout.downcase}")
      file.puts("title: #{title_page}")
      file.puts("date: #{date_hour}\n\n")
      file.puts("# Enable / Disable this page in the main menu.")
      file.puts("menu: false\n\n")
      file.puts("# Publishing or not on the server")
      file.puts("published: false\n\n")
      file.puts("# Sitemap configuration [automatic]")
      file.puts("sitemap:")
      file.puts("  priority: 0.7")
      file.puts("  changefreq: 'monthly'")
      file.puts("  lastmod: #{date_hour}\n\n")
      file.puts("# Does not change and does not remove 'script_js' variables")
      file.puts("# Add the JS name and extension you want for this page. Then add the script to the \"src/js\" folder")
      file.puts("script_js:\n\n")
      file.puts("# Does not change and does not remove 'script_html' variables")
      file.puts("# Add the name and extension of the HTML you want for this page. Then add the script to the \"_includes/scripts\" folder")
      file.puts("script_html:\n\n")
      file.puts("permalink: /#{slug}/")
      file.puts("---")
      puts "✔ Created successfully!".green
    end
  end
end