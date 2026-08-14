json = require "cjson"

--[[
Store API key in Preferences "Google" API key

https://ai.google.dev/tutorials/rest_quickstart
--]]

local palmApiKey = app.palmApiKey()

function get_completion(data)
  local response = ""
  local rq = { 
    connectTimeout = 60000,
    readTimeout = 60000,
    method = "POST", 
    url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent?key="..palmApiKey,
    contentType= "application/json; charset=UTF-8"
  }  

  contents = {
    contents = data
  }

  rq.rawData = app.tojson(contents)
  --print(rq.rawData) 
  statuscode, content = app.httprequest(rq) 
  print(statuscode) 
   
  if (statuscode >= 200 and statuscode < 300) 
  then 
    t = json.decode(content)
    -- print(content)
    -- print("finishReason: " .. t.candidates[1].finishReason)
    if ((t.candidates[1].content == null) or
        (t.candidates[1].content.parts == null))
    then
      app.error("finishReason: " .. t.candidates[1].finishReason)
    else
      response = t.candidates[1].content.parts[1].text
    end
  else 
    app.error(content) 
  end
  return response
end  

local context = {{
  role = "user",
  parts = {{
    text = app.inputForm("Question","Give me five subcategories of jazz")
      }}
    }
}

response = get_completion(context)
-- app.printMarkdown(response)
print(response)
