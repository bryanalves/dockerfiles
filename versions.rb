module Versions
  TAG = {
    'rtorrent' => '0.1'
  }.freeze

  class << self
    attr_accessor :repo

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
      raise 'Specify repo via DOCKER_REPO environment variable' unless repo.present?
    end
  end
end
