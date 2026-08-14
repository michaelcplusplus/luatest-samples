-- http basic auth example

 local rq = {
  url = "https://httpbin.org/basic-auth/myuser/mypasswd",
  method = "GET",
  basicAuth = {
    username = "myuser",
    password ="mypasswd"
  }
}

print(app.tojson(rq))    

statuscode, content = app.httprequest(rq)
print(statuscode)
print(content)
