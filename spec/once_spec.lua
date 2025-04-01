describe('stream_once', function()
  require 'stream'

  it('can run stuff once', function()
    local calls = 0
    local function call_me()
      calls = calls + 1
    end

    Stream.stream({ 1, 2, 3, 4 }):once(call_me):to_table()
    assert.is.same(1, calls)
  end)
end)
