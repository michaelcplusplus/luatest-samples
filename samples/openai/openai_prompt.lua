json = require "cjson"

local openai_api_key = "OPENAI_API_KEY"
-- local openai_api_key = app.openAiApiKey()

function get_completion(prompt, temperature)
  temperature = temperature or 0

  local response = ""
  local rq = { 
    connectTimeout = 60000,
    readTimeout = 60000,
    method = "POST", 
    url = "https://api.openai.com/v1/chat/completions", 
    contentType= "application/json; charset=UTF-8", 
    authorization = "Bearer " .. openai_api_key
  } 
  
  local data = {
    model = "gpt-3.5-turbo",
    temperature = temperature,
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

local text = [[
You should express what you want a model to do by \ 
providing instructions that are as clear and \ 
specific as you can possibly make them. \ 
This will guide the model towards the desired output, \ 
and reduce the chances of receiving irrelevant \ 
or incorrect responses. Don't confuse writing a \ 
clear prompt with writing a short prompt. \ 
In many cases, longer prompts provide more clarity \ 
and context for the model, which can lead to \ 
more detailed and relevant outputs.
]]

local prompt = [[
Summarize the text delimited by triple backticks \ 
into a single sentence.
Print the summary in English and German.
```{text}```
]]

prompt = prompt:gsub("{text}", text) 

response = get_completion(prompt)
print(response)

