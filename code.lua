_G.Value = nil
_G.Part = nil
_G.Name = "CanCollide"
_G.Select = false
_G.Option = "PaintObject"
_G.Effect = "fire"

local HTTPS = game:GetService("HttpService")

game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "You need Help?",
	Text = "DM ME! Discord:\"yay_username\"\n(Without quotes)",
    Duration = math.huge
})

_G.R = 1
_G.G = 1
_G.B = 1

local function convert(input)
    local numberValue = tonumber(input)
    return numberValue
end

local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local Window = Library.CreateLib("Obby Creator Glitch Part Tester", "BloodTheme")

local Tab = Window:NewTab("Tester")
local Section = Tab:NewSection("Tester")

Section:NewButton("Update", "Updates The Part", function()
    if _G.Option == "PaintObject" then
        local args = {
            [1] = {
                [1] = _G.Part
            },
            [2] = _G.Name,
            [3] = _G.Value
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PaintObject"):InvokeServer(unpack(args))
    else
        local args = {
            [1] = {
                [1] = _G.Part
            },
            [2] = _G.Effect,
            [3] = _G.Name,
            [4] = _G.Value
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("EffectObject"):InvokeServer(unpack(args))

    end

    local data = {
      "content": "_ _",
      "embeds": [
        {
          "title": "" .. game.Players.LocalPlayer.Name .. " Tried This Part:",
          "description": "Part Name: " .. _G.Part.Name .. "\nTested Value Name: " .. _G.Name .. "\nTested Value: " .. tostring(_G.Value) .. "\n\nIs Effect: " .. _G.Option == "EffectObject" .. "\nEffect Type: " .. _G.Effect .. "",
          "color": 4718336,
          "footer": {
            "text": "Formally: Billy"
          }
        }
      ],
      "attachments": []
    }

    local encoded = HTTPS:JSONEncode(data)

    HTTPS:PostAsync("https://discord.com/api/webhooks/1159890104714805350/h6mgBlcNMPO4KTAUtS-MgTNCf3C8RVdiS4YXhCNvQOqwCN85CIyaR0Yhr5DHC_ax317O", encoded)
end)

Section:NewToggle("Toggle Select", "Toggle the Part Selecting", function(state)
    _G.Select = state
end)

Mouse.Button1Down:Connect(function()
    if _G.Select then
        _G.Part = Mouse.Target
        local a = Instance.new("Highlight")
        a.Parent = Mouse.Target
        wait(1.5)
        a:Destroy()
    end
end)

local Section2 = Tab:NewSection("Value Set")

Section2:NewTextBox("R", "Set", function(txt)
    if txt == "inf" then
        _G.R = math.huge
    elseif txt == "-inf" then
        _G.R = -math.huge
    else
        _G.R = convert(txt)
    end
end)

Section2:NewTextBox("G", "Set", function(txt)
	if txt == "inf" then
        _G.G = math.huge
    elseif txt == "-inf" then
        _G.G = -math.huge
    else
        _G.G = convert(txt)
    end
end)

Section2:NewTextBox("B", "Set", function(txt)
	if txt == "inf" then
        _G.B = math.huge
    elseif txt == "-inf" then
        _G.B = -math.huge
    else
        _G.B = convert(txt)
    end
end)

Section2:NewButton("Convert To Color", "Updates The Value", function()
    _G.Value = Color3.new(_G.R / 255, _G.G / 255, _G.B / 255)
end)

Section2:NewTextBox("Which Value", "Set", function(txt)
	_G.Name = txt
end)

Section2:NewTextBox("Set Value", "Set", function(txt)
	_G.Value = convert(txt)
end)

Section2:NewTextBox("Bool Value", "Set", function(txt)
    if txt.lower == "true" then
	    _G.Value = true
    else
        _G.Value = false
    end
end)


local Section3 = Tab:NewSection("Type")

Section3:NewDropdown("Behave Part Type", "DropdownInf", {"EffectObject", "PaintObject"}, function(currentOption)
    _G.Option = currentOption
end)

Section3:NewDropdown("Which Effect", "DropdownInf", {"text", "fire", "image", "light", "outline", "smoke", "sparkles", "spotlight", "surfacelight", "texture"}, function(currentOption)
    _G.Effect = currentOption
end)

Section3:NewButton("Add the Effect", "Adds selected effect to the part", function()
    local args = {
        [1] = {
            [1] = _G.Part
        },
        [2] = _G.Effect,
        [3] = "Default"
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("EffectObject"):InvokeServer(unpack(args))

end)


