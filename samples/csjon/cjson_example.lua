json = require "cjson"

local myTable = {
  method = "GET",
  queryParams = {
    { key = "hello",
      value = "world"
    },{
      key = "hello1",
      value = "world2"
    }
  }
}

local json_string = json.encode(myTable)
print(json_string)

local t = json.decode(json_string)

print(t.method)

