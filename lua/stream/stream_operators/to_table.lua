function Stream:to_table(transform)
  local table_insert = function(t, x)
    table.insert(t, x)
    return t
  end

  local empty_table = {}

  return self:reduce(table_insert, empty_table, transform)
end
