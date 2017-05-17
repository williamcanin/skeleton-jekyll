# File: Rakefile
# Language: RakeFile
# Country/State: Brazil/SP
# Author : William C. Canin <http://williamcanin.github.com>
# Page author: http://williamcanin.com
# Description: Task creation file for the 'config.rb' file.

require './lib/rb/commands.rb'

# Task create header Post
# Example: bundle exec rake post:blog TITLE="First post"
# Note: TITLE is Required
desc "Create new header post"
namespace :post do
  task :blog do
    main = Main.new
    main.post_create('postsDirBlog')
  end
end

# Task create header Page
# Example: bundle exec rake page:create TITLE="About" LAYOUT="page"
# Note: TITLE and LAYOUT is Required
desc "Create new header page"
namespace :page do
  task :create do
    main = Main.new
    main.page_create('pagesDir')
  end
end

# Task create header Project
# Example: bundle exec rake post:project TITLE="First project"
# Note: TITLE is Required
desc "Create new header project"
namespace :post do
  task :project do
    main = Main.new
    main.project_create('projectsDir')
  end
end

# Changes the url for production, that is, when starting the server.
# Note: This task is used for Gulp and not for individual execution.
desc "Changes the url for production, that is, when starting the server."
task :url_serve  do
  main = Main.new
  main.url_serve
end

# Change the url to build, that is, to perform deploy on the hosting server.
# Note: This task is used for Gulp and not for individual execution.
desc "Change the url to build, that is, to perform deploy on the hosting server."
task :url_build  do
  main = Main.new
  main.url_build
end


# Commands console for management.
# Usage: bundle exec rake [ [install | build | serve | post:blog | page:create | post:project] ]
desc "Install dependencies"
task :install  do
  system("gem install bundle")
  system("bundle install")
  p "Finished installation process!"
end

desc "Start server"
task :serve  do
  main = Main.new
  main.system_commands("$(npm bin)/gulp serve")
end

desc "Build project"
task :build  do
  main = Main.new
  main.system_commands("$(npm bin)/gulp build")
end


# Task to turn the presentation page on and off. [DEPRECATED]
# Example1: bundle exec rake hello:true
# Example2: bundle exec rake hello:false
# desc "Disable/Enable presentation page"
# namespace :hello do
#   task :true do
#     main = Main.new
#     main.hello_page(true)
#   end
#   task :false do
#     main = Main.new
#     main.hello_page(false)
#   end
# end

# Util configuration
def ask(message, valid_options)
  if valid_options
    answer = get_stdin("#{message} #{valid_options.to_s.gsub(/"/, '').gsub(/, /,'/')} ") while !valid_options.include?(answer)
  else
    answer = get_stdin(message)
  end
  answer
end

def get_stdin(message)
  print message
  STDIN.gets.chomp
end
