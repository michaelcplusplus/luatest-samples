local mqtt = require("mqtt")

function onMessage(topic, payload)
  io.write(topic.."\n")
  io.write(payload.."\n")
end

local option = {
  brokerUrl = "tcp://broker.emqx.io:1883",
  clientId = "luatest3",
  username = "mqtt",
  password = "secret",
  useSSL = false,
  cleanSession = true
}

mqtt.connect(option)
mqtt.onMqttMessage(onMessage)
mqtt.subscribe("temp/random", 0) -- topic, qos {0|1|2}
mqtt.publish("temp/random", "hello", 0, false) -- topic, payload, qos {0|1|2}, retained {true|false}

app.msleep(1000)
mqtt.unsubscribe("temp/random")
-- mqtt.unsubscribeAll()

mqtt.disconnect()

io.write("finished")