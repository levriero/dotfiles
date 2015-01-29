require 'fileutils'

task :create_symlinks do
  Dir.foreach(Dir.pwd) do |file|
    next unless file =~ /^\..{2,}/

    source = File.expand_path(file)
    destination = "#{Dir.home}/#{file}"

    if file_exists_at(destination)
      puts " > Warn: symlink to #{file} unsuccessful."\
      " The file already exists at the destination."
    else
      FileUtils.ln_s(source, destination)
    end
  end
end

def file_exists_at(path)
  File.exist?(path) || File.symlink?(path)
end
