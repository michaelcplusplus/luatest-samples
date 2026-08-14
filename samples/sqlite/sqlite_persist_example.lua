local sqlite3 = require("lsqlite3")

local db = sqlite3.open(app.dir() .. "/foo.db")

db:exec[[
  CREATE TABLE test (id INTEGER PRIMARY KEY AUTOINCREMENT, content);
]]

print(db:errmsg())

db:exec[[
  INSERT INTO test (content) VALUES ('Hello World');
]]

print(db:errmsg())

for row in db:nrows("SELECT * FROM test") do
  print(row.id, row.content)
end

db:close()
    
