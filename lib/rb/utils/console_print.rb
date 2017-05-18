module ConsolePrint

  def console_header_print
@HEADER = <<ENDHEADER

| -------------------------------------------------------------------------|
|     Script version: v#{VERSION} -- Management Script for Jekyll Projects.     |
| -------------------------------------------------------------------------|

ENDHEADER
  end

  def console_content_print
    console_header_print

# Definition of outgoing messages on the console.
@USAGE = <<ENDUSAGE
Usage:
  bundle exec rake [options]

ENDUSAGE

@HELP = <<ENDHELP

Interaction:
Options           Action

  help            Show this help.
  version         Show the version number.
  credits         Credits for this script.

Management:
Options           Action

  install         Installs the project dependencies.
  build           Compile the project to deploy. Depends on installing the dependencies.
                  Edit the file 'url.json' to the url of your website.
  serve           Starts the server for project production in the browser.
  post:blog       Create the header for a new blog post.
  page:create     Create the header for a new page.
  post:project    Create the header for a new project.

ENDHELP

    puts @HEADER.black.on_green.blink; puts @USAGE; puts @HELP;
  end
end