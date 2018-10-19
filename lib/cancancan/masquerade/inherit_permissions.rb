module CanCanCan
  module Masquerade
    module InheritPermissions
      protected

      def inherit_permissions_from(record, mapping: nil)
        case record
        when /^@/   then permissions_from_instance_variable(record)
        when Symbol then permissions_from_method(record)
        when Class  then permissions_from_constructed_class(record, mapping)
        else
          raise InvalidPermissionConfiguration, "Invalid record type: #{record.class}.  Expecting Symbol or Class."
        end
      end

      def build_permission_instance(&block)
        define_method(:to_permission_instance, &block)
      end

      private

      def permissions_from_instance_variable(variable)
        build_permission_instance { instance_variable_get(variable) }
      end

      def permissions_from_method(method)
        build_permission_instance { send(method) }
      end

      def permissions_from_constructed_class(class_to_build, mapping)
        unless mapping.is_a?(Hash)
          raise InvalidPermissionConfiguration, 'Must supply a `mapping:` when building from a Class'
        end

        build_permission_instance do
          values = mapping.reduce({}) do |final, (key, value)|
            mapped_value = if value.is_a? Symbol and respond_to? value
                             send value
                           elsif value.is_a? Symbol and instance_variable_defined? value
                             instance_variable_get value
                           else
                             value
                           end

            final.merge(key => mapped_value)
          end

          class_to_build.new(values)
        end
      end

      class InvalidPermissionConfiguration < StandardError; end
    end
  end
end
