describe('stream_reject_until', function()
  require 'stream'

  it('can reject until some condition', function()
    assert.is.same(
      { 3, 4, 1, 2 },
      Stream.stream({ 1, 2, 3, 4, 1, 2 })
        :reject_until(function(x)
          return x > 2
        end)
        :to_table()
    )
  end)
end)
