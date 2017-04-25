class Object
  def thru
    yield self
    self
  end
end
