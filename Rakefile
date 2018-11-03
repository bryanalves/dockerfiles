require_relative 'versions'
require 'docker'

images = Rake::FileList['**/Dockerfile'].map { |file| File.dirname file }

images.each do |image|
  task "test:#{image}" => "build:#{image}" do
    if !Dir.exist?("spec/#{image}")
      puts "Skipping non-existent tests for #{image}"
    else
      sh "rspec --format documentation spec/#{image}"
    end
  end

  task "build:#{image}" do
    Dir.chdir(image) do
      puts "\n\nBuilding #{image}"
      image_obj = Docker::Image.build_from_dir(Dir.pwd)
      image_obj.tag(repo: image, tag: Versions.tag(image))
      puts "\n\n"
    end
  end

  task "push:#{image}" do
    raise 'Specify repo via DOCKER_REPO environment variable' unless ENV['DOCKER_REPO']
    image_obj = Docker::Image.get(Versions.image(image))
    image_obj.tag(repo: "#{ENV['DOCKER_REPO']}/#{image}", tag: Versions.tag(image))
    image_obj.push(nil, repo_tag: Versions.full_image(ENV['DOCKER_REPO'], image))
  end

  task image => ["build:#{image}", "test:#{image}"]
  task "deploy:#{image}" => [image, "push:#{image}"]
end

task build: images.map { |image| "build:#{image}" }
task test: images.map { |image| "test:#{image}" }
task push: images.map { |image| "push:#{image}" }
task deploy: images.map { |image| "deploy:#{image}" }

task default: :test
