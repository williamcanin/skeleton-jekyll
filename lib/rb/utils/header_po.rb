module HeaderPost
  def create_header_post(filename, title_post, date_hour, category)
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
end