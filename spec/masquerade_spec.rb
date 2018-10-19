RSpec.describe CanCanCan::Masquerade do
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

  class Inheritor
    extend CanCanCan::Masquerade::InheritPermissions

    inherit_permissions_from :permission

    def permission
      HasPermissions.new
    end
  end

  let(:ability) { Ability.new }
  let(:inheritor) { Inheritor.new }

  it 'overrides the `extract_subjects` method' do
    subject, = ability.extract_subjects(inheritor)

    expect(subject).to be_a HasPermissions
  end
end
