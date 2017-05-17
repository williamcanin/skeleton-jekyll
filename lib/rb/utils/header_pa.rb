module HeaderPage
  def create_header_page(filename, layout, title_page, date_hour, slug)
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
end