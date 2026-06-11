--cool little script that copies A-Train from The Boys
--if someone uses this (unlikely) at least give credit to me, thanks!

return (function()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    
    if _G.ATrainActive then
        _G.ATrainActive = false
        hum.WalkSpeed = 16
        print("A-Train Disabled")
    else
        _G.ATrainActive = true
        hum.WalkSpeed = 250
        print("A-Train Enabled")
    end
end)()