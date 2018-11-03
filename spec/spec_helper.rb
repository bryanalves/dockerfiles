require 'docker'
require 'serverspec'
require_relative '../maker'

def setup_image
  before(:all) do
    image = Docker::Image.get(Maker.new(self.class.description).name_with_tag)

    set :backend, :docker
    set :docker_image, image.id
  end

  after(:all) { Specinfra::Backend::Docker.clear }
end
