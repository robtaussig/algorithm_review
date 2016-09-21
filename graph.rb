class Vertex
  attr_accessor :value, :neighbors

  def initialize(value)
    @value = value
    @neighbors = []
  end

  def to_s
    [@value]
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

  def add_edge(start_val, end_val, directed = true)
    from = vertices.index { |v| v.value == start_val }
    to = vertices.index { |v| v.value == end_val}
    vertices[from].neighbors << end_val
    if !directed
      vertices[to].neighbors << start_val
    end
  end

  def create_graph_from_hash(hash, directed = true)
    graph = Graph.new
    hash.keys.each do |key|
      graph.add_vertex(key)
    end
    hash.each do |key,value|
      value.each do |neighbor|
        graph.add_edge(key,neighbor, directed)
      end
    end
    @vertices = graph.vertices
  end

  def count
    vertices.length
  end

  def to_s
    @vertices.map { |vertex| vertex.to_s }
  end
end
