describe('stream_all', function()
  require 'stream'

  it('should emit true for the empty set', function()
    assert.is.truthy(Stream.stream({})
      :all(function(x)
        return true
      end)
      :first())
  end)

  it('should emit true if all items match the condition function', function()
    assert.is.truthy(Stream.stream({ 1, 2, 3 })
      :all(function(x)
        return x > 0
      end)
      :first())
  end)

  it('should emit false if the first item does not match the condition function', function()
    assert.is.falsy(Stream.stream({ 0, 2, 3 })
      :all(function(x)
        return x > 0
      end)
      :first())
  end)

  it('should emit false if the last item does not match the condition function', function()
    assert.is.falsy(Stream.stream({ 1, 2, 0 })
      :all(function(x)
        return x > 0
      end)
      :first())
  end)

  it('should alias to every', function()
    assert.is.equal(Stream.all, Stream.every)
  end)
end)
