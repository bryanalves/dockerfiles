require 'spec_helper'

describe 'rtorrent' do
  setup_image

  it 'installs required packages' do
    expect(package('rtorrent')).to be_installed
  end
end
