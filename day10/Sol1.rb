class LookAndSay
  attr_accessor :value
  def initialize(value)
    @value = value
  end
  def run(times)
#    puts "Times : #{times} value: #{@value}"
    if times <= 0
      return @value.length
    end
    act = nil
    qty = 0
    add = 0
    new  = ""
    @value.split("").each do |val|
      act = val unless act
      if (act == val)
        qty += 1
        add = 1
#        puts "Adding #{val} #{qty}"
      else
        qty = 1 if act == nil
        new += "#{qty}#{act}"
        act = val
        qty = 1
      end 
    end
    if add
        new += "#{qty}#{act}"
    end
    
    @value = new
    run(times-1)
  end
end


