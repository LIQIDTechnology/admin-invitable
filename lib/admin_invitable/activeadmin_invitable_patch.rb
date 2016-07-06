module ::ActiveAdmin
  module Devise
    class << self
      alias_method :old_controllers, :controllers
      def controllers
        old_controllers.merge({invitations: "active_admin/devise/invitations"})
      end
      alias_method :old_controllers_for_filters, :controllers_for_filters
      def controllers_for_filters
        old_controllers_for_filters + [InvitationsController]
      end
    end
    class InvitationsController < ::Devise::InvitationsController
      include ::ActiveAdmin::Devise::Controller
      include ::ActiveAdmin::BaseController::Authorization

      def new
        authorize!(:invite, resource_class)
        super
      end

      def create
        authorize!(:invite, resource_class)
        super
      end

      protected

      def active_admin_namespace
        ActiveAdmin.application.namespaces[ActiveAdmin.application.default_namespace]
      end

      def active_admin_config
        active_admin_namespace.resource_for(resource_class)
      end

      def current_active_admin_user
        current_inviter
      end
    end
  end
end
