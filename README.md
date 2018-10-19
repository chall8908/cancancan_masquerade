# CanCanCan::Masquerade

Put on a mask and pretend!  CanCanCan::Masquerade allows your objects to pretend
to be other objects when checking permissions.

This gem was originally designed with the goal of allowing ViewModels to act as
Models in a Ruby on Rails application.  The implementation is simple enough that
it can be applied to pretty much any object you like.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cancancan_masquerade'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cancancan_masquerade

## Usage

Include Masquerade in your ability class!

```ruby
class Ability
  include CanCan::Ability
  include CanCanCan::Masquerade

  # ... your permissions, as usual
end
```

From here, we're operating on other objects in your project.  Only that one
modification needs to be made to your ability class for this to work.

### Inheriting from an instance variable

If the object you'd like to masquerade as is an instance variable of the current
object, simply specify it as a symbol (similar to delegating to an instance
variable in Rails):

```ruby
class MaskedDancer
  extend CanCanCan::Masquerade::InheritPermissions

  inherit_permissions_from :@dancer

  # ... rest of your class
end
```

### Inheriting from a method

If the object you'd like to masquerade as can be accessed via a property of the
current object, pass the name of the method as a symbol:

```ruby
class MaskedDancer
  extend CanCanCan::Masquerade::InheritPermissions

  inherit_permissions_from :partner

  # ... rest of your class
end
```

### Inheriting by building another object

If neither of the above work and the current object can be mapped into the object
you wish to pretend to be, you can specify the class name and the mapping directly:

```ruby
class MaskedDancer
  extend CanCanCan::Masquerade::InheritPermissions

  inherit_permissions_from Dancer,
                           mapping: { name: :@name,
                                      type: :type
                                    }

  # ... rest of your class
end
```

_The mapping must be a hash!_  Values that are symbols will be checked against
defined methods and instance variables for mapping.  If neither match or the
value is not a symbol, it will be passed as is.

### Complex build process

If the new object can't be built using one of these methods, you can pass a block
that will be called when the object is needed for checking permissions:

```ruby
class MaskedDancer
  extend CanCanCan::Masquerade::InheritPermissions

  build_permission_instance do
    # build your permission object here
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push git
commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/chall8908/cancancan_masquerade.
This project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org)
code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CancancanMasquerade project’s codebases, issue trackers,
chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/cancancan_masquerade/blob/master/CODE_OF_CONDUCT.md).
