describe('stream_contains', function()
  require 'stream'

  local values = { 1, 2, 3, 4, 5 }

  it('should emit true when condition is satisfied', function()
    local condition_fn = function(value)
      return value > 3
    end

    local result = Stream.stream(values):contains(condition_fn):first()

    assert.is.equal(true, result)
  end)

  it('should emit false if condition is never satisfied', function()
    local condition_fn = function(value)
      return value > 10
    end

    local result = Stream.stream(values):contains(condition_fn):first()

    assert.is.equal(false, result)
  end)

  it('should emit transformed value when condition is satisfied', function()
    local condition_fn = function(value)
      return value > 3
    end
    local transform_fn = function(value)
      return value * 8
    end

    local result = Stream.stream(values):contains(condition_fn, transform_fn):first()

    assert.is.equal(32, result)
  end)
end)
