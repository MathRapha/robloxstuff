local plr = game:GetService("Players").LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:FindFirstChildOfClass("Humanoid")
local camera = workspace.CurrentCamera
local mouse = plr:GetMouse()

local runService = game:GetService("RunService")
local coreGui = game.CoreGui
local uis = game:GetService("UserInputService")
local starterGui = game:GetService("StarterGui")

local stamina = 100

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "MathRapha's Forsaken Cheat UI",
	Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
	LoadingTitle = "Loading Cheat UI",
	LoadingSubtitle = "by MathRapha",
	Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

	DisableRayfieldPrompts = false,
	DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

	ConfigurationSaving = {
		Enabled = true,
		FolderName = nil, -- Create a custom folder for your hub/game
		FileName = "MathRaphaForsakenCheatUI"
	},

	Discord = {
		Enabled = true, -- Prompt the user to join your Discord server if their executor supports it
		Invite = "BtEXKRzy8W", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
		RememberJoins = true -- Set this to false to make them join the discord every time they load it up
	},

	KeySystem = false, -- Set this to true to use our key system
	KeySettings = {
		Title = "Untitled",
		Subtitle = "Key System",
		Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
		FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
		SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
		GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
		Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
	}
})

local aimbotSoundNames = {
	-- Chance --
	"rbxassetid://139012439429121"

	-- c00lkidd --
}

local toggles = {
	esp = {
		killer = false;
		survivor = false;

		elliotpizza = false;
	};

	customRunSpeed = false;
}
local variables = {
	customRunSpeed = 2;
}
local sprinting = false

local folders = {}
folders.players = workspace:WaitForChild("Players")
folders.killers = folders.players:WaitForChild("Killers")
folders.survivors = folders.players:WaitForChild("Survivors")

folders.map = workspace:WaitForChild("Map")
folders.ingamemap = folders.map:WaitForChild("Ingame")



local funcs = {

	esp = {}

}
funcs.esp.esp = function (v:Instance, color:BrickColor, transparency:number, customEspName:string, customEspSize:Vector3)
	if v:IsA("BasePart") then
		task.spawn(function ()
			local a = Instance.new("BoxHandleAdornment", camera)
			local nameForESP = v.Name.."_ESP"
			if customEspName ~= nil then
				nameForESP = customEspName.."_ESP"
			end
			a.Name = nameForESP
			a.Adornee = v
			a.AlwaysOnTop = true
			a.ZIndex = 1
			local sizeForESP = v.Size
			if customEspSize ~= nil then
				sizeForESP = customEspSize
			end
			a.Size = sizeForESP
			a.Transparency = transparency
			a.Color = color
		end)
	elseif v:IsA("Model") then
		task.spawn(function ()
			local a = Instance.new("BoxHandleAdornment", camera)
			local nameForESP = v.Name.."_ESP"
			if customEspName ~= nil then
				nameForESP = customEspName.."_ESP"
			end
			a.Name = nameForESP
			a.Adornee = v:FindFirstChild("HumanoidRootPart") or v.PrimaryPart or v
			a.AlwaysOnTop = true
			a.ZIndex = 1
			local sizeForESP = Vector3.new(1,1,1)
			if customEspSize ~= nil then
				sizeForESP = customEspSize
			end
			a.Size = sizeForESP
			a.Transparency = transparency
			a.Color = color
		end)
	end
end
funcs.esp.delete = function (name:string)
	for i,v in camera:GetChildren() do
		task.spawn(function ()
			if v:IsA("BoxHandleAdornment") and v.Name == name..'_ESP' then
				v:Destroy()
			end
		end)
	end
end

funcs.updateESP = function ()
	funcs.esp.delete("killer")
	funcs.esp.delete("survivor")
	funcs.esp.delete("elliotpizza")
	if toggles.esp.killer == true then
		for i,v in folders.killers:GetChildren() do
			pcall(function ()
				funcs.esp.esp(v, BrickColor.new("Really red"), 0.7, "killer", Vector3.new(2,5,2))
			end)
		end
	end
	if toggles.esp.survivor == true then
		for i,v in folders.survivors:GetChildren() do
			pcall(function ()
				funcs.esp.esp(v, BrickColor.new("Lime green"), 0.7, "survivor", Vector3.new(2,5,2))
			end)
		end
	end
	if toggles.esp.elliotpizza == true then
		for i,v in folders.ingamemap:GetChildren() do
			if v.Name == "Pizza" then
				pcall(function ()
					funcs.esp.esp(v, BrickColor.new("Red flip/flop"), 0.9, "elliotpizza", nil)
				end)
			end
		end
	end
