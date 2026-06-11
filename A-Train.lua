--cool little script that copies A-Train from The Boys
--if someone uses this (unlikely) at least give credit to me, thanks!

return (function()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    local Lighting = game:GetService("Lighting")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local Camera = workspace.CurrentCamera

    -- effects
    local blur = Lighting:FindFirstChild("SpeedBlur") or Instance.new("DepthOfFieldEffect", Lighting)
    blur.Name = "SpeedBlur"; blur.Enabled = false; blur.FarIntensity = 0.5; blur.InFocusRadius = 10

    local cc = Lighting:FindFirstChild("TimeStop") or Instance.new("ColorCorrectionEffect", Lighting)
    cc.Name = "TimeStop"; cc.Enabled = false; cc.Saturation = 0

    local function createTrail(part)
        local att = Instance.new("Attachment", part)
        local p = Instance.new("ParticleEmitter", att)
        p.Texture = "rbxassetid://6031093370"; p.Rate = 50; p.Lifetime = NumberRange.new(0.5); p.Enabled = false
        return p
    end
    local leftTrail = char:FindFirstChild("Left Leg") and createTrail(char["Left Leg"])
    local rightTrail = char:FindFirstChild("Right Leg") and createTrail(char["Right Leg"])

    local ZOOM_ID = "rbxassetid://77807683763606" 
    local CANT_STOP_ID = "rbxassetid://125117454142800"
    local lastSoundTime = 0

    if _G.ATrainActive then
        -- DISABLE MODE
        _G.ATrainActive = false; hum.WalkSpeed = 16
        blur.Enabled = false; cc.Enabled = false
        if leftTrail then leftTrail.Enabled = false end
        if rightTrail then rightTrail.Enabled = false end
        if _G.ZoomConnection then _G.ZoomConnection:Disconnect() end
        if _G.HitboxConnection then _G.HitboxConnection:Disconnect() end
        
        TweenService:Create(Camera, TweenInfo.new(0.5), {FieldOfView = 70}):Play()
        TweenService:Create(cc, TweenInfo.new(0.5), {Saturation = 0}):Play()

        local s = Instance.new("Sound", root); s.SoundId = CANT_STOP_ID; s:Play()
        s.Ended:Connect(function() s:Destroy() end)
    else
        -- ENABLE MODE
        _G.ATrainActive = true; hum.WalkSpeed = 250
        cc.Enabled = true
        TweenService:Create(Camera, TweenInfo.new(0.5), {FieldOfView = 110}):Play()
        TweenService:Create(cc, TweenInfo.new(0.5), {Saturation = -1}):Play()

        -- Hitbox logic
        _G.HitboxConnection = RunService.Heartbeat:Connect(function()
            local params = OverlapParams.new(); params.FilterDescendantsInstances = {char}
            local parts = workspace:GetPartsInPart(root, params)
            for _, p in pairs(parts) do
                if p.Parent:FindFirstChild("Humanoid") and p.Parent ~= char then
                    p.Parent.HumanoidRootPart.AssemblyLinearVelocity = root.CFrame.LookVector * 100
                end
            end
        end)

        -- Movement/Sound Logic
        _G.ZoomConnection = hum.Running:Connect(function(speed)
            local isMoving = speed > 0.5
            blur.Enabled = isMoving
            if leftTrail then leftTrail.Enabled = isMoving end
            if rightTrail then rightTrail.Enabled = isMoving end
            
            if isMoving and (tick() - lastSoundTime > 3) then
                lastSoundTime = tick()
                local zoom = Instance.new("Sound", root)
                zoom.SoundId = ZOOM_ID; zoom.PlayOnRemove = true; zoom:Play()
                game:GetService("Debris"):AddItem(zoom, 5)
            end
        end)
    end
end)()
