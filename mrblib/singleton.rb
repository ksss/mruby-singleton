# Singleton module
# This code is based on https://github.com/ruby/ruby/blob/trunk/lib/singleton.rb
#
# The Singleton module implements the Singleton pattern.
#
# == Usage
#
# To use Singleton, include the module in your class.
#
#    class Klass
#       include Singleton
#       # ...
#    end
#
# This ensures that only one instance of Klass can be created.
#
#      a,b  = Klass.instance, Klass.instance
#
#      a == b
#      # => true
#
# The instance is created at upon the first call of Klass.instance().
#
#      class OtherKlass
#        include Singleton
#        # ...
#      end
#
#      ObjectSpace.each_object(OtherKlass){}
#      # => 0
#
#      OtherKlass.instance
#      ObjectSpace.each_object(OtherKlass){}
#      # => 1
#
#
# This behavior is preserved under inheritance and cloning.
#
module Singleton
  def clone
    raise TypeError, "can't clone instance of singleton #{self.class}"
  end

  def dup
    raise TypeError, "can't clone instance of singleton #{self.class}"
  end

  module SingletonClassMethods
  end

  class << Singleton
    def __init__ klass
      klass.instance_eval {
        @singleton__instance__ = nil
      }
      def klass.instance
        return @singleton__instance__ if @singleton__instance__
        @singleton__instance__ = new
      end
      klass
    end

    undef_method :extend_object

    def append_features mod
      unless mod.instance_of? Class
        raise TypeError, "Inclusion of the OO-Singleton module in module #{mod}"
      end
      super
    end

    def included klass
      super
      klass.extend SingletonClassMethods
      Singleton.__init__ klass
    end
  end
end
