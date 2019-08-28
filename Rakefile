require 'yaml'

data = YAML.load_file('build.yaml')

builds = data['builds']
DEFAULT_REGISTRIES = data['default_registries']
REGISTRIES = data['registries']

class Builder
  def initialize(target, opts, stage)
    @target = target
    @version = stage == 'dev' ? 'dev' : opts['version']
    @public_enabled = opts['public_enabled']
    @stage = stage
  end

  def run
    skip_if_unallowed_public
    if should_build?
      puts "Skipping #{remote}, already exists"
    else
      buildah "bud -t localbuild #{@target}"
      buildah "push localbuild:latest #{remote}"

      buildah 'rmi localbuild'
      buildah 'rmi -p'
    end
  end

  private

  def skip_if_unallowed_public
    raise 'Unable to push to public' if @stage == 'public' && !@public_enabled
  end

  def should_build?
    image_exists?(remote) && (@stage != 'dev')
  end

  def registry
    return @registry if @registry

    registry_name = DEFAULT_REGISTRIES[@stage]
    @registry = REGISTRIES[registry_name]
  end

  def remote
    @remote ||= "#{registry['uri']}/#{image}"
  end

  def image
    "#{@target}:#{@version}"
  end

  def buildah(cmd)
    `buildah #{cmd}`
  end

  def image_exists?(path)
    system("skopeo inspect #{path} > /dev/null 2>&1")
  end
end

builds.each do |target, opts|
  task target, :stage do |_t, args|
    stage = args[:stage] || 'dev'
    Builder.new(target, opts, stage).run
  end
end
