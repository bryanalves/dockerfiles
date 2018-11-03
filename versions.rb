module Versions
  TAG = {
    'rtorrent' => '0.1'
  }.freeze

  class << self
    def tag(name)
      TAG[name] || 'latest'
    end

    def image(name)
      "#{name}:#{tag(name)}"
    end

    def full_image(repo, name)
      "#{repo}/#{image(name)}"
    end
  end
end
