class Vertex
  attr_accessor :name, :neighbors

  def initialize(value)
    @value = value
    @neighbors = []
  end
end

class Graph
  attr_accessor :vertices

  def initialize
    @vertices = []
  end

  def add_vertex(value)
    @vertices << Vertex.new(value)
  end

  def find_vertex(value)
    vertices.each do |v|
      return v if v.value == value
    end
    nil
  end

  def add_edge(start_val, end_val, undirected = true)
    from = vertices.index { |v| v.value == start_val }
    to = vertices.index { |v| v.value == end_val}
    vertices[from].neighbors[to] = true
    if undirected
      vertices[to].neighbors[from] = true
    end
  end

  def count
    vertices.length
  end
end
