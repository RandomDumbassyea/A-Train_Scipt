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

    -- Effect Setup
    local blur = Lighting:FindFirstChild("SpeedBlur") or Instance.new("DepthOfFieldEffect", Lighting)
    blur.Name = "SpeedBlur"; blur.Enabled = false; blur.FarIntensity = 0.5; blur.InFocusRadius = 10

    local cc = Lighting:FindFirstChild("TimeStop") or Instance.new("ColorCorrectionEffect", Lighting)
    cc.Name = "TimeStop"; cc.Enabled = false; cc.Saturation = 0

    local isZooming = false
    local isEffectActive = false -- TRACKER: Prevents effect spam

    if _G.ATrainActive then
        -- DISABLE
        _G.ATrainActive = false; hum.WalkSpeed = 16
        if _G.HeartbeatConnection then _G.HeartbeatConnection:Disconnect() end
        
        -- Reset visuals once
        blur.Enabled = false; cc.Enabled = false
        TweenService:Create(Camera, TweenInfo.new(0.5), {FieldOfView = 70}):Play()
        TweenService:Create(cc, TweenInfo.new(0.5), {Saturation = 0}):Play()
        print("A-Train Disabled")
    else
        -- ENABLE
        _G.ATrainActive = true; hum.WalkSpeed = 250
        
        _G.HeartbeatConnection = RunService.Heartbeat:Connect(function()
            local speed = root.AssemblyLinearVelocity.Magnitude
            local isMoving = speed > 5

            -- 1. SOUND & PARTICLE LOGIC
            if leftTrail then leftTrail.Enabled = isMoving end
            if rightTrail then rightTrail.Enabled = isMoving end
            
            if isMoving and not isZooming then
                isZooming = true
                -- Play sound here...
                task.delay(1, function() isZooming = false end)
            end

            -- 2. VISUAL STATE LOGIC
            if isMoving and not isEffectActive then
                isEffectActive = true
                blur.Enabled = true
                cc.Enabled = true
                TweenService:Create(Camera, TweenInfo.new(0.3), {FieldOfView = 110}):Play()
                TweenService:Create(cc, TweenInfo.new(0.3), {Saturation = -1}):Play()
            elseif not isMoving and isEffectActive then
                isEffectActive = false
                blur.Enabled = false
                cc.Enabled = false
                TweenService:Create(Camera, TweenInfo.new(0.3), {FieldOfView = 70}):Play()
                TweenService:Create(cc, TweenInfo.new(0.3), {Saturation = 0}):Play()
            end
        end)
    end
end)()