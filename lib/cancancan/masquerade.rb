module CanCanCan
  module Masquerade

    # Override functionality from CanCan to allow objects to masquerade as other objects
    def extract_subjects(subject)
      return extract_subjects(subject.to_permission_instance) if subject.respond_to? :to_permission_instance

      return subject[:any] if subject.is_a? Hash and subject.key? :any

      [subject]
    end
  end
end

require 'cancancan/masquerade/inherit_permissions'
require 'cancancan/masquerade/version'
