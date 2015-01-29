desc "Create symlinks to $HOME"
task :symlink do
  Dir.foreach(Dir.pwd) do |file|
    next unless file =~ /^\..{2,}/

    create_symlink(file)
  end
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
  elsif File.directory?(source)
    puts "#{error_message} - The file is a directory."
  else
    File.symlink(source, destination)
  end
end
