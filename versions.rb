module Versions
  TAG = {
    'rtorrent' => '0.1'
  }.freeze

  class << self
    attr_accessor :repo
    attr_accessor :logger

    def build(name)
      Dir.chdir(name) do
        logger.info "Building #{name}"
        image_obj = Docker::Image.build_from_dir(Dir.pwd)
        image_obj.tag(repo: name, tag: Versions.tag(name))
      end
    end

    def present?(name)
      require_repo
      image_name = Versions.full_image(name)
      begin
        Docker::Image.get(image_name)
        true
      rescue Docker::Error::NotFoundError
        false
      end
    end

    def push(name)
      require_repo
      logger.info "Pushing #{name}"
      image_obj = Docker::Image.get(Versions.image(name))
      image_obj.tag(repo: "#{repo}/#{name}", tag: Versions.tag(name))
      image_obj.push(nil, repo_tag: Versions.full_image(name))
    end

    def tag(name)
      TAG[name] || 'latest'
    end

    def image(name)
      "#{name}:#{tag(name)}"
    end

    def full_image(name)
      require_repo
      "#{repo}/#{image(name)}"
    end

    def require_repo
      raise 'Specify repo via DOCKER_REPO environment variable' if repo.to_s.empty?
    end
  end
end
