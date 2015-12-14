class Table
  attr_accessor :people, :relation, :happiness, :sitting
  def initialize(file)
    @people = {}
    @relation = {}
    @happiness = nil
    @sitting = []
    f = File.open(file,'r')
    loadInfo(f)
    mix()
    f.close() 
  end
  
  def loadInfo(f)
    content = f.readlines()
    content.each do |line|
      word =  line.split(" ")
      puts word[0]
      puts word[10].slice(0,word[10].length-1)
      puts @people
      p1 = word[0]
      p2 = word[10].slice(0,word[10].length-1)
      val = word[3].to_i
      if (!@people[p1])
        @people[p1] = 1 
      end

      if (!@people[p2])
        @people[p2] = 1
      end
      if(word[2] == "lose")
        val = val * -1
      end
      @relation["#{p1}_#{p2}"] = val
    end
  end

  def mix
    @people.keys.each do |person|
      check_positions(person,[])
    end
  end

  def check_positions(person,sitting)
    current_sitting = Array.new(sitting)
    current_sitting << person
    posibles = @people.keys - current_sitting
    if(posibles.size == 0)
      check_happiness(current_sitting)
    else
      posibles.each do |trying|
        check_positions(trying, current_sitting)
      end
    end
    return
  end

  def check_happiness(positions)
    puts "-------------------"
    val = 0
    positions.each_index do |i|
      val += @relation[positions[i]+"_"+positions[i-1]]
      if ( i == positions.length-1 )
        val += @relation[positions[i]+"_"+positions[0]]
      else
        val += @relation[positions[i]+"_"+positions[i+1]]
      end
      puts "checking #{positions[i]} - with #{positions[i-1]} total #{@relation[positions[i]+"_"+positions[i-1]]}"
    end
    puts "El valor actual es #{val}"
    @happiness = val if @happiness == nil
    puts positions
    puts @happiness
    puts "-------------------"
    if @happiness < val
      @happiness = val 
      @sitting = positions
    end
    return
  end
end
