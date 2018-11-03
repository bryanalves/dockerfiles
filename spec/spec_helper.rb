require 'docker'
require 'serverspec'
require_relative '../versions'

def setup_image
  before(:all) do
    image = Docker::Image.get(Versions.image(self.class.description))

    set :backend, :docker
    set :docker_image, image.id
  end

  after(:all) { Specinfra::Backend::Docker.clear }
end
