describe('stream_max', function()
  require 'stream'
  require 'string_lambda'

  it('can max records', function()
    assert.is.equal(5, Stream.stream({ 1, 5, 3, 4 }):max())
  end)

  it('can max accessed records', function()
    assert.is.same(5, Stream.stream({ 'a', 'bb', 'ccc', 'dddd', 'eeeee' }):max(L '|a| #a'))
  end)

  -- this no longer has errors on lua 5.3 and 5.4 - Find a sensible alternative for the test
  -- it('throws an error on non-numeric values', function()
  --   assert.has.errors(function()
  --     Stream.stream({ 'a', 'bb', 'ccc' }):max()
  --   end)
  -- end)
end)
