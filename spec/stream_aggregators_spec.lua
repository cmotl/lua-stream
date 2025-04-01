require 'string_lambda'

describe('stream_aggregators', function()
  local StreamAggregators = require('stream').aggregators

  it('can multi values', function()
    local multi_agg_fn = StreamAggregators.multi {
      StreamAggregators.sum(),
      StreamAggregators.sum(function(x)
        return x * x
      end), -- sum of squares
      StreamAggregators.min(),
      StreamAggregators.count(),
    }()
    assert.is.same({ 1, 1, 1, 1 }, multi_agg_fn(1))
    assert.is.same({ 3, 5, 1, 2 }, multi_agg_fn(2))
    assert.is.same({ 6, 14, 1, 3 }, multi_agg_fn(3))
  end)

  it('can aggregate last', function()
    local f = StreamAggregators.last(function(x)
      return x * 2
    end)()
    assert.is.equal(6, f(3))
    assert.is.equal(10, f(5))
    assert.is.equal(14, f(7))
  end)

  it('can aggregate first', function()
    local f = StreamAggregators.first(function(x)
      return x * 2
    end)()
    assert.is.equal(6, f(3))
    assert.is.equal(6, f(5))
    assert.is.equal(6, f(7))
  end)

  it('can aggregate group_by', function()
    local plus_one = function(v)
      return v + 1
    end
    local f = StreamAggregators.group_by(plus_one, StreamAggregators.count())()
    assert.is.same({ [2] = 1 }, f(1))
    assert.is.same({ [2] = 2 }, f(1))
    assert.is.same({ [2] = 3 }, f(1))
    assert.is.same({ [2] = 3, [3] = 1 }, f(2))
    assert.is.same({ [2] = 3, [3] = 1, [1] = 1 }, f(0))
    assert.is.same({ [2] = 3, [3] = 2, [1] = 1 }, f(2))
    assert.is.same({ [2] = 4, [3] = 2, [1] = 1 }, f(1))
  end)

  describe('pairwise aggregator', function()
    local p

    before_each(function()
      p = StreamAggregators.pairwise()()
    end)

    it('should return nothing when receiving first item', function()
      local pair = p(1)
      assert.are.same(nil, pair)
    end)

    it('should return correct piar after receiving second item', function()
      p(1)
      pair = p(2)
      assert.are.same({ 1, 2 }, pair)
    end)

    it('should return correct piar after receiving third item', function()
      p(1)
      p(2)
      pair = p(3)
      assert.are.same({ 2, 3 }, pair)
    end)
  end)

  describe('multiplex aggregator', function()
    local m

    before_each(function()
      local key_fn = function(x)
        return x % 2
      end
      local counting_aggregator_factory = function()
        local count = 0
        return function(x)
          count = count + 1
          return count
        end
      end
      m = StreamAggregators.multiplex(key_fn, counting_aggregator_factory)()
    end)

    it('should apply aggregator for single key and single item', function()
      local value = m(0)

      assert.are.same(1, value)
    end)

    it('should apply aggregator for single key and multiple items', function()
      m(0)

      local value = m(2)

      assert.are.same(2, value)
    end)

    it('should apply aggregator for multiple keys with single items', function()
      local even_count = m(0)
      local odd_count = m(1)

      assert.are.same(1, even_count)
      assert.are.same(1, odd_count)
    end)

    it('should apply aggregator for multiple keys with multiple items', function()
      m(0)
      m(1)

      local value = m(2)

      assert.are.same(2, value)
    end)
  end)

  describe('collect', function()
    local f

    describe('without accessor', function()
      before_each(function()
        f = StreamAggregators.collect()()
      end)

      it('should aggregate multiple values', function()
        f(1)
        f(2)
        local result = f(3)

        assert.is.same({ 1, 2, 3 }, result)
      end)
    end)

    describe('with accessor', function()
      before_each(function()
        f = StreamAggregators.collect(L '_*2')()
      end)

      it('should aggregate multiple values', function()
        f(1)
        f(2)
        local result = f(3)

        assert.is.same({ 2, 4, 6 }, result)
      end)
    end)
  end)

  describe('distinct', function()
    local f

    describe('without accessor', function()
      before_each(function()
        f = StreamAggregators.distinct()()
      end)

      it('should aggregate single value', function()
        assert.is.same({ 3 }, f(3))
      end)

      it('should aggregate multiple values and maintain order', function()
        f(1)
        f(2)
        assert.is.same({ 1, 2, 3 }, f(3))
      end)

      it('should not duplicate values', function()
        f(1)
        f(2)
        f(3)
        assert.is.same({ 1, 2, 3 }, f(2))
      end)
    end)
    describe('with accessor', function()
      before_each(function()
        f = StreamAggregators.distinct(L '_*2')()
      end)

      it('should aggregate single value', function()
        assert.is.same({ 6 }, f(3))
      end)

      it('should aggregate multiple values and maintain order', function()
        f(1)
        f(2)
        assert.is.same({ 2, 4, 6 }, f(3))
      end)

      it('should not duplicate values', function()
        f(1)
        f(2)
        f(3)
        assert.is.same({ 2, 4, 6 }, f(2))
      end)
    end)
  end)
end)
