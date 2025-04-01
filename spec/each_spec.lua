describe('stream_each', function()
  require 'stream'

  it('can each values', function()
    local values = { 1, 2, 3, 4 }
    local each_values = {}
    Stream.stream(values):each(function(value)
      table.insert(each_values, value)
    end)
    assert.is.same(values, each_values)
  end)
end)
