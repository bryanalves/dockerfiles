module Dockermaker
  class Maker
    attr_reader :name
    attr_reader :directory
    attr_reader :tag

    def initialize(name, directory, tag)
      @name = name
      @directory = directory
      @tag = tag
    end

    def build
      Dir.chdir(directory) do
        image_obj = Docker::Image.build_from_dir(Dir.pwd)
        image_obj.tag(repo: name, tag: tag)
      end
    end

    def push(repo)
      image_obj = Docker::Image.get(name_with_tag)
      image_obj.tag(repo: "#{repo}/#{name}", tag: tag)
      image_obj.push(auth_for_push(repo), repo_tag: full_name(repo))
    end

    def in_repo?(repo)
      reg = DockerRegistry2.connect("https://#{repo}", auth_for_check(repo))
      begin
        (reg.tags(name)['tags'] || []).include? tag
      rescue DockerRegistry2::NotFound
        false
      end
    end

    def full_name(repo)
      "#{repo}/#{name_with_tag}"
    end

    def name_with_tag
      "#{name}:#{tag}"
    end

    private

    def auth_for_push(repo)
      registry_auth = Dockermaker.registry_auths[repo]
      if registry_auth
        { username: registry_auth[:user], password: registry_auth[:password], }
      end
    end

    def auth_for_check(repo)
      registry_auth = Dockermaker.registry_auths[repo]
      if registry_auth
        { user: registry_auth[:user], password: registry_auth[:password], }
      else
        {}
      end
    end
  end
end
