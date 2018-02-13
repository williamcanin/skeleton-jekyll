module DeployGithub

  include Variables
  include Utilities

  SITEDIR = "_site"

  # Method that adds git repo (if it does not exist)
  def add_repo_git(dir)
    if not Dir.exist?("#{dir}/.git")
      system_commands("git init #{dir}")
    end
  end

  # Method to pull project request if user wants
  def pull_execute(branch, dir)
    vConfig(CONFIG['configWebsite'])
    read_json(CONFIG['configWebsite'])
    pull = @parse_json_config['deploy']['github']['config']['pull']
    if pull == "yes"
      system_commands("cd #{dir}; git pull origin #{branch}")
    end
  end

  # Method to check if a given branch exists and enter or create the same.
  def git_checkout(setBranch, dir)
    getBranch = `cd #{dir}; git branch --list | sed -n "/#{setBranch}/p" | cut -d'*' -f2 | awk '{ gsub (" ", "", $0); print}'`
    if getBranch.nil? || getBranch.empty?
      system_commands("cd #{dir}; git checkout -b #{setBranch}")
    else
      system_commands("cd #{dir}; git checkout #{getBranch}")
    end
  end

  # Method that checks and adds or not the remote github url
  def add_remoteurl(dir)
    vConfig(CONFIG['configWebsite'])
    read_json(CONFIG['configWebsite'])
    remoteURL = @parse_json_config['deploy']['github']['config']['remoteURL']
    remoteVerify = `sed -n '/url/p' #{dir}/.git/config | cut -d'=' -f2 | cut -d' ' -f2`
    if remoteVerify.nil? || remoteVerify.empty?
      system_commands("cd #{dir}; git remote add origin #{remoteURL}")
    end
  end

  # Method that starts the deploy of the compiled project
  def deploySite
    verifyOS
    timeDate = Time.new
    vConfig(CONFIG['configWebsite'])
    read_json(CONFIG['configWebsite'])
    compileP = @parse_json_config['deploy']['compile']['built']
    branchBuilt = @parse_json_config['deploy']['branch']['built']
    msgCommit = @parse_json_config['deploy']['github']['config']['commit']
    if compileP == "yes"
      system_commands("rake build")
    end
    # enter_folder("./_site") # DEPRECATED
    add_repo_git(SITEDIR)
    add_remoteurl(SITEDIR)
    pull_execute(branchBuilt, SITEDIR)
    system_commands("echo Deploy source files. Wait ...")
    git_checkout(branchBuilt, SITEDIR)
    system_commands("cd #{SITEDIR}; git add .")
    system_commands("cd #{SITEDIR}; git commit -m \"#{msgCommit} - #{timeDate.inspect}\"")
    system_commands("cd #{SITEDIR}; git push origin -u #{branchBuilt}")

  end

  # Method that initiates deploy of project source code
  def deploySource
    verifyOS
    timeDate = Time.new
    vConfig(CONFIG['configWebsite'])
    read_json(CONFIG['configWebsite'])
    branchSource = @parse_json_config['deploy']['branch']['source']
    msgCommit = @parse_json_config['deploy']['github']['config']['commit']
    add_repo_git(".")
    add_remoteurl(".")
    pull_execute(branchSource, ".")
    git_checkout(branchSource, ".")
    system_commands("echo Deploy source files. Wait ...")
    system_commands("git add .")
    system_commands("git commit -m \"#{msgCommit} - #{timeDate.inspect}\"")
    system_commands("git push origin -u #{branchSource}")
  end

end
