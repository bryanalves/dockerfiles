class Versions
  TAG = {
    'rtorrent' => '0.1'
  }.freeze

  attr_reader :name

  class << self
    attr_accessor :repo
    attr_accessor :logger

    def require_repo
      raise 'Specify repo via DOCKER_REPO environment variable' if repo.to_s.empty?
    end
  end

  def initialize(name)
    @name = name
  end

  module Actions
    def build
      Dir.chdir(name) do
        logger.info "Building #{name}"
        image_obj = Docker::Image.build_from_dir(Dir.pwd)
        image_obj.tag(repo: name, tag: tag)
      end
    end

    def push
      Versions.require_repo

      logger.info "Pushing #{name}"
      image_obj = Docker::Image.get(name_with_tag)
      image_obj.tag(repo: "#{repo}/#{name}", tag: tag)
      image_obj.push(nil, repo_tag: full_name)
    end
  end

  include Actions

  def in_repo?
    Versions.require_repo
    begin
      Docker::Image.get(full_name)
      true
    rescue Docker::Error::NotFoundError
      false
    end
  end

  def full_name
    Versions.require_repo
    "#{repo}/#{name_with_tag}"
  end

  def name_with_tag
    "#{name}:#{tag}"
  end

  private

  def tag
    Versions::TAG[name] || 'latest'
  end

  def logger
    Versions.logger
  end

  def repo
    Versions.repo
  end
end
