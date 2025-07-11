--[[ 
  Script Local Roblox: Lendas do Vôlei (Mobile)
  Funções: Auto Atacar, Auto Bloquear, Pulo Alto, Força Extra, Velocidade, Anti-Kick, Teleporte da Bola
  GUI flutuante com ícone e toggles mobile-friendly
  Criado por: FakeTsyo
--]]

-- // Variáveis principais
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local mouse = plr:GetMouse()

-- // GUI
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "LDV_MobileGUI"

-- Ícone flutuante
local icon = Instance.new("ImageButton")
icon.Name = "Icon"
icon.Size = UDim2.new(0, 56, 0, 56)
icon.Position = UDim2.new(0, 16, 0, 70)
icon.BackgroundTransparency = 1
icon.Image = "rbxassetid://6031091002" -- ícone de bola de vôlei
icon.Parent = sg

-- Frame principal
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 255, 0, 360)
main.Position = UDim2.new(0, 80, 0, 70)
main.BackgroundColor3 = Color3.fromRGB(35,35,35)
main.BorderSizePixel = 0
main.Visible = false
main.Parent = sg
Instance.new("UICorner",main).CornerRadius = UDim.new(0,18)

-- Arrastar GUI
local dragging, dragInput, dragStart, startPos
main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
main.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Mostrar/ocultar
icon.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)

local title = Instance.new("TextLabel",main)
title.Text = "Lendas do Vôlei Mobile"
title.Font = Enum.Font.GothamBlack
title.TextSize = 18
title.Size = UDim2.new(1,0,0,32)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255,255,255)

