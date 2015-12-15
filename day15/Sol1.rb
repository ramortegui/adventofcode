class Ingredient
  attr_accessor :name,:capacity, :durability, :flavor, :texture, :calories
  def initialize( name, capacity, durability, flavor, texture, calories)
    @name = name
    @capacity = capacity  
    @durability = durability
    @flavor = flavor 
    @texture = texture
    @calories = calories 
  end
end


class Kitchen
  attr_accessor :ingredients
  def initialize(file)
    @ingredients = []
    f = File.open(file,'r');
    content = f.readlines()
    f.close()
    load_info(content)
  end

  def load_info(content)
    content.each do |c|
      line = c.split(" ");
      name = line[0].slice(0,line[0].length-1) 
      capacity = line[2].slice(0,line[3].length-1).to_i
      durability = line[4].slice(0,line[4].length-1).to_i 
      flavor = line[6].slice(0,line[6].length-1).to_i 
      texture = line[8].slice(0,line[8].length-1).to_i 
      calories = line[10].to_i
      @ingredients <<  Ingredient.new(name, capacity, durability, flavor, texture, calories)
    end
  end

  def check_combination()
    max = 0
    (0..100).each do |i|
      (0..100).each do |j|
        if (i+j == 100)
         temp = check_cookies(i,j)
         max = temp if max < temp
        end
      end
    end
    puts "The better combination is #{max}"
    return
  end

  def check_cookies(i,j)
    capacity = @ingredients[0].capacity*i+ @ingredients[1].capacity*j;
    durability = @ingredients[0].durability*i+@ingredients[1].durability*j; 
    flavor = @ingredients[0].flavor*i+@ingredients[1].flavor*j;
    texture = @ingredients[0].texture*i+@ingredients[1].texture*j;
    return 0 if capacity <= 0 || durability <=0 || flavor <=0 || texture <= 0
    return capacity * durability * flavor * texture
  end

end
