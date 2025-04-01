function Stream:each(fn)
  local binary_operation = function(_, x)
    fn(x)
    return nil
  end

  self:reduce(binary_operation, nil)
end
