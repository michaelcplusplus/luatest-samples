-- http post multipart/form-data

local tmpFileName <const> = app.cacheDir() .. "/temp.txt"

local tmpFile = io.open(tmpFileName, 'w')

tmpFile:write("hello world")
tmpFile:close()

local rq = {
  url = "https://httpbin.org/anything",
  method = "POST",
  multiPartFormData = {{
      name = "myFile", -- mandatory
      filename = "upload.txt", -- optional, if not set filename of value is used
      value = "@" .. tmpFileName -- mandatory, location of local file
    },{
      name = "metadata",
      value = "{\"name\": \"hello.txt\"}",
      contentType = "application/json"
    }
  }
}

statuscode, content = app.httprequest(rq)
print(statuscode)
print(content)
