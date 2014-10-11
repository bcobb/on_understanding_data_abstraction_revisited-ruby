def EmptySet
  Implementation::EmptySet.new
end

def InsertSet(s, n)
  if s.contains?(n)
    s
  else
    Implementation::InsertSet.new(s, n)
  end
end

def UnionSet(s1, s2)
  Implementation::UnionSet.new(s1, s2)
end

module Implementation
  class EmptySet
    def empty?
      true
    end

    def contains?(i)
      false
    end

    def insert(i)
      InsertSet(self, i)
    end

    def union(s)
      s
    end
  end

  class InsertSet
    def initialize(s, n)
      @s = s
      @n = n
    end

    def empty?
      false
    end

    def contains?(i)
      i == @n || @s.contains?(i)
    end

    def insert(i)
      InsertSet(self, i)
    end

    def union(s)
      UnionSet(self, s)
    end
  end

  class UnionSet
    def initialize(s1, s2)
      @s1 = s1
      @s2 = s2
    end

    def empty?
      @s1.empty? && @s2.empty?
    end

    def contains?(i)
      @s1.contains?(i) || @s2.contains?(i)
    end

    def insert(i)
      InsertSet(self, i)
    end

    def union(s)
      UnionSet(self, s)
    end
  end
end
