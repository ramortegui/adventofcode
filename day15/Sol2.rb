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
  attr_accessor :ingredients, :maxim
  def initialize(file)
    @ingredients = []
    @maxim = 0
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
    sub(0,Array.new(@ingredients.size))
    puts "The better combination is #{@maxim}"
    return
  end


  def sub(ind, arr)
    arr_temp  = Array.new(arr)
    if ind < arr.size
      1.upto(100){ |i| 
        arr_temp[ind] = i 
        sub( ind+1,arr_temp)
      }
    else
      if( arr_temp.inject(:+) == 100 )
        temp = check_cookies(arr_temp)
        @maxim = temp if @maxim < temp
      end
      return
    end
  end



  def check_cookies(arr)
    capacity = 0
    durability = 0
    flavor = 0
    texture = 0 
    calories = 0;
    @ingredients.each_with_index do |ing,i|
      capacity += ing.capacity * arr[i]
      durability += ing.durability * arr[i]
      flavor += ing.flavor * arr[i]
      texture += ing.texture * arr[i] 
      calories += ing.calories * arr[i] 
    end
    return 0 if calories != 500;
    return 0 if capacity <= 0 || durability <=0 || flavor <=0 || texture <= 0
    return capacity * durability * flavor * texture
  end

end
