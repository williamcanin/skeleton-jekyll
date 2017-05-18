module HeaderPost
  def create_header_post(filename, title, date_hour, category)
    open(filename, 'w') do |file|
      file.puts("---")
      file.puts("layout: post")
      file.puts("title: #{title.gsub(/-/,' ')}")
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
      file.puts("script_js: [jekyll-search.min.js, post.js]\n\n")
      file.puts("# Events Google Analytics")
      file.puts("ga_event: false\n\n")
      file.puts("# Does not change and does not remove 'script_html' variable.")
      file.puts("script_html: [search.html]")
      file.puts("---")
      puts "✔ Created successfully!".green
    end
  end
end