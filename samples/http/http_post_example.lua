-- http post example with body
local rq = {
  url = "https://httpbin.org/anything",
  method = "POST",
  rawData = "{\"id\":42, \"myval\":\"Hello world\"}"
}

statuscode, content = app.httprequest(rq)
print(statuscode)
print(content)
