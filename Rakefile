require_relative 'versions'
require 'docker'

images = Rake::FileList['**/Dockerfile'].map { |file| File.dirname file }

Versions.repo = ENV['DOCKER_REPO']

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
      puts "Building #{image}"
      image_obj = Docker::Image.build_from_dir(Dir.pwd)
      image_obj.tag(repo: image, tag: Versions.tag(image))
    end
  end

  task "push:#{image}" do
    Versions.require_repo
    puts "Pushing #{image}"
    image_obj = Docker::Image.get(Versions.image(image))
    image_obj.tag(repo: "#{ENV['DOCKER_REPO']}/#{image}", tag: Versions.tag(image))
    image_obj.push(nil, repo_tag: Versions.full_image(image))
  end

  task image => ["build:#{image}", "test:#{image}"]
  task "deploy:#{image}" => [image, "push:#{image}"]

  task "check:#{image}" do
    Versions.require_repo
    image_name = Versions.full_image(image)
    begin
      Docker::Image.get(image_name)
      puts "#{image_name} present"
    rescue Docker::Error::NotFoundError
      puts "#{image_name} not present"
    end
  end
end

task build: images.map { |image| "build:#{image}" }
task test: images.map { |image| "test:#{image}" }
task push: images.map { |image| "push:#{image}" }
task deploy: images.map { |image| "deploy:#{image}" }

task default: :test
