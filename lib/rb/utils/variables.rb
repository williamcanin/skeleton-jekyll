# Module to set global variables
module Variables

  SOURCE = "."
  CONFIG = {
    'postsDirBlog' => File.join(SOURCE, "_posts/_blog"),
    'pagesDir' => File.join(SOURCE, "_pages"),
    'projectsDir' => File.join(SOURCE, "_projects"),
    'markdown_ext' => "md"
  }

end # End module 'Variables'