local SortManyStreams = {}

local function insert_source_at_head(self, source)
  source.next = self.head
  self.head = source
end

local function remove_source_at_head(self)
  local old_head = self.head
  local new_head = old_head.next
  self.head = new_head
  old_head.next = false
  return old_head
end

local function insert_source_after_head(self, source, accessor, comparator)
  local current = self.head
  while current.next and (not comparator(source.sort_key, current.next.sort_key)) do
    current = current.next
  end
  source.next = current.next
  current.next = source
end

local function insert_source_in_sorted_order(self, source, accessor, comparator)
  if (not self.head) or comparator(source.sort_key, self.head.sort_key) then
    insert_source_at_head(self, source)
  else
    insert_source_after_head(self, source, accessor, comparator)
  end
end

local function add_stream_as_source(self, stream)
  self:peek_at_head()
  local first_value = stream:first()
  if first_value then
    local accessor = self.accessor
    local source = {
      stream = stream,
      value = first_value,
      sort_key = accessor(first_value),
      next = false,
    }
    insert_source_in_sorted_order(self, source, accessor, self.comparator)
  end
end

local function peek_at_head(self)
  local head = self.head
  if head then
    local head_value = head.value
    if head_value then
      return head_value
    else
      head_value = head.stream:first()
      if head_value then
        local accessor = self.accessor
        local comparator = self.comparator
        head.value = head_value
        local head_sort_key = accessor(head_value)
        head.sort_key = head_sort_key
        if not head.next or comparator(head_sort_key, head.next.sort_key) then
          return head.value
        else
          local value = head.next.value
          insert_source_after_head(self, remove_source_at_head(self), accessor, comparator)
          return value
        end
      else
        remove_source_at_head(self)
        head = self.head
        if head then
          return head.value
        end
      end
    end
  end
  return nil
end

local function take_at_head(self)
  local head = self.head
  local value = head.value
  head.value = false
  head.sort_key = false
  return value
end

SortManyStreams.stream = function(streams, accessor, comparator)
  local self = {
    accessor = accessor or function(x)
      return x
    end,
    comparator = comparator or function(a, b)
      return a <= b
    end,
    peek_at_head = peek_at_head,
    take_at_head = take_at_head,
    head = false,
  }

  Stream.stream(streams):each(function(stream)
    add_stream_as_source(self, stream)
  end)

  local return_stream = Stream:new(function()
    if self:peek_at_head() then
      return self:take_at_head()
    end
  end)

  return_stream.add_stream = function(_, stream)
    return add_stream_as_source(self, stream)
  end
  return_stream.peek_at_head = function(_)
    return peek_at_head(self)
  end

  return return_stream
end

return SortManyStreams
