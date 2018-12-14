require 'serverspec'

module Dockermaker
  module RSpecHelper
    def setup_image
      before(:all) do
        meta = Dockermaker.tasks[self.class.description]
        maker = Dockermaker::Maker.new(meta[:image_name],
                                       meta[:directory],
                                       meta[:version])
        image = Docker::Image.get(maker.name_with_tag)

        set :backend, :docker
        set :docker_image, image.id
      end

      after(:all) { Specinfra::Backend::Docker.clear }
    end
  end
end

RSpec.configure do |c|
  c.extend Dockermaker::RSpecHelper
end
