module AdminInvitable
  class Engine < ::Rails::Engine
    isolate_namespace AdminInvitable

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end

    initializer "ativeadmin_invitable_patch" do |app|
      require_relative "activeadmin_invitable_patch"
    end
  end
end
