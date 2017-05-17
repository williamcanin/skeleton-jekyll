module HeaderProject
  def create_header_pr(filename, title_project, date_hour)
    open(filename, 'w') do |file|
      file.puts("---")
      file.puts("layout: projectslist")
      file.puts("title: #{title_project.gsub(/-/,' ')}")
      file.puts("date: #{date_hour}")
      file.puts("published: false")
      file.puts("")
      file.puts("# Do not change the permalink setting")
      file.puts("permalink: /projects/")
      file.puts("---")
      puts "Created successfully!"
    end
  end
end
