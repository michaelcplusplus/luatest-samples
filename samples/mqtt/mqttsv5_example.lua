local mqtt = require("mqtt5")
local json = require("cjson")

i  = 0
function onMessage(topic, payload, properties)
  i = i + 1
  io.write(topic.."\n")
  io.write(payload.."\n")

  io.write(json.encode(properties).."\n")
end

local option = {
  brokerUrl = "ssl://broker.emqx.io:8883",
  clientId = "luatest3",
  --username = "mqtt",
  --password = "secret",
  cleanStart = false,
  automaticReconnect = true,
  sessionExpiryInterval = 86400,
  willPayload = "luatest is gone :-(",
  willTopic = "luatest/end",
  willQos = 1,
  willRetain = true
}

mqtt.connect(option)
mqtt.onMqttMessage(onMessage)
mqtt.subscribe("temp/random", 2)
app.msleep(100)

local properties = {
  contentType = "Text",
  messageExpiryInterval = 86400,
  -- responseInfo = "",
  -- responseTopic = "",
  userProperties = {
    hello = "world",
    xyz   = "12345"
  }
}

mqtt.publish(
  "temp/random",  --topic
  app.utcNow(),   --payload
  2,              --qos
  false,          --retained
  properties)

app.msleep(1000)
mqtt.disconnect()

io.write("finished: " .. i)
