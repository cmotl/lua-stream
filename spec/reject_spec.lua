describe('stream_reject', function()
  require 'stream'

  it('can reject some values', function()
    assert.is.same(
      { 3, 4 },
      Stream.stream({ 1, 2, 3, 4 })
        :reject(function(x)
          return x <= 2
        end)
        :to_table()
    )
  end)

  it('can reject with anything not falsy', function()
    assert.is.same(
      { 3, 4 },
      Stream.stream({ 1, 2, 3, 4 })
        :reject(function(x)
          if x <= 2 then
            return true
          end
        end)
        :to_table()
    )
  end)
end)
