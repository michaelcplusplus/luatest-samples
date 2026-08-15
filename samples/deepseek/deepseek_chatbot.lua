json = require "cjson"

local api_key = "sk-..."

function get_completion_from_messages(messages, temperature)
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
    messages = messages
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

local context = {{
  role = "system",
  content = [[
You are OrderBot, an automated service to collect orders for a pizza restaurant. \
You first greet the customer, then collects the order, \
and then asks if it's a pickup or delivery. \
You wait to collect the entire order, then summarize it and check for a final \
time if the customer wants to add anything else. \
If it's a delivery, you ask for an address. \
Finally you collect the payment.\
Make sure to clarify all options, extras and sizes to uniquely \
identify the item from the menu.\
You respond in a short, very conversational friendly style. \
The menu includes \
pepperoni pizza  12.95, 10.00, 7.00 \
cheese pizza   10.95, 9.25, 6.50 \
eggplant pizza   11.95, 9.75, 6.75 \
fries 4.50, 3.50 \
greek salad 7.25 \
Toppings: \
extra cheese 2.00, \
mushrooms 1.50 \
sausage 3.00 \
canadian bacon 3.50 \
AI sauce 1.50 \
peppers 1.00 \
Drinks: \
coke 3.00, 2.00, 1.00 \
sprite 3.00, 2.00, 1.00 \
bottled water 5.00 \
]]
}}


function collect_messages(context)  
  table.insert(context, {role="user", content=""})
  response = get_completion_from_messages(context) 
  table.insert(context, {role="assistant", content=response})  
  app.error("Assistant: " .. response)

  prompt = app.inplaceForm("Hi I would like to order a pizza")
  repeat     
    print("User: " .. prompt)
    table.insert(context, {role="user", content=prompt})
    response = get_completion_from_messages(context) 
    table.insert(context, {role="assistant", content=response})
    app.error("Assistant: " .. response)
    prompt = app.inplaceForm("")
  until (prompt == "")
end    

print("Please wait ...")

collect_messages(context)

table.insert(context, {
  role ="system", 
  content = [[
create a json summary of the previous food order. Itemize the price for each item\
 The fields should be 1) pizza, include size 2) list of toppings 3) list of drinks, include size   4) list of sides include size  5)total price
]]
})

response = get_completion_from_messages(context)
print(response)
