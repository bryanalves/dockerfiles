require 'test_helper'

class DockermakerTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Dockermaker::VERSION
  end
end
