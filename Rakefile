require_relative 'versions'
require 'docker'

dockerdirs = Rake::FileList['**/Dockerfile'].map { |fl| File.dirname fl }

dockerdirs.each do |dir|
  task "test:#{dir}" do
    if !Dir.exist?("spec/#{dir}")
      puts "Skipping non-existent tests for #{dir}"
    else
      sh "rspec spec/#{dir}"
    end
  end

  task "build:#{dir}" do |_t|
    Dir.chdir(dir) do
      puts "\n\nBuilding #{dir}"
      image = Docker::Image.build_from_dir(Dir.pwd)
      image.tag(repo: Versions.image(dir), tag: Versions.tag(dir))
      puts "\n\n"
    end
  end

  task dir => ["build:#{dir}", "test:#{dir}"]
end

task build_all: dockerdirs.map { |dir| "build:#{dir}" }
task test_all: dockerdirs.map { |dir| "test:#{dir}" }
task all: dockerdirs

task deploy: [:spec] do
end

task :clean do
end

task default: :all
