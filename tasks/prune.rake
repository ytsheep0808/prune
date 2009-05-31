# coding:utf-8

base_dir = File.expand_path(File.join(File.dirname(__FILE__), ".."))

namespace :prune do
  desc "Update manifest file for prune"
  task :manifest do
    # get all files under base directory
    Dir.chdir(base_dir)
    paths = Dir.glob("**/*")
    # delete directory path
    paths.delete_if do |path|
      File.directory?(path)
    end
    # delete excluded patterns
    exclude_patterns = [
      /\Apkg/,
      /\Adoc/,
      /\A\.git/,
      /\Anbproject/,
      /\.pdf\z/
    ]
    paths.delete_if do |path|
      exclude_patterns.any? do |pattern|
        pattern === path
      end
    end
    # write to manifest file
    File.open("Manifest.txt", "w") do |file|
      paths.sort.each do |path|
        puts "  %s" % path
        file.puts path
      end
    end
    puts "Manifest.txt updated."
  end
end
