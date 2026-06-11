--cool little script that copies A-Train from The Boys
--if someone uses this (unlikely) at least give credit to me, thanks!

return (function()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    local Lighting = game:GetService("Lighting")

if not Lighting:FindFirstChild("SpeedBlur") then
    local blur = Instance.new("DepthOfFieldEffect", Lighting)
    blur.Name = "SpeedBlur"
    blur.FarIntensity = 0.5
    blur.InFocusRadius = 10
    blur.Enabled = false
end

local function createTrail(part)
    local p = Instance.new("ParticleEmitter", part)
    p.Name = "SpeedTrail"
    p.Texture = "rbxassetid://6031093370"
    p.Rate = 50
    p.Lifetime = NumberRange.new(0.5)
    p.Enabled = false
    return p
end
    local leftTrail = char:FindFirstChild("Left Leg") and createTrail(char["Left Leg"])
    local rightTrail = char:FindFirstChild("Right Leg") and createTrail(char["Right Leg"])

    local ZOOM_ID = "rbxassetid://77807683763606" 
    local CANT_STOP_ID = "rbxassetid://125117454142800"

    local isPlayingZoom = false

    if _G.ATrainActive then
        _G.ATrainActive = false
        hum.WalkSpeed = 16
        if _G.ZoomConnection then _G.ZoomConnection:Disconnect() end
        if root:FindFirstChild("ZoomSound") then root.ZoomSound:Destroy() end

        Lighting.SpeedBlur.Enabled = false
        if leftTrail then leftTrail.Enabled = false end
        if rightTrail then rightTrail.Enabled = false end

        local s = Instance.new("Sound", root)
        s.SoundId = CANT_STOP_ID
        s:Play()
        s.Ended:Connect(function() s:Destroy() end)
    else
        _G.ATrainActive = true
        hum.WalkSpeed = 250
        
        Lighting.Speedblur.Enabled = true
        if leftTrail then leftTrail.Enabled = true end
        if leftTrail then leftTrail.Enabled = true end

        local zoom = Instance.new("Sound", root)
        zoom.Name = "ZoomSound"
        zoom.SoundId = ZOOM_ID
        
        _G.ZoomConnection = hum.Running:Connect(function(speed)
            if speed > 0.5 then
                if not isPlayingZoom then
                    isPlayingZoom = true
                    zoom:Play()
                end
            else
                isPlayingZoom = false
                zoom:Stop()
            end
        end)
    end
end)()