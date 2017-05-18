# File: Rakefile
# Language: RakeFile
# Country/State: Brazil/SP
# Author : William C. Canin <http://williamcanin.github.com>
# Page author: http://williamcanin.com

require "./lib/rb/utils/version.rb"
require "./lib/rb/utils/variables.rb"
require "./lib/rb/utils/header_pr.rb"
require "./lib/rb/utils/header_pa.rb"
require "./lib/rb/utils/header_po.rb"
require "./lib/rb/utils/credits.rb"
require "./lib/rb/utils/console_print.rb"
require './lib/rb/main.rb'



# Instantiating class main
main = Main.new

# Commands for managing Gulp and creating markdown file.
#
# Task create header Post
desc "Create new header post"
namespace :post do
  task :blog do
    main.post_create('postsDirBlog')
  end
end

# Task create header Page
desc "Create new header page"
namespace :page do
  task :create do
    main.page_create('pagesDir')
  end
end

# Task create header Project
desc "Create new header project"
namespace :post do
  task :project do
    main.project_create('projectsDir')
  end
end

# Changes the url for production, that is, when starting the server.
# Note: This task is used for Gulp and not for individual execution.
desc "Changes the url for production, that is, when starting the server."
task :url_serve  do
  main.url_serve
end

# Change the url to build, that is, to perform deploy on the hosting server.
# Note: This task is used for Gulp and not for individual execution.
desc "Change the url to build, that is, to perform deploy on the hosting server."
task :url_build  do
  main.url_build
end
#
#  ---------------------------------------------------------------------------------------




# Commands for server installation, compilation, startup and version.
#
# Usage: bundle exec rake [ [install | build | serve ] ]
desc "Install dependencies"
task :install  do
  main.install
end

desc "Build project"
task :build  do
  main.system_commands("$(npm bin)/gulp build")
end

desc "Start server"
task :serve  do
  main.system_commands("$(npm bin)/gulp serve")
end
#
# ------------------------------------------------------------


# Interaction Tasks
#
# Task put version
desc "Task put version"
task :version  do
  main.version
end

# Task credits
desc "Task credits"
task :credits  do
  main.credits_start
end

# Task credits
desc "Task help commands"
task :help  do
  main.console_header_print
  main.console_content_print
end

# Task test
desc "Task test"
task :test  do
  main.test_
end
#
# -----------------------------------------------------------





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

# Utils
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
