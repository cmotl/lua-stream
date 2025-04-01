describe('stream_with_ordinal', function()
  require 'stream'

  it('can stream with ordinals', function()
    assert.are.same({ { 'a', 1 }, { 'b', 2 }, { 'c', 3 }, { 'd', 4 } }, Stream.stream({ 'a', 'b', 'c', 'd' }):with_ordinal():to_table())
  end)
end)
