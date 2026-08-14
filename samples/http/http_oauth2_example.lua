oauth2 = require "oauth2"
json = require "cjson"

function userInfo(token)
  local rq = {
    url = "https://openidconnect.googleapis.com\z
       /v1/userinfo",
    method = "GET",
    authorization = "Bearer " .. token
  }
  statuscode, content = app.httprequest(rq)
  print(statuscode)
  print(content)
end

auth_code = ""
function onCode(code)
  io.write("\n- "..code.."\n")
  auth_code = code
end

print("oauth2 google example")

oauth2.onAuthorizationCode(onCode)

client_id = "1020007356645-1j2fr1k4piip624a5juuduecs2b0nh3k.apps.googleusercontent.com"
redirect_uri = "de.mlauer.luatest:/oauth2redirect"

-- login with standard browser
app.intent(string.format(
  "https://accounts.google.com/o/oauth2/auth\z
  ?client_id=%s\z
  &redirect_uri=%s\z
  &response_type=code\z
  &scope=openid%%20email",
  client_id,
  redirect_uri)
)

while (auth_code == "") do
  app.msleep(100)
end

local rq = {
  url="https://oauth2.googleapis.com/token",
  method="POST",
  contentType="application/x-www-form-urlencoded",  
  rawData=string.format(
     "client_id=%s\z
     &grant_type=authorization_code\z
     &code=%s\z
     &redirect_uri=%s",
     client_id,
     auth_code,
     redirect_uri)
}

statuscode, content = app.httprequest(rq)
print(statuscode)

if statuscode == 200 then
  --print(content)
  t = json.decode(content)
  userInfo(t.access_token) 
  --app.inputForm("id_token", t.id_token)
end
