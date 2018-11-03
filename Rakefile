require_relative 'versions'
require 'docker'

dockerdirs = Rake::FileList['**/Dockerfile'].map { |fl| File.dirname fl }

dockerdirs.each do |dir|
  task "test:#{dir}" => "build:#{dir}" do
    if !Dir.exist?("spec/#{dir}")
      puts "Skipping non-existent tests for #{dir}"
    else
      sh "rspec spec/#{dir}"
    end
  end

  task "build:#{dir}" do
    Dir.chdir(dir) do
      puts "\n\nBuilding #{dir}"
      image = Docker::Image.build_from_dir(Dir.pwd)
      image.tag(repo: dir, tag: Versions.tag(dir))
      puts "\n\n"
    end
  end

  task "push:#{dir}" do
    raise 'Specify repo via DOCKER_REPO environment variable' unless ENV['DOCKER_REPO']
    image = Docker::Image.get(Versions.image(dir))
    image.tag(repo: "#{ENV['DOCKER_REPO']}/#{dir}", tag: Versions.tag(dir))
    image.push(nil, repo_tag: Versions.full_image(ENV['DOCKER_REPO'], dir))
  end

  task dir => ["build:#{dir}", "test:#{dir}"]
  task "deploy:#{dir}" => [dir, "push:#{dir}"]
end

task build: dockerdirs.map { |dir| "build:#{dir}" }
task test: dockerdirs.map { |dir| "test:#{dir}" }
task push: dockerdirs.map { |dir| "push:#{dir}" }
task deploy: dockerdirs.map { |dir| "deploy:#{dir}" }

task default: :test
