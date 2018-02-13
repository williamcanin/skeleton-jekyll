module Utilities

  # Method for reading the json file
  def read_json(filename)
    json_file_config = File.read("#{filename}")
    @parse_json_config = JSON.parse(json_file_config)
  end

  # Method for reading the yml file
  def read_yml_value(filename)
   YAML::load_file(File.join(filename))
  end

  # Commands system
  def system_commands(cmd)
    begin
      system(cmd)
    rescue Interrupt => e
      puts "\n⚠ Operation aborted!".yellow
    end
  end

  # Method for verify file exist
  def vConfig(vconfig)
    if not File.exist?(vconfig)
      puts "✖ [ERROR] The file '#{vconfig}' not exist. Aborted!".red
      exit
    end
  end

  # Method for enter any folder
  def enter_folder(folder)
    if Dir.exist?(folder)
      system("cd #{folder}")
    else
      puts "✖ [ERROR] Directory #{folder} not found!".red
      exit
    end
  end

  # Method for verify OS (Linux)
  def verifyOS
    @os = RbConfig::CONFIG['host_os']
    case
    when @os.downcase.include?('linux')
      @os = 'linux'
    when @os.downcase.include?('darwin')
      @os = 'darwin'
    else
      puts "✖ [ERROR] This function does not support this platform. \n  Mac OS X and Linux are the only supported platforms.".red
      exit
    end
  end


  # Method for print version
  def version
    puts "Script version: #{VERSION}".cyan
  end

  # Method for test
  def test_
    puts "Hey, little flower, you did an insignificant test.".cyan
  end

end
