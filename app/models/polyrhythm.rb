class Polyrhythm < Object
  attr_accessor :a, :b

  def initialize(a, b)
    self.a=(a)
    self.b=(b)
  end

  def lowest_common_multiple
    #The least common denominator of two or more non-zero denominators is actually
    #the smallest whole number that is divisible by each of the denominators. www.helpwithfractions.com

    self.validate

    count = 0
    while true
      count += 1
      return count if ((count.modulo(self.a).zero?) & (count.modulo(self.b).zero?))
    end
  end

  def validate
    self.validate_part(self.a)
    self.validate_part(self.b)
  end

  def validate_part(part)
    Kernel.raise(self.error_string) if not(part.integer?)
    Kernel.raise(self.error_string) if not(part.>(0))
  end

  def error_string
    "must be positive integer"
  end
end