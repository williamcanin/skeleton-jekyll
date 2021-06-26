# Module to set global variables
module Variables

  SOURCE = "."
  CONFIG = {
    'manager' => "yarn",
    'postsDirBlog' => File.join(SOURCE, "_posts"),
    'pagesDir' => File.join(SOURCE, "_pages"),
    'projectsDir' => File.join(SOURCE, "_projects"),
    'configWebsite' => File.join(SOURCE, "config/config.json"),
    'gulpConfig' => File.join(SOURCE, "lib/json/gulp.json"),
    'configYML' => File.join(SOURCE, "_config.yml"),
    'markdown_ext' => "md"
  }

end # End module 'Variables'
