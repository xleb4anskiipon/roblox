local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Player = game.Players.LocalPlayer
local Window = OrionLib:MakeWindow({Name = "Key system BT.Hub", HidePremium = false, SaveConfig = true, IntroEnabled = false})
local Camera = workspace.CurrentCamera

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Holding = false

_G.AimbotEnabled = false
_G.TeamCheck = false
_G.AimPart = "Head"
_G.Sensitivity = 0

_G.CircleSides = 64
_G.CircleColor = Color3.fromRGB(255, 255, 255)
_G.CircleTransparency = 0.7 
_G.CircleRadius = 80 
_G.CircleFilled = false
_G.CircleVisible = false 
_G.CircleThickness = 0

local FOVCircle = Drawing.new("Circle")
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Filled = _G.CircleFilled
FOVCircle.Color = _G.CircleColor
FOVCircle.Visible = _G.CircleVisible
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Transparency = _G.CircleTransparency
FOVCircle.NumSides = _G.CircleSides
FOVCircle.Thickness = _G.CircleThickness

OrionLib:MakeNotification({
	Name = "Ты зареган",
	Content = "Ты зареган под ником "..Player.Name.." ",
	Image = "rbxassetid://4483345998",
	Time = 5
})

_G.Key = "ENVEWJ.~-rFGf@j^xewsEvMiuthVe@WL3KBd%ePV"
_G.KeyInput = "string"

----ОСНОВА
function MakeScriptHub()
   local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
   local Window = OrionLib:MakeWindow({Name = "BT.Hub", HidePremium = false, SaveConfig = true, IntroEnabled = false})

-----COMBAT
   local Combat = Window:MakeTab({
	Name = "Combat",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
   })
   
   Combat:AddToggle({
	Name = "Aimbot",
	Default = false,
	Callback = function(Value)
	  if Value == true then
          _G.AimbotEnabled = true
          _G.CircleVisible = true
      else
          _G.AimbotEnabled = false
          _G.CircleVisible = false
      end
    end
    })
   
   Combat:AddSlider({
	Name = "Aimbot FOV",
	Min = 50,
	Max = 300,
	Default = 5,
	Color = Color3.fromRGB(139,0,255),
	Increment = 1,
	ValueName = "FOV",
	Callback = function(Value)
		_G.CircleRadius = Value
	end    
   })

   Combat:AddColorpicker({
	Name = "FOV Color",
	Default = Color3.fromRGB(255, 255, 255),
	Callback = function(Value)
	    _G.CircleColor = Value
	end	  
    })

    Combat:AddSlider({
	Name = "Thickness FOV",
	Min = 1,
	Max = 5,
	Default = 0,
	Color = Color3.fromRGB(139,0,255),
	Increment = 0.1,
	ValueName = "Size",
	Callback = function(Value)
		_G.CircleThickness = Value
	end  
    })

    Combat:AddDropdown({
	Name = "AimPart",
	Default = "Head",
	Options = {"Head", "HumanoidRootPart"},
	Callback = function(Value)
		_G.AimPart = Value
	end    
    })

    ------КОНЕЦ КОМБАТА
end
---КОНЕЦ ОСНОВЫ
function Destroy()
   game:GetService("CoreGui").Orion:Destroy()
end

local Tab = Window:MakeTab({
	Name = "Ключ",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddTextbox({
	Name = "Введите ключ",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
	    _G.KeyInput = Value
	end	  
})

Tab:AddButton({
	Name = "Проверить ключ",
	Callback = function()
      		if _G.KeyInput == _G.Key then
            MakeScriptHub()
        end
  	end    
})

----АИМБОТ
local function GetClosestPlayer()
	local MaximumDistance = _G.CircleRadius
	local Target = nil

	for _, v in next, Players:GetPlayers() do
		if v.Name ~= LocalPlayer.Name then
			if _G.TeamCheck == true then
				if v.Team ~= LocalPlayer.Team then
					if v.Character ~= nil then
						if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
							if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
								local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
								local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
								
								if VectorDistance < MaximumDistance then
									Target = v
								end
							end
						end
					end
				end
			else
				if v.Character ~= nil then
					if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
						if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
							local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
							local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
							
							if VectorDistance < MaximumDistance then
								Target = v
							end
						end
					end
				end
			end
		end
	end

	return Target
end

UserInputService.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = true
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = false
    end
end)

RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
    FOVCircle.Radius = _G.CircleRadius
    FOVCircle.Filled = _G.CircleFilled
    FOVCircle.Color = _G.CircleColor
    FOVCircle.Visible = _G.CircleVisible
    FOVCircle.Radius = _G.CircleRadius
    FOVCircle.Transparency = _G.CircleTransparency
    FOVCircle.NumSides = _G.CircleSides
    FOVCircle.Thickness = _G.CircleThickness

    if Holding == true and _G.AimbotEnabled == true then
        TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, GetClosestPlayer().Character[_G.AimPart].Position)}):Play()
    end
end)
