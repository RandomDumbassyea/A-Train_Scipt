--cool little script that copies A-Train from The Boys
--if someone uses this (unlikely) at least give credit to me, thanks!

return (function()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    local Lighting = game:GetService("Lighting")

    -- Blur 
    local blur = Lighting:FindFirstChild("SpeedBlur")
    if not blur then
        blur = Instance.new("DepthOfFieldEffect", Lighting)
        blur.Name = "SpeedBlur"
        blur.FarIntensity = 0.5
        blur.InFocusRadius = 10
        blur.Enabled = false
    end

    -- Particles
    local function createTrail(part)
        local attachment = Instance.new("Attachment", part)
        local p = Instance.new("ParticleEmitter", attachment)
        p.Name = "SpeedTrail"
        p.Texture = "rbxassetid://6031093370"
        p.Rate = 50
        p.Lifetime = NumberRange.new(0.5)
        p.Enabled = false
        return p
    end

    -- Ensure legs exist before adding trails
    local leftTrail = char:FindFirstChild("Left Leg") and createTrail(char["Left Leg"])
    local rightTrail = char:FindFirstChild("Right Leg") and createTrail(char["Right Leg"])

    local ZOOM_ID = "rbxassetid://77807683763606" 
    local CANT_STOP_ID = "rbxassetid://125117454142800"

    if _G.ATrainActive then
        -- DISABLE MODE
        _G.ATrainActive = false
        hum.WalkSpeed = 16
        
        -- Stop everything
        blur.Enabled = false
        if leftTrail then leftTrail.Enabled = false end
        if rightTrail then rightTrail.Enabled = false end
        if _G.ZoomConnection then _G.ZoomConnection:Disconnect() end
        if root:FindFirstChild("ZoomSound") then root.ZoomSound:Destroy() end

        -- Play Stop Sound
        local s = Instance.new("Sound", root)
        s.SoundId = CANT_STOP_ID
        s:Play()
        s.Ended:Connect(function() s:Destroy() end)
    else
        -- ENABLE MODE
        _G.ATrainActive = true
        hum.WalkSpeed = 250
        
        -- Create the sound once
        local zoom = Instance.new("Sound", root)
        zoom.Name = "ZoomSound"
        zoom.SoundId = ZOOM_ID
        zoom.Looped = false 
        
        -- Link everything to movement
        _G.ZoomConnection = hum.Running:Connect(function(speed)
            local isMoving = speed > 0.5
            blur.Enabled = isMoving
            if leftTrail then leftTrail.Enabled = isMoving end
            if rightTrail then rightTrail.Enabled = isMoving end
            
            if isMoving then
                if not zoom.IsPlaying then zoom:Play() end
            else
                zoom:Pause()
            end
        end)
    end
end)()