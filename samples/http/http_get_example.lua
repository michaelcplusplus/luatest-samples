-- http get example with parameters
local rq = {
  url = "https://httpbin.org/anything",
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

print(app.tojson(rq))

statuscode, content = app.httprequest(rq)
print(statuscode)
print(content)


