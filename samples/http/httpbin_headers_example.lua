--http header example
local rq = {
  url = "https://httpbin.org/headers",
  method = "GET",
  headerData = {
    {key = "X-Timezone-Iana", value = "Europe/Berlin"},
    {key = "X-Test", value = "Value-Test"}
  }
}

print(app.tojson(rq))
statuscode, content = app.httprequest(rq)
print(statuscode)
print(content)

