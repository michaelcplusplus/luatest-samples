cjson = require "cjson"

local formData = {
  form = {
    title = "Conference Online Registration",
    fields = {
      {
        name = "fname",
        label = "First Name",
        type = "text",
        required = true,
        initial = "John"
      },
      {
        name = "lname",
        label = "Last Name",
        type = "text",
        required = true
      },
      {
        name = "gender",
        label = "Gender",
        type = "choice",
        required = true,
        options = "Male|Female|Diverse"
      },
      {
        name = "age",
        label = "Age",
        type = "numeric",
        required = false
      },
      {
        name = "city",
        label = "City",
        type = "text"
      },
      {
        type = "divider"
      },
      {
        name = "firsttime",
        label = "First time to attend conference?",
        type = "checkbox",
        initial = "checked"
      },
    }
  }
}
formDataResult = app.jsonForm(cjson.encode(formData))

print(formDataResult)



