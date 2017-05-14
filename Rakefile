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
desc "Create new post"
namespace :post do
  task :blog do
    main = Main.new
    main.post_create('postsDirBlog')
  end
end

# Task create header Page
# Example: bundle exec rake page:create TITLE="About" LAYOUT="page"
# Note: TITLE and LAYOUT is Required
desc "Create new page"
namespace :page do
  task :create do
    main = Main.new
    main.page_create('pagesDir')
  end
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
