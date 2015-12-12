class Password
  attr_accessor :value

  def initialize(value)
    @value = value
  end
  
  def get_new_password()
    while(!check_validation(@value)) do
      @value = @value.next    
    end
    return @value
  end

  def check_validation(value)
    if value.length>8
      puts 'Error, out of 8'
      exit
    end
    return false if value.include?('i') || value.include?('o') || value.include?('l');
    return false if !get_doubles(value)
    return false if !get_straigh(value)
    return true
  end

  def get_doubles(value)

    count = 0
    ant = nil
    value.split("").each do |l|
      if ant == l
        count += 1
        ant = nil
      else
        ant = l
      end
      
    end
    return true if count >1
    return false
  end

  def get_straigh(value)
    init = 'abc'
    (0..24).each do |ind|
      return false if(init.length > 3)
      return true if value.include?(init)
      new = ""
      init.split("").each do |char|
        new += char.next
      end
      init = new
    end
    return false
  end
end

