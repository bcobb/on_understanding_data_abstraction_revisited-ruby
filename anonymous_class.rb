#
# The purpose of this version is to downplay the role of the class. There are
# no instance variables, and there is no way for a user to directly instantiate
# a set.
#

def EmptySet
  Class.new do
    define_method(:empty?) { true }

    define_method(:contains?) { |i| false }

    define_method(:insert) { |i| InsertSet(self, i) }

    define_method(:union) { |s| s }
  end.new
end

def InsertSet(s, n)
  if s.contains?(n)
    s
  else
    Class.new do
      define_method(:empty?) { false }

      define_method(:contains?) do |i|
        i == n || s.contains?(i)
      end

      define_method(:insert) do |i|
        InsertSet(self, i)
      end

      define_method(:union) do |s|
        UnionSet(self, s)
      end
    end.new
  end
end

def UnionSet(s1, s2)
  Class.new do
    define_method(:empty?) do
      s1.empty? && s2.empty?
    end

    define_method(:contains?) do |i|
      s1.contains?(i) || s2.contains?(i)
    end

    define_method(:insert) do |i|
      InsertSet(self, i)
    end

    define_method(:union) do |s|
      UnionSet(self, s)
    end
  end.new
end
