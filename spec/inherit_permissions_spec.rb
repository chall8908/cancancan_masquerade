RSpec.describe CanCanCan::Masquerade::InheritPermissions do
  class HasPermissions
    def initialize(opts = {}); end
  end

  class Ability
    include CanCan::Ability
    include CanCanCan::Masquerade

    def initialize
      can :test, HasPermissions
    end
  end

  let(:ability) { Ability.new }

  it 'adds the to_permission_instance method' do
    test_obj = Class.new do
      extend CanCanCan::Masquerade::InheritPermissions

      inherit_permissions_from :@permission

      def initialize
        @permission = HasPermissions.new
      end
    end.new

    expect(test_obj).to respond_to :to_permission_instance
  end

  shared_context 'run test' do
    it 'gets the correct permission object' do
      permission_obj = test_obj.to_permission_instance
      expect(permission_obj).to be_a HasPermissions
    end

    it 'inherits the permissions of the object' do
      expect(ability).to be_able_to(:test, test_obj)
    end
  end

  describe 'Inheriting from an instance variable' do
    let(:test_obj) do
      Class.new do
        extend CanCanCan::Masquerade::InheritPermissions

        inherit_permissions_from :@permission

        def initialize
          @permission = HasPermissions.new
        end
      end.new
    end

    include_context 'run test'
  end

  describe 'Inheriting from an instance method' do
    let(:test_obj) do
      Class.new do
        extend CanCanCan::Masquerade::InheritPermissions

        inherit_permissions_from :permission

        def permission
          HasPermissions.new
        end
      end.new
    end

    include_context 'run test'
  end

  describe 'Inheriting by mapping' do
    let(:test_obj) do
      Class.new do
        extend CanCanCan::Masquerade::InheritPermissions

        inherit_permissions_from HasPermissions, mapping: {}
      end.new
    end

    include_context 'run test'
  end

  describe 'Inheriting via custom build' do
    let(:test_obj) do
      Class.new do
        extend CanCanCan::Masquerade::InheritPermissions

        build_permission_instance do
          HasPermissions.new
        end
      end.new
    end

    include_context 'run test'
  end
end
