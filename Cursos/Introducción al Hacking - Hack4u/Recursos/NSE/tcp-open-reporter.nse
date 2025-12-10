-- HEAD --

description = [[
Script de ejemplo que enumera y reporta puertos abiertos por TCP
]]

-- RULE --

portrule = function(host, port)
  return host.protocol == "tcp"
    and port.state == "open"
end

-- ACTION --

action = function(host, port)
  return string.format("Puerto TCP %d está abierto", port.number)
end


