RSpec.shared_examples "a set" do
  describe 'EmptySet' do
    it 'is empty' do
      expect(EmptySet().empty?).to eql(true)
    end

    it 'contains items inserted into itself' do
      set = EmptySet().insert(1).insert(2)

      expect(set.contains?(1)).to eql(true)
      expect(set.contains?(2)).to eql(true)
    end

    it 'can be unioned with another set' do
      set = EmptySet().union(EmptySet().insert(1))

      expect(set.contains?(1)).to eql(true)
    end

    it 'does not containe items which have not been inserted' do
      set = EmptySet()

      expect(set.contains?(1)).to eql(false)
    end
  end

  describe 'InsertSet' do
    it 'is not empty when constructed with an item' do
      set = InsertSet(EmptySet(), 1)

      expect(set.empty?).to eql(false)
    end

    it 'contains its initial item' do
      set = InsertSet(EmptySet(), 1)

      expect(set.contains?(1)).to eql(true)
    end

    it 'contains any items in its initial set' do
      set = InsertSet(EmptySet().insert(2), 1)

      expect(set.contains?(1)).to eql(true)
    end

    it 'can be unioned with another set' do
      set = InsertSet(EmptySet().insert(2), 1).union(EmptySet().insert(3))

      expect(set.contains?(3)).to eql(true)
    end

    it 'does not contain items which are in neither its initial set or item' do
      set = InsertSet(EmptySet().insert(2), 1)

      expect(set.contains?(3)).to eql(false)
    end
  end

  describe 'UnionSet' do
    it 'contains only the elements of its initial sets' do
      set = UnionSet(
        InsertSet(EmptySet(), 1),
        InsertSet(EmptySet(), 2)
      )

      expect(set.contains?(1)).to eql(true)
      expect(set.contains?(2)).to eql(true)
      expect(set.contains?(3)).to eql(false)
    end

    it 'contains elements which are inserted into it' do
      set = UnionSet(
        InsertSet(EmptySet(), 1),
        InsertSet(EmptySet(), 2)
      ).insert(3)

      expect(set.contains?(3)).to eql(true)
    end

    it 'is empty when it is the union of two empty sets' do
      set = UnionSet(EmptySet(), EmptySet())

      expect(set.empty?).to eql(true)
    end

    it 'is not empty when it is the union of at least one non-empty set' do
      set = UnionSet(EmptySet(), EmptySet().insert(1))

      expect(set.empty?).to eql(false)
    end

    it 'can be unioned with another set' do
      other_set = EmptySet().insert(2)
      set = UnionSet(EmptySet(), EmptySet().insert(1)).union(other_set)

      expect(set.contains?(2)).to eql(true)
    end
  end
end