-- Função para criar toggle UI
local function criarToggle(nome, ordem)
    local frame = Instance.new("Frame",main)
    frame.Size = UDim2.new(1,-24,0,40)
    frame.Position = UDim2.new(0,12,0,40+(ordem-1)*48)
    frame.BackgroundTransparency = 1

    local toggle = Instance.new("TextButton",frame)
    toggle.Size = UDim2.new(0,40,0,40)
    toggle.BackgroundColor3 = Color3.fromRGB(60,60,60)
    toggle.Text = "OFF"
    toggle.Font = Enum.Font.GothamBold
    toggle.TextColor3 = Color3.new(1,1,1)
    toggle.TextSize = 14
    Instance.new("UICorner",toggle).CornerRadius = UDim.new(0,16)

    local lbl = Instance.new("TextLabel",frame)
    lbl.Text = nome
    lbl.Size = UDim2.new(1,-50,1,0)
    lbl.Position = UDim2.new(0,48,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 15
    lbl.TextColor3 = Color3.fromRGB(255,255,255)
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    return toggle
end

-- Toggles
local toggles = {
    ["Auto Atacar"] = false,
    ["Auto Bloquear"] = false,
    ["Pulo Alto"] = false,
    ["Força Extra"] = false,
    ["Velocidade"] = false,
    ["Anti-Kick"] = false,
    ["TP Bola"] = false,
}

local toggleObjs = {}

local ordem = 1
for nome,_ in pairs(toggles) do
    toggleObjs[nome] = criarToggle(nome, ordem)
    ordem = ordem + 1
end

-- Funções dos toggles
toggleObjs["Auto Atacar"].MouseButton1Click:Connect(function()
    toggles["Auto Atacar"] = not toggles["Auto Atacar"]
    toggleObjs["Auto Atacar"].Text = toggles["Auto Atacar"] and "ON" or "OFF"
    toggleObjs["Auto Atacar"].BackgroundColor3 = toggles["Auto Atacar"] and Color3.fromRGB(0,200,0) or Color3.fromRGB(60,60,60)
end)

toggleObjs["Auto Bloquear"].MouseButton1Click:Connect(function()
    toggles["Auto Bloquear"] = not toggles["Auto Bloquear"]
    toggleObjs["Auto Bloquear"].Text = toggles["Auto Bloquear"] and "ON" or "OFF"
    toggleObjs["Auto Bloquear"].BackgroundColor3 = toggles["Auto Bloquear"] and Color3.fromRGB(0,200,0) or Color3.fromRGB(60,60,60)
end)

toggleObjs["Pulo Alto"].MouseButton1Click:Connect(function()
    toggles["Pulo Alto"] = not toggles["Pulo Alto"]
    toggleObjs["Pulo Alto"].Text = toggles["Pulo Alto"] and "ON" or "OFF"
    toggleObjs["Pulo Alto"].BackgroundColor3 = toggles["Pulo Alto"] and Color3.fromRGB(0,200,0) or Color3.fromRGB(60,60,60)
    hum.JumpPower = toggles["Pulo Alto"] and 130 or 50
end)

toggleObjs["Força Extra"].MouseButton1Click:Connect(function()
    toggles["Força Extra"] = not toggles["Força Extra"]
    toggleObjs["Força Extra"].Text = toggles["Força Extra"] and "ON" or "OFF"
    toggleObjs["Força Extra"].BackgroundColor3 = toggles["Força Extra"] and Color3.fromRGB(0,200,0) or Color3.fromRGB(60,60,60)
    -- Exemplo: aumenta dano ao atacar (ajuste conforme o jogo)
end)

toggleObjs["Velocidade"].MouseButton1Click:Connect(function()
    toggles["Velocidade"] = not toggles["Velocidade"]
    toggleObjs["Velocidade"].Text = toggles["Velocidade"] and "ON" or "OFF"
    toggleObjs["Velocidade"].BackgroundColor3 = toggles["Velocidade"] and Color3.fromRGB(0,200,0) or Color3.fromRGB(60,60,60)
    hum.WalkSpeed = toggles["Velocidade"] and 38 or 16
end)

toggleObjs["Anti-Kick"].MouseButton1Click:Connect(function()
    toggles["Anti-Kick"] = not toggles["Anti-Kick"]
    toggleObjs["Anti-Kick"].Text = toggles["Anti-Kick"] and "ON" or "OFF"
    toggleObjs["Anti-Kick"].BackgroundColor3 = toggles["Anti-Kick"] and Color3.fromRGB(0,200,0) or Color3.fromRGB(60,60,60)
end)

toggleObjs["TP Bola"].MouseButton1Click:Connect(function()
    toggles["TP Bola"] = not toggles["TP Bola"]
    toggleObjs["TP Bola"].Text = toggles["TP Bola"] and "ON" or "OFF"
    toggleObjs["TP Bola"].BackgroundColor3 = toggles["TP Bola"] and Color3.fromRGB(0,200,0) or Color3.fromRGB(60,60,60)
end)

-- // Funções automáticas
game:GetService("RunService").RenderStepped:Connect(function()
    if toggles["Auto Atacar"] then
        -- Exemplo genérico, ajuste conforme o jogo:
        local atk = char:FindFirstChild("Attack") or (game.ReplicatedStorage:FindFirstChild("Attack") or false)
        if atk and atk:IsA("RemoteEvent") then
            atk:FireServer()
        end
    end
    if toggles["Auto Bloquear"] then
        local blk = char:FindFirstChild("Block") or (game.ReplicatedStorage:FindFirstChild("Block") or false)
        if blk and blk:IsA("RemoteEvent") then
            blk:FireServer()
        end
    end
    if toggles["Anti-Kick"] then
        for _,v in ipairs(getconnections(plr.Idled)) do v:Disable() end
        plr.Idled:Connect(function()
            game.VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            wait(1)
            game.VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
    end
    if toggles["TP Bola"] then
        -- Teleporta a bola para você (genérico, ajuste conforme o objeto real da bola)
        local bola = workspace:FindFirstChild("Ball") or workspace:FindFirstChildWhichIsA("Part", true)
        if bola then bola.Position = char.HumanoidRootPart.Position + Vector3.new(0,3,0) end
    end
end)

-- // FIM
