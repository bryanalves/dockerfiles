require_relative 'versions'
require 'docker'

images = Rake::FileList['**/Dockerfile'].map { |file| File.dirname file }

logger = Logger.new(STDOUT)
logger.level = Logger::INFO

Versions.repo = ENV['DOCKER_REPO']
Versions.logger = logger

images.each do |image|
  task "test:#{image}" => "build:#{image}" do
    if !Dir.exist?("spec/#{image}")
      logger.warn "Skipping non-existent tests for #{image}"
    else
      sh "rspec --format documentation spec/#{image}"
    end
  end

  task "build:#{image}" do
    Versions.build(image)
  end

  task "push:#{image}" do
    Versions.push(image)
  end

  task image => ["build:#{image}", "test:#{image}"]
  task "deploy:#{image}" => [image, "push:#{image}"]

  task "check:#{image}" do
    Versions.require_repo
    image_name = Versions.full_image(image)
    begin
      Docker::Image.get(image_name)
      logger.info "#{image_name} present"
    rescue Docker::Error::NotFoundError
      logger.info "#{image_name} not present"
    end
  end
end

task build: images.map { |image| "build:#{image}" }
task test: images.map { |image| "test:#{image}" }
task push: images.map { |image| "push:#{image}" }
task deploy: images.map { |image| "deploy:#{image}" }

task default: :test
