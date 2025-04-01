describe('stream_min', function()
  require 'stream'
  require 'string_lambda'

  it('can min records', function()
    assert.is.equal(1, Stream.stream({ 5, 3, 1, 4, 6 }):min())
  end)

  it('can min accessed records', function()
    assert.is.same(1, Stream.stream({ 'a', 'bb', 'ccc', 'dddd', 'eeeee' }):min(L '|a| #a'))
  end)

  -- this no longer has errors on lua 5.3 and 5.4 - Find a sensible alternative for the test
  -- it('throws an error on non-numeric values', function()
  --   assert.has.errors(function()
  --     Stream.stream({ 'a', 'bb', 'ccc' }):min()
  --   end)
  -- end)
end)
