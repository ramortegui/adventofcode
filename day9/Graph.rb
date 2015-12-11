class Vertice
  attr_accessor :name,:link
  def initialize(name)
      @name = name;
  end
end

class Edge
  attr_accessor :sidea, :sideb, :weight
  def initialize(sidea,sideb,weight)
    @sidea = sidea
    @sideb = sideb
    @weight = weight
  end
end

class Graph
  attr_accessor :vertices, :edges
  def initialize(fname)
    @vertices = []
    @edges = []
    f = File.open(fname,'r')
    content = f.readlines()
    content.each do |line|
      line = line.chomp()
      temp_line = line.split(" = ")
      cities = temp_line[0].split(" to ")
      cities.each do |c|
        if !@vertices.detect{ |v| v.name == c }
          @vertices << Vertice.new(c)
        end
      end
      @edges << Edge.new(
        @vertices.detect{ |v| v.name == cities[0] },
        @vertices.detect{ |v| v.name == cities[1] },
        temp_line[1])
    end
    f.close()
  end
end

