# Method visibility
# A public method can be invoked from anywhere
# there are no restrictions to its use

# A private method is internal to the implementation of a class
# Implicity invoked on self

# Protected methods may be invoked from within the implementation
# of a class and its subclass
# Can be invoked on any instance of a class

class Obj
  # Public methods go here

  # The following methods are protected
  protected

  def some_protected_method
  end

  # The follwing methods are private
  private

  def some_private_method
  end
end

# Can also be defined as follows
class Obj2
  def some_protected_method; end
  # Declared protected here...
  protected :some_protected_method

  def some_private_method; end
  # Declared private here...
  private :some_private_method
end

# Public, private and protected only apply to methods
# Instance/class variables are private
# Constants are global

# You can also declare class methods as public or private
class FactoryObject
  def initialize(factory_name)
    @factory_name = factory_name
  end

  def name
    @factory_name
  end

  def some_private_method
    puts @factory_name.upcase.reverse
  end
  private :some_private_method
	
  # Note we don't we don't want this method exposed
  def self.new(factory_name)
    # Imagine some important processing here...
    super
  end
  # Therefore we add this...
  private_class_method :new

  def self.create
    new "Dennis"
  end
end

# Note now new is not exposed
puts FactoryObject.method_defined? :new # => false
# But create is
f = FactoryObject.create
puts f.name

# But wait you can invoked private methods with send method
f2 = FactoryObject.send :new, "Matt"
puts f2.name

# You can also invoke them this way
f2.instance_eval { some_private_method } # => TTAM
# Even instance variables???
puts f2.instance_eval { @factory_name } # => Matt

# If you want to use send but not accidentally invoke a private method
# use public send
begin
  FactoryObject.public_send :new 
rescue
  puts "Look this caused an error!"
end












