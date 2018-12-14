require 'dockermaker'
require_relative 'define_tasks'

Dockermaker.logger = Logger.new(STDOUT)
Dockermaker.logger.level = Logger::INFO

Dockermaker.load_tasks

task default: :test
