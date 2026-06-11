--cool little script that copies A-Train from The Boys
--if someone uses this (unlikely) at least give credit to me, thanks!

return (function()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")

    -- Updated IDs
    local ZOOM_ID = "rbxassetid://77807683763606" 
    local CANT_STOP_ID = "rbxassetid://125117454142800"

    -- Function to play the "I Can't Stop" clip
    local function playStopSound()
        local s = Instance.new("Sound", root)
        s.SoundId = CANT_STOP_ID
        s.Volume = 1
        s:Play()
        s.Ended:Connect(function() s:Destroy() end)
    end

    if _G.ATrainActive then
        -- DISABLE MODE
        _G.ATrainActive = false
        hum.WalkSpeed = 16
        
        -- Clean up connections and sounds
        if _G.ZoomConnection then _G.ZoomConnection:Disconnect() end
        local existingZoom = root:FindFirstChild("ZoomSound")
        if existingZoom then existingZoom:Destroy() end
        
        playStopSound()
        print("A-Train Disabled")
    else
        -- ENABLE MODE
        _G.ATrainActive = true
        hum.WalkSpeed = 250
        
        -- Create the sound object
        local zoom = Instance.new("Sound", root)
        zoom.Name = "ZoomSound"
        zoom.SoundId = ZOOM_ID
        zoom.Looped = true
        zoom.Volume = 0.5
        
        -- Listen for movement
        _G.ZoomConnection = hum.Running:Connect(function(speed)
            if speed > 0.5 then
                if not zoom.IsPlaying then zoom:Play() end
            else
                if zoom.IsPlaying then zoom:Pause() end
            end
        end)
        print("A-Train Enabled")
    end
end)()