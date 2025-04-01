describe('stream_peek', function()
  require 'stream'

  it('can peek values', function()
    local number_of_values_passed = 0

    assert.is.same(
      { 1, 2, 3, 4 },
      Stream.stream({ 1, 2, 3, 4 })
        :peek(function(value)
          number_of_values_passed = number_of_values_passed + 1
        end)
        :to_table()
    )
    assert.is.equal(4, number_of_values_passed)
  end)
end)
