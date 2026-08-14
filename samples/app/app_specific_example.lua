-- starts a timer you can use to track how long an operation takes
app.time()

app.toast("Hello Android")

print(app.utcNow())

 
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

-- convert lua table to JSON string
print(app.tojson(myTable)) 

--Sleep for the specified number of milliseconds
app.msleep(100)

--Returns the absolute path to the directory on the 
--primary shared/external storage device where the application 
--can place persistent files it owns.
print(app.dir())

--Returns absolute path to application-specific directory on the 
--primary shared/external storage device where the application 
--can place cache files it owns.
print(app.cacheDir())

-- The app.timeEnd() stops a timer that was previously started by calling app.time()
elapsedTime = app.timeEnd() 

print(string.format("\nTotal: %.0f ms", elapsedTime))

-- Read OpenAI api key from preferences
print(app.openAiApiKey())

-- Use android text to speech api
app.speak("Good morning, lua", "en")
app.msleep(100)
app.speak("Guten Morgen, lua", "de")

app.inplaceForm("hello world")

-- jwt
print(app.jwtEncode("HS256", "{\"name\": \"John\"}", "super-secret-key"))
local secret_base64_encoded = true
print(app.jwtEncode("HS256", "{\"name\": \"John\"}", "c3VwZXItc2VjcmV0LWtleQ==", secret_base64_encoded))
print(app.jwtEncode("none", "{\"name\": \"John\"}"))

-- convert base64url to base64
print(app.base64UrlToBase64("c3VwZXItc2VjcmV0LWtleQ"))