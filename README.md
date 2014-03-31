# mruby-singleton

Singleton module in mruby.

```ruby
class Example
  include Singleton
  attr_accessor :keep
end

a = Example.instance
b = Example.instance
a.keep = "keep this"
p b.keep #=> "keep this"
a.keep = nil
p b.keep #=> nil
```

## Installation

### use github repository

Write in /mruby/build_config.rb

```ruby
MRuby::Build.new do |conf|
  conf.gem :github => 'ksss/mruby-singleton', :branch => 'master'
end
```

### or use mgem

```
mgem add mruby-singleton
```

### build

and exec in your /mruby.

```
rake clean
rake
rake test
```

## License

MIT
