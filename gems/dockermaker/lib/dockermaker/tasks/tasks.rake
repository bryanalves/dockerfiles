Dockermaker.tasks.each do |taskname, meta|
  task "test:#{taskname}" => "build:#{taskname}" do
    if Dir.exist?("spec/#{meta[:directory]}")
      sh "rspec --format documentation spec/#{meta[:directory]}"
    else
      Dockermaker.logger.warn "Skipping non-existent tests for #{image}"
    end
  end

  task "build:#{taskname}" do
    Dockermaker.logger.info "Building #{meta[:image_name]}"
    Dockermaker::Maker.new(meta[:image_name],
                           meta[:directory],
                           meta[:version]).build
  end

  task "push:#{taskname}" do
    maker = Dockermaker::Maker.new(meta[:image_name],
                                   meta[:directory],
                                   meta[:version])
    meta[:repos].each do |repo|
      unless maker.in_repo?(repo)
        Dockermaker.logger.info "Pushing #{maker.full_name(repo)}"
        maker.push(repo)
        next
      end

      if %w[1 true].include? ENV['FORCE_PUSH']
        Dockermaker.logger.warn "Force pushing #{maker.full_name(repo)}"
        maker.push(repo)
      else
        Dockermaker.logger.info "Skipping #{maker.full_name(repo)}, already exists"
      end
    end
  end

  task taskname => ["build:#{taskname}", "test:#{taskname}"]
  task "deploy:#{taskname}" => [taskname, "push:#{taskname}"]

  task "check:#{taskname}" do
    maker = Dockermaker::Maker.new(meta[:image_name],
                                   meta[:directory],
                                   meta[:version])
    meta[:repos].each do |repo|
      if maker.in_repo?(repo)
        Dockermaker.logger.info "#{maker.full_name(repo)} present"
      else
        Dockermaker.logger.info "#{maker.full_name(repo)} not present"
      end
    end
  end

  task build: "build:#{taskname}"
  task test: "test:#{taskname}"
  task push: "push:#{taskname}"
  task deploy: "deploy:#{taskname}"
  task check: "check:#{taskname}"
end
