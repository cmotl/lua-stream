describe('stream_to_table', function()
  require 'stream'
  require 'string_lambda'

  it('can aggregate all stream values to a list', function()
    assert.is.same({}, Stream.stream({}):to_table())
    assert.is.same({ 1, 2, 3 }, Stream.stream({ 1, 2, 3 }):to_table())
  end)

  it('can aggregate all transformed stream values to a list', function()
    assert.is.same({ 2, 4, 6 }, Stream.stream({ 1, 2, 3 }):to_table(L '|a| a*2'))
  end)
end)
