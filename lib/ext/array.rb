class Array
  
  # For now, just uses a scalar
  def /(other)
    self.map {|x| x / other}
  end
end
