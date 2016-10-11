class BitSet
  def initialize(size = 0)
    @map = []
    size.times do |i|
      @map[i] = 0
    end
  end

  def on(i)
    @map[i] = 1
  end

  def off(i)
    @map[i] = 0
  end

  def [](pos)
    @map[pos]
  end

  def []=(pos,bool)
    @map[pos] = bool ? 1 : 0
  end

  def set(*arr)
    if arr.length == 1
      arr = arr[0]
    end
    arr.each do |i|
      @map[i] = 1
    end
  end

  def clear(*arr)
    if arr.length == 1
      arr = arr[0]
    end
    arr.each do |i|
      @map[i] = 0
    end
  end

  def length
    @map.length
  end

  def to_s
    @map.join('')
  end
end
