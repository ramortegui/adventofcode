class Reindeer
  attr_accessor :name, :max_speed, :time_max_speed, :rest_time, :status, :distance, :time_running, :time_resting
  #0 resting
  #1 ready
  def initialize(name, speed, times, rt, status)
    @name = name
    @max_speed = speed
    @time_max_speed = times
    @rest_time = rt
    @status = status 
    @distance = 0
    @time_running = 0
    @time_resting = 0
  end 
  
  def go()
    if(@status == 1)
      @time_running += 1
      @distance += @max_speed
      if(@time_running == @time_max_speed)
        @status = 0
        @time_running = 0
        @time_resting = 0
      end 
    else
        @time_resting += 1
        if(@time_resting == @rest_time)
          @status = 1
          @time_resting = 0
          @time_running = 0
        end
    end
  end

  def better_than?(distance)
    (@distance > distance)? true : false
  end
end


class Competition
  attr_accessor :deers
  def initialize(file)
    @deers = []
    f = File.open(file,'r')
    content = f.readlines()
    f.close
    create_deers(content)
  end
  
  def create_deers(content)
    content.each do |line|
      info = line.chomp().split(" ")
      deers << Reindeer.new(info[0],info[3].to_i,info[6].to_i,info[13].to_i,1)
    end
  end

  def run(time)
    (1..time).each do 
      @deers.map{ |d| d.go }
    end
    max = 0;
    @deers.each do |d|
      if d.better_than?(max)
        max = d.distance
      end
    end

    puts "The winner run #{max}Km"
    return
  end

  
end
