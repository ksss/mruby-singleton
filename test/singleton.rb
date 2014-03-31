assert 'Singleton' do
  s = Class.new{ include Singleton }
  assert_include s, Singleton
end

assert 'Singleton instance never change' do
  s = Class.new{ include Singleton }
  a = s.instance
  b = s.instance
  assert_equal(a.object_id, b.object_id)
end

assert 'clone raise exception' do
  assert_raise TypeError do
    s = Class.new{ include Singleton }
    s.instance.clone
  end
end

assert 'dup raise exception' do
  assert_raise TypeError do
    s = Class.new{ include Singleton }
    s.instance.dup
  end
end

assert 'include in module raise exception' do
  assert_raise TypeError do
    Module.new.class_eval do
      include Singleton
    end
  end
end

assert 'extending singleton raise exception' do
  assert_raise NoMethodError do
    'foo'.extend Singleton
  end
end

assert 'inheritance works with overriden inherited method' do
  super_super_called = false

  outer = Class.new do
    define_singleton_method :inherited do |sub|
      super_super_called = true
    end
  end

  inner = Class.new(outer) do
    include Singleton
  end

  tester = Class.new(inner)

  assert_true super_super_called

  a = tester.instance
  b = tester.instance
  assert_equal a.object_id, b.object_id
end

assert 'class level cloning preserves singleton behavior' do
  klass = Class.new{ include Singleton }.clone

  a = klass.instance
  b = klass.instance
  assert_equal a.object_id, b.object_id
end
