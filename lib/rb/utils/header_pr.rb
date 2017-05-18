module HeaderProject
  def create_header_pr(filename, title, date_hour)
    open(filename, 'w') do |file|
      file.puts("---")
      file.puts("layout: projectslist")
      file.puts("title: #{title.gsub(/-/,' ')}")
      file.puts("date: #{date_hour}")
      file.puts("published: false")
      file.puts("---")
      puts "✔ Created successfully!".green
    end
  end
end
