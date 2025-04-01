describe('stream_pairwise', function()
  require 'stream'

  it('can pairwise values', function()
    local values = { 1, 2, 3, 4 }
    local expected_values = { { 1, 2 }, { 2, 3 }, { 3, 4 } }
    local actual_values = {}

    Stream.stream(values):pairwise():each(function(pair)
      table.insert(actual_values, pair)
    end)
    assert.is.same(expected_values, actual_values)
  end)
end)
