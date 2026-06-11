--cool little script that copies A-Train from The Boys
--if someone uses this (unlikely) at least give credit to me, thanks!

return (function()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")

    local ZOOM_ID = "rbxassetid://77807683763606" 
    local CANT_STOP_ID = "rbxassetid://125117454142800"

    local function playSound(id)
        local s = Instance.new("Sound")
        s.SoundId = id
        s.Parent = root
        s.Volume = 1
        s:Play()
        s.Ended:Connect(function() s:Destroy() end)
    end

    if _G.ATrainActive then
        -- STOPPING
        _G.ATrainActive = false
        hum.WalkSpeed = 16
        if _G.ZoomSound then _G.ZoomSound:Stop(); _G.ZoomSound:Destroy() end
        playSound(CANT_STOP_ID)
        print("A-Train Disabled")
    else
        -- STARTING
        _G.ATrainActive = true
        hum.WalkSpeed = 250
        
        _G.ZoomSound = Instance.new("Sound")
        _G.ZoomSound.SoundId = ZOOM_ID
        _G.ZoomSound.Parent = root
        _G.ZoomSound.Looped = true
        _G.ZoomSound:Play()
        
        print("A-Train Enabled")
    end
end)()
