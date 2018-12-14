require 'dockermaker/version'
require 'dockermaker/maker'
require 'docker_registry2'
require 'docker'

module Dockermaker
  @tasks_loaded = false
  @tasks = {}
  @registry_auths = {}

  class << self
    attr_accessor :logger
    attr_reader :tasks
    attr_reader :registry_auths

    def add_task(task_name, repos:, version:, directory: nil, image_name: nil)
      @tasks[task_name] = {
        directory: directory || task_name,
        image_name: image_name || task_name,
        repos: Array(repos),
        version: version
      }
    end

    def add_auth(repo_name, user:, password:)
      @registry_auths[repo_name] = {
        user: user,
        password: password
      }
    end

    def load_tasks
      raise 'Can only load Dockermaker tasks once' if @tasks_loaded

      @tasks_loaded = true

      load 'dockermaker/tasks/tasks.rake'
    end
  end
end
