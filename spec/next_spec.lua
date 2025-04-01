describe('stream_next', function()
  require 'stream'

  it('can get next value one at a time', function()
    local s = Stream.stream { 1, 2, 3 }
    assert.is.equal(1, s:next())
    assert.is.equal(2, s:next())
    assert.is.equal(3, s:next())
    assert.is_nil(s:next())
  end)
end)
