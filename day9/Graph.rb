
require 'pp'
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
  attr_accessor :vertices, :edges, :roads, :weights
  def initialize(fname)
    @vertices = []
    @edges = []
    @roads = []
    @weights = []
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
  def get_weight(sidea, sideb)
    @edges.each do |e|
      if(e.sidea == sidea && e.sideb == sideb )
        return e.weight
      elsif(e.sidea == sideb && e.sideb == sidea )
        return e.weight
      end
    end
  end

  def get_neighborhs(vertice,autovisit)
    neighbors = []
    @edges.each do |e|
      if(e.sidea == vertice)
        neighbors << e.sideb unless autovisit.detect{ |te| e.sideb == te }
      elsif(e.sideb == vertice)
        neighbors << e.sidea unless autovisit.detect{ |te| e.sidea == te }
      end
    end
    return neighbors
  end

  def go_through(initial, visited, weight)
    pp "-------------------------"
    autovisit = Array.new(visited)
    autovisit << initial
#    pp autovisit
#    pp vertices
    if (autovisit.size == @vertices.size )
      pp "Encontro uno"
      roads << autovisit
      weights << weight
#      pp autovisit
#      pp weights
      return weight.to_i;
    else
      temp = get_neighborhs(initial,autovisit)
      temp.each do |to_visit|
        if(!autovisit.detect { |av| av == to_visit })
          pp "Visitar a #{to_visit.name}"
          pp "With this values #{autovisit}"
          go_through(to_visit, autovisit, (get_weight(initial,to_visit).to_i+weight.to_i))
        end
      end
    end
  end
end
