local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/elsiahrekeno/reductui/main/source.lua"))()
local Window = Library.Window({
	Title = "Your UI Title"
})

local Category = Window.Category({
	Title = "Your Category Title"
})

Category.Label({
	Title = "Your TextLabel"
})	

Category.Button({
	Title = "Your button",
	Callback = function()
	  print("You clicked me!")
end
})

Category.Toggle({
	Title = "Your toggle",
	Callback = function(value)
	  print(value)
-- returns true/false
end,
	Default = true -- can be true or false
-- the Default for the default value is false
})

Category.Slider({
	Title = "Your slider",
	Min = 16, -- default is 16
	Max = 500, -- default is 500
	Callback = function(value)
	  print(value)
end
})

Category.Keybind({
	Title = "Your keybind",
	KeyCode = Enum.KeyCode.F,-- default is F
	Callback = function()
	  print("you pressed f!")
end
})

Category.Textbox({
	Title = "Your textbox",
	PlaceholderText = "Test", -- default is F -- default is nil
	Callback = function(v)
	 print(v) -- returns what they typed in the textbox.
end
})

Category.Dropdown({
	Title = "Your dropdown",
	Items = {
	  "List Items Here",
	  "List Items Here",
	  "List Items Here",
},
	Callback = function(v)
	 print(v) -- returns what they picked in the dropdown.
end
})
