module Versions
  TAG = {
    'rtorrent' => '0.1'
  }.freeze

  class << self
    def tag(name)
      TAG[name]
    end

    def image(name)
      name = "#{ENV['DOCKER_REPO']}/#{name}" unless ENV['DOCKER_REPO'].to_s.empty?
      name
    end

    def full_image(name)
      "#{image(name)}:#{tag(name)}"
    end
  end
end
