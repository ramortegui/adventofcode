require 'json'
class Books
  attr_accessor :string 
  def initialize(fname)
    f = File.open(fname,'r')
    @string = f.readline().chomp()
    f.close()
    puts sum_nums
    return
  end

  def sum_nums
    parsed = JSON.parse(@string) 
    @val = 0
    recursive_loop(parsed)
    return @val
  end

  def recursive_loop(parsed)

    if parsed.class.to_s == "String"
      return
    end
    if parsed.class.to_s == 'Fixnum'
      @val += parsed
      return
    end
    if parsed.class.to_s == 'Array'
      parsed.each do |e|
        recursive_loop(e)
      end
      return
    end
    parsed.keys.each do |doc|
      if doc.class.to_s == 'Fixnum'
        @val+=doc
      else
        recursive_loop(parsed[doc])
      end
    end
  end
end
