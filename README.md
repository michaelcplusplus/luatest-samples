# luatest-samples

# Table of contents
1. [Introduction](#introduction)
2. [App API](#app_api)
3. [HTTP API](#http_api)
4. [OAuth2 API](#oauth2_api)
5. [MQTT API](#mqtt_api)
6. [SQLite API](#sqlite_api)
7. [JSON API](#json_api)
8. [JSON Form API](#jsonform_api)
9. [Examples](#examples)  
9.1 [AI Chat](#example_chat)  
9.2 [JSON form](#example_jsonform)
10. [AI integration examples](#ai_examples)

## Introduction <a name="introduction"></a>
Sample files for the Android app LuaTest, see Google playstore https://play.google.com/store/apps/details?id=de.mlauer.luatest  
The app runs Lua scripts on-device, with a native API for HTTP, MQTT, SQLite, JSON, forms and more.

## App API <a name="app_api"></a>
* app.toast()
* app.speak()
* app.msleep()
* app.time() / app.timeEnd()
* app.utcNow()
* app.dir()
* app.cacheDir()
* app.tojson()
* app.inputForm()
* app.inplaceForm()
* app.qrCode()
* app.jwtEncode()
* app.base64UrlToBase64()
* app.openAiApiKey()
* app.palmApiKey()
* app.error()
* app.intent()
* app.printMarkdown()

**app.toast(text)**  
Shows an Android toast message

**app.speak(text, languageCode)**  
Speaks the given text using the Android text-to-speech engine
* `text` text to speak, `String`
* `languageCode` e.g. `"en"`, `"de"`, `String`

**app.msleep(millis)**  
Sleeps for the specified number of milliseconds

**app.time()** / **app.timeEnd()**  
Starts / stops a timer you can use to track how long an operation takes; `app.timeEnd()` returns the elapsed time in milliseconds

**app.utcNow()**  
Returns the current UTC time

**app.dir()**  
Returns the absolute path to the directory on the primary shared/external storage device where the app can place persistent files it owns

**app.cacheDir()**  
Returns the absolute path to the app-specific cache directory on the primary shared/external storage device

**app.tojson(table)**  
Converts a Lua table to a JSON string

**app.inputForm(title, [initial])**  
Opens an input dialog and returns the entered value
* `title` title of the dialog, `String`
* `initial` optional default value of the input field, `String`

**app.inplaceForm(initial)**  
Same as `app.inputForm`, but renders the input inline instead of as a dialog

**app.qrCode(text)**  
Displays a QR code for the given text

**app.jwtEncode(alg, payloadJson, [secret], [secretIsBase64])**  
Encodes a JWT
* `alg` signing algorithm, e.g. `"HS256"` or `"none"`, `String`
* `payloadJson` JWT payload, `JSON - String`
* `secret` optional signing secret, `String`
* `secretIsBase64` optional, whether `secret` is already base64 encoded, `Boolean`

**app.base64UrlToBase64(str)**  
Converts a base64url-encoded string to standard base64

**app.openAiApiKey()** / **app.palmApiKey()**  
Read the OpenAI / Google API key configured in the app's Preferences, so scripts don't need to hardcode secrets

**app.error(text)**  
Prints an error message

**app.intent(url)**  
Opens the given URL/intent, e.g. in the system browser

**app.printMarkdown(text)**  
Renders the given text as Markdown

[Example file app_specific_example.lua](/samples/app/app_specific_example.lua)  
[Example file app_input_form_example.lua](/samples/app/app_input_form_example.lua)  
[Example file app_qrcode_example.lua](/samples/app/app_qrcode_example.lua)

## HTTP API <a name="http_api"></a>
* app.httprequest()

**app.httprequest(rq)**  
Executes an HTTP/HTTPS request and returns `statuscode, content`
* `rq` request options, `Table`, with fields:
  * `url` request URL, `String`
  * `method` HTTP method, e.g. `"GET"`, `"POST"`, `String`
  * `queryParams` list of `{key, value}` tables appended as query parameters
  * `headerData` list of `{key, value}` tables sent as request headers
  * `contentType` value of the `Content-Type` header, `String`
  * `authorization` value of the `Authorization` header, e.g. `"Bearer <token>"`, `String`
  * `basicAuth` `{username, password}` table for HTTP basic auth
  * `rawData` raw request body, `String`
  * `multiPartFormData` list of parts for `multipart/form-data` uploads, each a table with `name` (mandatory), `value` (mandatory; prefix with `@` for a local file path), `filename` (optional) and `contentType` (optional)
  * `connectTimeout` / `readTimeout` timeouts in milliseconds

[Example file http_get_example.lua](/samples/http/http_get_example.lua)  
[Example file http_post_example.lua](/samples/http/http_post_example.lua)  
[Example file http_multipart_example.lua](/samples/http/http_multipart_example.lua)  
[Example file httpbin_basicauth_example.lua](/samples/http/httpbin_basicauth_example.lua)  
[Example file httpbin_bearerauth_example.lua](/samples/http/httpbin_bearerauth_example.lua)  
[Example file httpbin_headers_example.lua](/samples/http/httpbin_headers_example.lua)

## OAuth2 API <a name="oauth2_api"></a>
* oauth2.onAuthorizationCode()
* oauth2.generateCodeVerifier()
* oauth2.getCodeChallange()

**oauth2.onAuthorizationCode(callback)**  
Registers a callback fired when the authorization redirect delivers a code
* `callback - function (code)`

**oauth2.generateCodeVerifier()**  
Generates a PKCE code verifier, `String`

**oauth2.getCodeChallange(verifier)**  
Derives the PKCE code challenge (S256) for the given code verifier
* `verifier` code verifier, `String`

[Example file http_oauth2_example.lua](/samples/http/http_oauth2_example.lua)  
[Example file http_oauth2_pkce_example.lua](/samples/http/http_oauth2_pkce_example.lua)

## MQTT API <a name="mqtt_api"></a>
* mqtt.connect()
* mqtt.publish()
* mqtt.subscribe()
* mqtt.unsubscribe()
* mqtt.unsubscribeAll()
* mqtt.disconnect()
* mqtt.onMqttMessage()

**mqtt.connect(options)**  
Connects to the broker specified by `options`
* `options` `Table`, with fields:
  * `brokerUrl` broker URL, `String`, e.g. `"tcp://broker.emqx.io:1883"` or `"ssl://broker.emqx.io:8883"`
  * `clientId` id of the client, `String`
  * `username` / `password` optional broker credentials, `String`
  * `useSSL` whether to use SSL, `Boolean`
  * `cleanSession` (v3) / `cleanStart` (v5) start a clean session, `Boolean`
  * MQTT v5 (`require "mqtt5"`) additionally supports `automaticReconnect`, `sessionExpiryInterval`, `willPayload`, `willTopic`, `willQos`, `willRetain`

**mqtt.publish(topic, payload, qos, retain, [properties])**  
Publishes a message to a topic
* `topic` topic to publish to, `String`
* `payload` message to publish, `String`
* `qos` QoS level, `Number` (0|1|2)
* `retain` retain flag, `Boolean`
* `properties` MQTT v5 only, `Table`, e.g. `contentType`, `messageExpiryInterval`, `userProperties`

**mqtt.subscribe(topic, qos)**  
Subscribes to a topic
* `topic` topic to subscribe to, `String`
* `qos` QoS level, `Number` (0|1|2)

**mqtt.unsubscribe(topic)** / **mqtt.unsubscribeAll()**  
Unsubscribes from a topic, or from all topics

**mqtt.disconnect()**  
Disconnects from the broker

**mqtt.onMqttMessage(callback)**  
Registers a callback fired when a message arrives
* `callback - function (topic, payload, [properties])` (`properties` for MQTT v5 only)

[Example file mqtt_example.lua](/samples/mqtt/mqtt_example.lua)  
[Example file mqtts_example.lua](/samples/mqtt/mqtts_example.lua)  
[Example file mqttsv5_example.lua](/samples/mqtt/mqttsv5_example.lua)

## SQLite API <a name="sqlite_api"></a>
* sqlite3.open_memory()
* sqlite3.open()
* db:exec()
* db:nrows()
* db:errmsg()
* db:close()

**sqlite3.open_memory()** / **sqlite3.open(path)**  
Opens an in-memory database, or a database file at `path`, `String`

**db:exec(sql)**  
Executes one or more SQL statements

**db:nrows(sql)**  
Returns an iterator over the result rows of a `SELECT` statement, each row a `Table` keyed by column name

**db:errmsg()**  
Returns the error message of the most recent operation

**db:close()**  
Closes the database

[Example file sqlite_memory_example.lua](/samples/sqlite/sqlite_memory_example.lua)  
[Example file sqlite_persist_example.lua](/samples/sqlite/sqlite_persist_example.lua)

## JSON API <a name="json_api"></a>
* cjson.encode()
* cjson.decode()

**cjson.encode(table)**  
Converts a Lua table to a JSON string (equivalent to `app.tojson`)

**cjson.decode(jsonString)**  
Parses a JSON string into a Lua table

[Example file cjson_example.lua](/samples/csjon/cjson_example.lua)

## JSON Form API <a name="jsonform_api"></a>
* app.jsonForm()

**app.jsonForm(jsonSchema)**  
Renders a native multi-field form described by a JSON schema and returns the submitted values
* `jsonSchema` `JSON - String`, with a `form` object containing:
  * `title` form title, `String`
  * `fields` list of field definitions, each with `name`, `label`, `type` (e.g. `"text"`, `"choice"`, `"numeric"`, `"checkbox"`, `"divider"`), `required`, `initial`, and, for `"choice"` fields, `options` (`|`-separated string)

[Example file json_form.lua](/samples/jsonform/json_form.lua)

## Examples <a name="examples"></a>
## AI chat example <a name="example_chat"></a>
![Alt text](/screenshots/chat.gif?raw=true "AI chat")
## JSON form example <a name="example_jsonform"></a>
![Alt text](/screenshots/form.gif?raw=true "JSON form")

## AI integration examples <a name="ai_examples"></a>
These samples don't add new API surface — they show how to call third-party AI chat completion APIs using the [HTTP API](#http_api) above.

[Example file openai_prompt.lua](/samples/openai/openai_prompt.lua)  
[Example file openai_chatbot.lua](/samples/openai/openai_chatbot.lua)  
[Example file googlegemini_prompt.lua](/samples/googlegemini/googlegemini_prompt.lua)  
[Example file googlegemini_chatbot.lua](/samples/googlegemini/googlegemini_chatbot.lua)
