local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robojini/Tuturial_UI_Library/main/UI_Template_1"))()

local Window = Library.CreateLib("Bt.HUB", "RJTheme3")

local Combat = Window:NewTab("Combat")
local Visual = Window:NewTab("Visuals")
local Mics = Window:NewTab("Mics")

local SectionCombat1 = Combat:NewSection("Aimbot")
local SectionVisuals = Visual:NewSection("ESP")
local SectionMics = Mics:NewSection("Mics")

SectionCombat1:NewButton("Aimbot", "ХЗ", function()
   loadstring(game:HttpGet("https://pastebin.com/raw/ygp8Enye"))()
end)

SectionVisuals:NewButton("ESP", "ХЗ", function()
   pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua'))() end)
end)

SectionMics:NewButton("FOV change C", "ХЗ", function()
    local oldZoom = game.Workspace.CurrentCamera.FieldOfView

    local Settings = {
    ZoomTime = 0.2,
    ZoomedAmount = 10
    }

    local function createZoom(time, amount)
       local Tween_Info = TweenInfo.new(time, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut) 
       local Tween = game:GetService("TweenService"):Create(game.Workspace.CurrentCamera, Tween_Info, {FieldOfView = amount})
    return Tween
    end

    game:GetService("UserInputService").InputBegan:Connect(function(input)
       if input.KeyCode == Enum.KeyCode.C then
        createZoom(Settings.ZoomTime, Settings.ZoomedAmount):Play()
     end
   end)

   game:GetService("UserInputService").InputEnded:Connect(function(input)
       if input.KeyCode == Enum.KeyCode.C then
           createZoom(Settings.ZoomTime, oldZoom):Play()
       end
   end)
end)

SectionMics:NewButton("Infinite yield...Админка", "ХЗ", function()
   loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

SectionMics:NewButton("DEX", "ХЗ", function()
   loadstring(game:GetObjects("rbxassetid://418957341")[1].Source)()
end)
