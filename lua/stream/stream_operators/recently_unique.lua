require 'string_lambda'

function Stream:recently_unique(fn, size)
  local fn = fn or L '_'
  local size = size or 10000

  local next_slot = 0
  local expiry_queue = {}
  local known_entities = {}

  return self:filter(function(x)
    local current_key = fn(x)

    if known_entities[current_key] then
      return false
    end

    next_slot = next_slot + 1
    if next_slot > size then
      next_slot = 1
    end

    local key = expiry_queue[next_slot]
    if key then
      known_entities[key] = nil
    end
    expiry_queue[next_slot] = current_key

    known_entities[current_key] = true

    return true
  end)
end