end










--[[
/\/\/\/\/\/\/\/\/\/\/\/\
\/\/\/   PLAYER   \/\/\/
/\/\/\   tab      /\/\/\
\/\/\/\/\/\/\/\/\/\/\/\/
]]---

local Tab = Window:CreateTab("Player", 7992557358)

local Section = Tab:CreateSection("Advantage")

local Section = Tab:CreateSection("Run Speed")
local Toggle = Tab:CreateToggle({
	Name = "Custom Run Speed Multiplier Enabled",
	CurrentValue = false,
	Flag = "customRunSpeedToggle", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		toggles.customRunSpeed = Value
	end,
})
local Slider = Tab:CreateSlider({
	Name = "Custom Run Speed Multiplier",
	Range = {1, 5},
	Increment = 0.05,
	Suffix = "",
	CurrentValue = variables.customRunSpeed,
	Flag = "customRunSpeedMultiplier", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		variables.customRunSpeed = Value
	end,
})

--[[
/\/\/\/\/\/\/\/\/\/\/\/\
\/\/\/   VISUAL   \/\/\/
/\/\/\   tab      /\/\/\
\/\/\/\/\/\/\/\/\/\/\/\/
]]---

local Tab = Window:CreateTab("Visual", 7035631382)

local Section = Tab:CreateSection("ESP")
local Toggle = Tab:CreateToggle({
	Name = "Killer ESP",
	CurrentValue = false,
	Flag = "killerESP", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		toggles.esp.killer = Value
		funcs.updateESP()
	end,
})
local Toggle = Tab:CreateToggle({
	Name = "Survivor ESP",
	CurrentValue = false,
	Flag = "survivorESP", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		toggles.esp.survivor = Value
		funcs.updateESP()
	end,
})
--[[
local Toggle = Tab:CreateToggle({
	Name = "Elliot's Pizza ESP",
	CurrentValue = false,
	Flag = "elliotpizzaESP", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		toggles.esp.elliotpizza = Value
		funcs.updateESP()
	end,
})
]]

folders.killers.ChildAdded:Connect(funcs.updateESP)
folders.killers.ChildRemoved:Connect(funcs.updateESP)
folders.survivors.ChildAdded:Connect(funcs.updateESP)
folders.survivors.ChildRemoved:Connect(funcs.updateESP)

--[[
folders.ingamemap.ChildAdded:Connect(funcs.updateESP)
folders.ingamemap.ChildRemoved:Connect(funcs.updateESP)
]]

--[[
/\/\/\/\/\/\/\/\/\/\/\/\
\/\/\/  SETTINGS  \/\/\/
/\/\/\  tab       /\/\/\
\/\/\/\/\/\/\/\/\/\/\/\/
]]---

local Tab = Window:CreateTab("Settings", 7059346373)

local Button = Tab:CreateButton({
	Name = "Delete Script",
	Callback = function()
		Rayfield:Destroy()
		script:Destroy()
	end,
})



uis.InputBegan:Connect(function (input)
	local key = input.KeyCode
	if key == Enum.KeyCode.LeftShift then
		sprinting = true
	end
end)
uis.InputEnded:Connect(function (input)
	local key = input.KeyCode
	if key == Enum.KeyCode.LeftShift then
		sprinting = false
	end
end)

runService.RenderStepped:Connect(function ()
	local char = plr.Character
	local plrGui = plr.PlayerGui
	
	pcall(function ()
		local temporaryui = plrGui.TemporaryUI
		local playerInfo = temporaryui.PlayerInfo
		local bars = playerInfo.Bars
		local staminaBar = bars.Stamina
		local staminaAmount = staminaBar.Amount
		
		stamina = string.split(staminaAmount.Text, "/")[1]

		if toggles.customRunSpeed == true and sprinting == true and char ~= nil then
			local speedFolder:Folder = char:FindFirstChild("SpeedMultipliers")
			if speedFolder then
				local sprinting:NumberValue = speedFolder:FindFirstChild("Sprinting")
				if sprinting then
					sprinting.Value = variables.customRunSpeed
				end
			end
		end
	end)
end)

plr.CharacterAdded:Connect(function (newChar)
	char = newChar
	hum = newChar:FindFirstChildOfClass("Humanoid")
	local plrGui = plr.PlayerGui
	
	pcall(function ()
		local mainui = plrGui:WaitForChild("MainUI")
		local sprintbutton:ImageButton = mainui:WaitForChild("SprintingButton")
		sprintbutton.Activated:Connect(function ()
			sprinting = not sprinting
		end)
	end)
end)
