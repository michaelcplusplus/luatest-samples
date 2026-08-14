-- http bearer authorization example
local rq = {
  url = "https://httpbin.org/bearer",
  method = "GET",
  authorization = "Bearer Bearertokenxyz"
}

print(app.tojson(rq))    

statuscode, content = app.httprequest(rq)
print(statuscode)
print(content)

