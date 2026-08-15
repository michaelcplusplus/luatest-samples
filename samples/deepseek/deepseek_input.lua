json = require "cjson"

local api_key = "sk-..."

function get_completion(prompt, temperature)
  temperature = temperature or 0

  local response = ""
  local rq = { 
    connectTimeout = 60000,
    readTimeout = 60000,
    method = "POST", 
    url = "https://api.deepseek.com/chat/completions",
    contentType= "application/json; charset=UTF-8", 
    authorization = "Bearer " .. api_key
  } 
  
  local data = {
    model = "deepseek-chat",
    temperature = temperature,
    stream = false,
    messages = {{
      role = "user",
      content = prompt
    }}
  }
  rq.rawData = app.tojson(data)
  -- print(rq.rawData) 
  statuscode, content = app.httprequest(rq) 
  print(statuscode) 
   
  if (statuscode >= 200 and statuscode < 300) 
  then 
    t = json.decode(content)
    response = t.choices[1].message.content
  else 
    app.error(content) 
  end
  return response
end  
          
local prompt = app.inplaceForm("")
if (prompt ~= "")
then
  print("Please wait...")
  response = get_completion(prompt)
  print(response)
end

    
