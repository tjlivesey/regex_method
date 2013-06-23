# RegexMethod

Quickly define methods with regex method name matching without having to implement method_missing.

## Installation

Add this line to your application's Gemfile:

    gem 'regex_method'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install regex_method

## Usage

The module defines a class method `define_regex_method` that is used to define the matched methods. Simple example:

```ruby
class Addition
  include RegexMethod

  define_regex_method 'add_(\d*)_to_(\d*)' do |first_number, second_number|
    first_number.to_i + second_number.to_i
  end
end

Addition.new.add_4_to_5
=> 9
```

Note that because you cannot use `return` inside the defined method since we are in a Proc. If you want to be explicit the use `next`:

```ruby
class RegexMaths
  include RegexMethod

  define_regex_method 'add_(\d*)_to_(\d*)' do |first_number, second_number|
    return first_number.to_i + second_number.to_i
  end

  define_regex_method 'subtract_(\d*)_from_(\d*)' do |x, y|
    next y - x
  end
end

RegexMaths.new.add_4_to_5
=> LocalJumpError

RegexMaths.new.subtract_10_from_50
=> 40
```


