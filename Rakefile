desc "Set up dotfiles"
task :setup do
  puts "  > Pulling latest changes..."
  `git pull &> /dev/null`

  puts " > Installed brew dependencies..."
  `brew tap Homebrew/brewdler`
  `brew brewdle`

  unless installed?("bundler")
    puts " > Installing Bundler..."
    `gem install bundler`
  end

  puts " > Installing gems..."
  `bundle install`

  puts " > Creating symlinks..."
  Rake::Task["symlink"].invoke

  puts " > Setting fish as default shell..."
  Rake::Task["shell"].invoke
end

desc "Create symlinks to $HOME"
task :symlink do
  Dir.foreach(Dir.pwd) do |file|
    next unless file =~ /^\..{2,}/

    create_symlink(file)
  end
end

desc "Sets fish as default shell"
task :shell do
  system('echo "/usr/local/bin/fish" | sudo tee -a /etc/shells')
  system('chsh -s /usr/local/bin/fish')
end

def file_exists_at(path)
  File.exist?(path) || File.symlink?(path)
end

def create_symlink(file)
  error_message = " > Warn: Skipping symlink to #{file}"
  source = File.expand_path(file)
  destination = "#{Dir.home}/#{file}"

  if file_exists_at(destination)
    puts "#{error_message} - The file already exists at the destination."
  elsif File.basename(source) == ".git"
    puts "#{error_message} - The file is a git directory."
  else
    File.symlink(source, destination)
  end
end

def installed?(command)
  system("which #{command} > /dev/null 2>&1")
end
