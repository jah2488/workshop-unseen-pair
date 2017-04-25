class Maybe
  include Comparable

  private
  attr_writer :value

  public
  attr_reader :value

  def initialize(value = nil, aliases_allowed = case ENV["ALIASES_ALLOWED"]
                                                when "true"  then true
                                                when "maybe" then "maybe"
                                                else; false
                                                end)
    self.value = value

    if aliases_allowed != false || aliases_allowed == "maybe"
      Maybe.class_exec do
        alias_method :then, :map
      end
    end

    unless aliases_allowed
      puts "Maybe Aliases Are Off" unless ENV["NO_DEBUG"]
    else
      Maybe.class_exec do
        alias_method :with_default, :unwrap
      end
    end
  end

  def map
    if value
      Maybe.new(yield(value))
    else
      self
    end
  end


  def unwrap(default)
    if value
      value
    else
      default
    end
  end

  def call(*args)
    self
  end

  def nil?
    !!value
  end

  def to_s
    if value
      "Just #{value}"
    else
      "Nothing"
    end
  end

  def inspect
    "<Maybe: #{self}>"
  end

  def <=>(other)
    if other.respond_to?(:value)
      value <=> other.value
    else
      value <=> other
    end
  end

  def ==(other)
    binding.pry
    if other.respond_to?(:value)
      value == other.value
    else
      value == other
    end
  end
end

def Maybe(value)
  Maybe.new(value)
end

def Just(value)
  Maybe.new(value)
end

Nothing = Maybe.new

