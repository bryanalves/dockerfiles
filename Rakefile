require_relative 'maker'
require 'docker'

images = Rake::FileList['**/Dockerfile'].map { |file| File.dirname file }

logger = Logger.new(STDOUT)
logger.level = Logger::INFO

Maker.repo = ENV['DOCKER_REPO']
Maker.logger = logger

images.each do |image|
  task "test:#{image}" => "build:#{image}" do
    if !Dir.exist?("spec/#{image}")
      logger.warn "Skipping non-existent tests for #{image}"
    else
      sh "rspec --format documentation spec/#{image}"
    end
  end

  task "build:#{image}" do
    Maker.new(image).build
  end

  task "push:#{image}" do
    Maker.new(image).push
  end

  task image => ["build:#{image}", "test:#{image}"]
  task "deploy:#{image}" => [image, "push:#{image}"]

  task "check:#{image}" do
    present = Maker.new(image).in_repo?
    if present
      logger.info "#{Maker.new(image).full_name} present"
    else
      logger.info "#{Maker.new(image).full_name} not present"
    end
  end
end

task build: images.map { |image| "build:#{image}" }
task test: images.map { |image| "test:#{image}" }
task push: images.map { |image| "push:#{image}" }
task deploy: images.map { |image| "deploy:#{image}" }

task default: :test
