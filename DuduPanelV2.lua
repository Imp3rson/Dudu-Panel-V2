-- Dudu Panel Universal V2 - UI + ESP + Click TP
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ============ PALETA ============
local COR_FUNDO       = Color3.fromRGB(18, 18, 20)
local COR_FUNDO2      = Color3.fromRGB(24, 24, 28)
local COR_BARRA       = Color3.fromRGB(30, 30, 36)
local COR_VERMELHO    = Color3.fromRGB(200, 30, 40)
local COR_VERMELHO2   = Color3.fromRGB(255, 60, 70)
local COR_VERM_ESCURO = Color3.fromRGB(120, 15, 20)
local COR_TEXTO       = Color3.fromRGB(240, 240, 240)
local COR_TEXTO_FRACO = Color3.fromRGB(150, 150, 160)
local COR_OFF_BG      = Color3.fromRGB(36, 36, 42)
local COR_OFF_HOVER   = Color3.fromRGB(46, 46, 54)
local COR_VERDE       = Color3.fromRGB(40, 200, 80)
local COR_VERDE_CLARO = Color3.fromRGB(100, 255, 130)
local COR_PRETO       = Color3.fromRGB(20, 20, 22)

-- ============ HELPERS ============
local function arredondar(obj, raio)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, raio)
    c.Parent = obj
    return c
end

local function gradiente(obj, corA, corB, rotacao)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new(corA, corB)
    g.Rotation = rotacao or 90
    g.Parent = obj
    return g
end

-- ============ SCREEN GUI ============
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DuduPanelUniversal"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.CoreGui

-- ============ BOTÃO FLUTUANTE ============
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 52, 0, 52)
ToggleBtn.Position = UDim2.new(0, 24, 0, 100)
ToggleBtn.BackgroundColor3 = COR_FUNDO2
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Text = "☰"
ToggleBtn.TextColor3 = COR_TEXTO
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 24
ToggleBtn.AutoButtonColor = false
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.ZIndex = 5
ToggleBtn.Parent = ScreenGui

arredondar(ToggleBtn, 14)
gradiente(ToggleBtn, COR_FUNDO2, COR_FUNDO, 90)

local btnStripe = Instance.new("Frame")
btnStripe.Size = UDim2.new(0.7, 0, 0, 3)
btnStripe.Position = UDim2.new(0.15, 0, 0, 0)
btnStripe.BackgroundColor3 = COR_VERMELHO
btnStripe.BorderSizePixel = 0
btnStripe.ZIndex = 6
btnStripe.Parent = ToggleBtn
arredondar(btnStripe, 2)

-- ============ PAINEL ============
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 460, 0, 500)
Frame.Position = UDim2.new(0, 24, 0, 165)
Frame.BackgroundColor3 = COR_FUNDO
Frame.BorderSizePixel = 0
Frame.Active = false
Frame.Visible = false
Frame.ZIndex = 3
Frame.Parent = ScreenGui

arredondar(Frame, 18)
gradiente(Frame, COR_FUNDO2, COR_FUNDO, 90)

local borda = Instance.new("UIStroke")
borda.Color = COR_VERMELHO
borda.Thickness = 1.5
borda.Transparency = 0.5
borda.Parent = Frame

-- ============ SISTEMA DE DRAG ============
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

local function updateDrag(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(
        startPos.X.Scale, startPos.X.Offset + delta.X,
        startPos.Y.Scale, startPos.Y.Offset + delta.Y
    )
end

-- ============ HEADER ============
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = COR_BARRA
Header.BorderSizePixel = 0
Header.Active = true
Header.ZIndex = 4
Header.Parent = Frame

local hCorner = Instance.new("UICorner")
hCorner.CornerRadius = UDim.new(0, 18)
hCorner.Parent = Header

local headerFix = Instance.new("Frame")
headerFix.Size = UDim2.new(1, 0, 0.5, 0)
headerFix.Position = UDim2.new(0, 0, 0.5, 0)
headerFix.BackgroundColor3 = COR_BARRA
headerFix.BorderSizePixel = 0
headerFix.ZIndex = 4
headerFix.Parent = Header

gradiente(Header, COR_VERM_ESCURO, COR_BARRA, 90)

local hStripe = Instance.new("Frame")
hStripe.Size = UDim2.new(1, 0, 0, 2)
hStripe.Position = UDim2.new(0, 0, 1, -2)
hStripe.BackgroundColor3 = COR_VERMELHO
hStripe.BorderSizePixel = 0
hStripe.ZIndex = 5
hStripe.Parent = Header
gradiente(hStripe, COR_VERMELHO2, COR_VERM_ESCURO, 0)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -70, 1, 0)
Title.Position = UDim2.new(0, 35, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Dudu Panel Universal"
Title.TextColor3 = COR_VERMELHO2
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.ZIndex = 6
Title.Parent = Header

local dotDecor = Instance.new("Frame")
dotDecor.Size = UDim2.new(0, 10, 0, 10)
dotDecor.Position = UDim2.new(0, 14, 0.5, -5)
dotDecor.BackgroundColor3 = COR_VERMELHO
dotDecor.BorderSizePixel = 0
dotDecor.ZIndex = 6
dotDecor.Parent = Header
arredondar(dotDecor, 10)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -34, 0.5, -13)
closeBtn.BackgroundColor3 = Color3.fromRGB(50, 20, 24)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = COR_VERMELHO2
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.AutoButtonColor = false
closeBtn.ZIndex = 6
closeBtn.Parent = Header
arredondar(closeBtn, 8)

closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundColor3 = COR_VERMELHO}):Play()
    TweenService:Create(closeBtn, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(255,255,255)}):Play()
end)
closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(50, 20, 24)}):Play()
    TweenService:Create(closeBtn, TweenInfo.new(0.15), {TextColor3 = COR_VERMELHO2}):Play()
end)

-- ============ DRAG NO HEADER ============
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

-- ============ CONTAINER ============
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 0, 440)
Content.Position = UDim2.new(0, 10, 0, 58)
Content.BackgroundTransparency = 1
Content.ZIndex = 4
Content.Parent = Frame

-- toggle painel
local painelAberto = false
ToggleBtn.MouseButton1Click:Connect(function()
    painelAberto = not painelAberto
    Frame.Visible = painelAberto
    ToggleBtn.Text = painelAberto and "✕" or "☰"
end)

closeBtn.MouseButton1Click:Connect(function()
    painelAberto = false
    Frame.Visible = false
    ToggleBtn.Text = "☰"
end)

-- ============ CRIAR BOTÃO ============
local function criarBotao(texto, posX, posY, largura)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, largura, 0, 42)
    btn.Position = UDim2.new(0, posX, 0, posY)
    btn.BackgroundColor3 = COR_PRETO
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.ZIndex = 5
    btn.Parent = Content

    arredondar(btn, 10)

    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new(COR_PRETO, COR_FUNDO)
    g.Rotation = 90
    g.Parent = btn

    local side = Instance.new("Frame")
    side.Size = UDim2.new(0, 3, 0.6, 0)
    side.Position = UDim2.new(0, 6, 0.2, 0)
    side.BackgroundColor3 = COR_PRETO
    side.BorderSizePixel = 0
    side.ZIndex = 6
    side.Parent = btn
    arredondar(side, 3)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 18, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = texto
    label.TextColor3 = COR_TEXTO
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 6
    label.Parent = btn

    local pill = Instance.new("Frame")
    pill.Size = UDim2.new(0, 34, 0, 18)
    pill.Position = UDim2.new(1, -44, 0.5, -9)
    pill.BackgroundColor3 = COR_PRETO
    pill.BorderSizePixel = 0
    pill.ZIndex = 6
    pill.Parent = btn
    arredondar(pill, 9)

    local pillLabel = Instance.new("TextLabel")
    pillLabel.Size = UDim2.new(1, 0, 1, 0)
    pillLabel.BackgroundTransparency = 1
    pillLabel.Text = "OFF"
    pillLabel.TextColor3 = COR_TEXTO_FRACO
    pillLabel.Font = Enum.Font.GothamBold
    pillLabel.TextSize = 9
    pillLabel.ZIndex = 7
    pillLabel.Parent = pill

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = COR_OFF_HOVER}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = COR_PRETO}):Play()
    end)

    return btn, label, pill, pillLabel, side, g
end

local function setStatus(btn, pill, pillLabel, side, g, ativo)
    if ativo then
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(18, 45, 25)}):Play()
        TweenService:Create(side, TweenInfo.new(0.2), {BackgroundColor3 = COR_VERDE_CLARO}):Play()
        TweenService:Create(pill, TweenInfo.new(0.2), {BackgroundColor3 = COR_VERDE}):Play()
        pillLabel.Text = "ON"
        pillLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        g.Color = ColorSequence.new(Color3.fromRGB(18, 45, 25), COR_FUNDO)
    else
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = COR_PRETO}):Play()
        TweenService:Create(side, TweenInfo.new(0.2), {BackgroundColor3 = COR_PRETO}):Play()
        TweenService:Create(pill, TweenInfo.new(0.2), {BackgroundColor3 = COR_PRETO}):Play()
        pillLabel.Text = "OFF"
        pillLabel.TextColor3 = COR_TEXTO_FRACO
        g.Color = ColorSequence.new(COR_PRETO, COR_FUNDO)
    end
end

-- ============ ESTADOS ============
local flyAtivo = false
local speedAtivo = false
local infJumpAtivo = false
local noclipAtivo = false
local clickTpAtivo = false
local SPEED_VALOR = 100

-- ESP
local espAtivo = false
local espBoxAtivo = false
local espLineAtivo = false
local espDistanceAtivo = false
local espNameAtivo = false
local espHealthAtivo = false

-- ============ FLY ============
local flyConnection = nil

local function pararFly()
    flyAtivo = false
    if flyConnection then flyConnection:Disconnect() flyConnection = nil end
    local char = LP.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand = false end
        if hrp then
            local bv = hrp:FindFirstChild("FlyBV") if bv then bv:Destroy() end
            local bg = hrp:FindFirstChild("FlyBG") if bg then bg:Destroy() end
        end
    end
end

local function toggleFly()
    if flyAtivo then pararFly() return end

    local char = LP.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end

    flyAtivo = true
    hum.PlatformStand = true

    local flyBG = Instance.new("BodyGyro")
    flyBG.Name = "FlyBG"
    flyBG.P = 9e4
    flyBG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    flyBG.CFrame = hrp.CFrame
    flyBG.Parent = hrp

    local flyBV = Instance.new("BodyVelocity")
    flyBV.Name = "FlyBV"
    flyBV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    flyBV.Velocity = Vector3.zero
    flyBV.P = 1250
    flyBV.Parent = hrp

    flyConnection = RunService.RenderStepped:Connect(function()
        if not flyAtivo or not hrp.Parent then pararFly() return end

        local dir = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir += Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= Camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir += Camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0, 1, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0, 1, 0) end

        flyBV.Velocity = dir * 80
        flyBG.CFrame = Camera.CFrame
    end)
end

-- ============ SPEED ============
local function aplicarSpeed()
    local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = speedAtivo and SPEED_VALOR or 16
    end
end

local function toggleSpeed()
    speedAtivo = not speedAtivo
    aplicarSpeed()
end

LP.CharacterAdded:Connect(function(char)
    task.wait(1)
    aplicarSpeed()
end)

-- ============ INF JUMP ============
UIS.JumpRequest:Connect(function()
    if infJumpAtivo then
        local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

local function toggleInfJump() infJumpAtivo = not infJumpAtivo end

-- ============ NOCLIP ============
local noclipConn = nil

local function toggleNoclip()
    noclipAtivo = not noclipAtivo
    if noclipAtivo then
        noclipConn = RunService.Stepped:Connect(function()
            local char = LP.Character
            if char then
                for _, parte in ipairs(char:GetDescendants()) do
                    if parte:IsA("BasePart") and parte.CanCollide then
                        parte.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConn then noclipConn:Disconnect() noclipConn = nil end
        local char = LP.Character
        if char then
            for _, parte in ipairs(char:GetDescendants()) do
                if parte:IsA("BasePart") then parte.CanCollide = true end
            end
        end
    end
end

-- ============ CLICK TP ============
local clickTpTool = nil

local function criarClickTpTool()
    if clickTpTool then clickTpTool:Destroy() end

    local tool = Instance.new("Tool")
    tool.Name = "Click TP"
    tool.RequiresHandle = false
    tool.CanBeDropped = false
    tool.ToolTip = "Clique em qualquer lugar para teleportar"
    tool.TextureId = "rbxassetid://6031091004"
    tool.Parent = LP.Backpack

    tool.Equipped:Connect(function()
        local mouse = LP:GetMouse()
        if mouse then mouse.Icon = "rbxassetid://6031091004" end
    end)

    tool.Unequipped:Connect(function()
        local mouse = LP:GetMouse()
        if mouse then mouse.Icon = "" end
    end)

    tool.Activated:Connect(function()
        if not clickTpAtivo then return end
        local mouse = LP:GetMouse()
        if not mouse then return end

        local alvo
        if mouse.Target then
            alvo = mouse.Hit.Position + Vector3.new(0, 3, 0)
        else
            local ray = Camera:ViewportPointToRay(mouse.X, mouse.Y)
            alvo = ray.Origin + ray.Direction * 500
        end

        local char = LP.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = CFrame.new(alvo) end
    end)

    clickTpTool = tool
    task.wait(0.1)
    local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum:EquipTool(tool) end
end

local function removerClickTpTool()
    if clickTpTool then
        clickTpTool:Destroy()
        clickTpTool = nil
    end
    local mouse = LP:GetMouse()
    if mouse then mouse.Icon = "" end
end

local function toggleClickTp()
    clickTpAtivo = not clickTpAtivo
    if clickTpAtivo then
        criarClickTpTool()
    else
        removerClickTpTool()
    end
end

LP.CharacterAdded:Connect(function()
    task.wait(1)
    if clickTpAtivo then criarClickTpTool() end
end)

-- ============ SISTEMA ESP ============
local espObjects = {}

local function criarEspParaPlayer(player)
    if player == LP then return end
    if espObjects[player] then return end

    local function adicionarEsp(char)
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local head = char:FindFirstChild("Head")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not head or not hum then return end

        local data = {}

        -- Highlight (box)
        local highlight = Instance.new("Highlight")
        highlight.Name = "DuduESP_Box"
        highlight.FillTransparency = 0.7
        highlight.OutlineTransparency = 0
        highlight.FillColor = COR_VERMELHO
        highlight.OutlineColor = COR_VERMELHO2
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Adornee = char
        highlight.Enabled = false
        highlight.Parent = char
        data.Highlight = highlight

        -- Name
        local nameGui = Instance.new("BillboardGui")
        nameGui.Name = "DuduESP_Name"
        nameGui.Size = UDim2.new(0, 200, 0, 20)
        nameGui.StudsOffset = Vector3.new(0, 3, 0)
        nameGui.AlwaysOnTop = true
        nameGui.Enabled = false
        nameGui.Parent = head

        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 1, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = player.Name
        nameLabel.TextColor3 = COR_VERMELHO2
        nameLabel.TextStrokeTransparency = 0
        nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextSize = 14
        nameLabel.Parent = nameGui
        data.NameGui = nameGui

        -- Distance
        local distGui = Instance.new("BillboardGui")
        distGui.Name = "DuduESP_Distance"
        distGui.Size = UDim2.new(0, 200, 0, 16)
        distGui.StudsOffset = Vector3.new(0, 2.5, 0)
        distGui.AlwaysOnTop = true
        distGui.Enabled = false
        distGui.Parent = head

        local distLabel = Instance.new("TextLabel")
        distLabel.Size = UDim2.new(1, 0, 1, 0)
        distLabel.BackgroundTransparency = 1
        distLabel.Text = "[0m]"
        distLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        distLabel.TextStrokeTransparency = 0
        distLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        distLabel.Font = Enum.Font.Gotham
        distLabel.TextSize = 12
        distLabel.Parent = distGui
        data.DistanceGui = distGui
        data.DistanceLabel = distLabel

        -- Health
        local healthGui = Instance.new("BillboardGui")
        healthGui.Name = "DuduESP_Health"
        healthGui.Size = UDim2.new(0, 100, 0, 6)
        healthGui.StudsOffset = Vector3.new(0, 3.7, 0)
        healthGui.AlwaysOnTop = true
        healthGui.Enabled = false
        healthGui.Parent = head

        local healthBg = Instance.new("Frame")
        healthBg.Size = UDim2.new(1, 0, 1, 0)
        healthBg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        healthBg.BorderSizePixel = 0
        healthBg.Parent = healthGui
        arredondar(healthBg, 3)

        local healthFill = Instance.new("Frame")
        healthFill.Size = UDim2.new(1, 0, 1, 0)
        healthFill.BackgroundColor3 = COR_VERDE
        healthFill.BorderSizePixel = 0
        healthFill.Parent = healthBg
        arredondar(healthFill, 3)

        data.HealthGui = healthGui
        data.HealthFill = healthFill

        -- Lines / Tracer
        local lineGui = Instance.new("Frame")
        lineGui.Name = "DuduESP_Line"
        lineGui.Size = UDim2.new(0, 2, 0, 0)
        lineGui.BackgroundColor3 = COR_VERMELHO2
        lineGui.BorderSizePixel = 0
        lineGui.AnchorPoint = Vector2.new(0.5, 1)
        lineGui.ZIndex = 2
        lineGui.Visible = false
        lineGui.Parent = ScreenGui
        data.LineGui = lineGui

        data.Character = char
        data.Humanoid = hum
        data.HRP = hrp
        data.Head = head

        espObjects[player] = data
    end

    if player.Character then
        adicionarEsp(player.Character)
    end
    player.CharacterAdded:Connect(adicionarEsp)
end

local function removerEspDePlayer(player)
    local data = espObjects[player]
    if data then
        if data.Highlight then data.Highlight:Destroy() end
        if data.NameGui then data.NameGui:Destroy() end
        if data.DistanceGui then data.DistanceGui:Destroy() end
        if data.HealthGui then data.HealthGui:Destroy() end
        if data.LineGui then data.LineGui:Destroy() end
        espObjects[player] = nil
    end
end

local function removerTodoEsp()
    for player, _ in pairs(espObjects) do
        removerEspDePlayer(player)
    end
    espObjects = {}
end

for _, p in ipairs(Players:GetPlayers()) do
    criarEspParaPlayer(p)
end
Players.PlayerAdded:Connect(criarEspParaPlayer)
Players.PlayerRemoving:Connect(removerEspDePlayer)

-- Loop ESP
RunService.RenderStepped:Connect(function()
    for player, data in pairs(espObjects) do
        if player ~= LP and data.Character and data.Character.Parent then
            local ativo = espAtivo

            if data.Highlight then
                data.Highlight.Enabled = ativo and espBoxAtivo
            end
            if data.NameGui then
                data.NameGui.Enabled = ativo and espNameAtivo
            end
            if data.HealthGui and data.Humanoid then
                data.HealthGui.Enabled = ativo and espHealthAtivo
                local pct = math.clamp(data.Humanoid.Health / data.Humanoid.MaxHealth, 0, 1)
                data.HealthFill.Size = UDim2.new(pct, 0, 1, 0)
                if pct > 0.5 then
                    data.HealthFill.BackgroundColor3 = COR_VERDE
                elseif pct > 0.25 then
                    data.HealthFill.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
                else
                    data.HealthFill.BackgroundColor3 = COR_VERMELHO2
                end
            end
            if data.DistanceGui and data.HRP then
                data.DistanceGui.Enabled = ativo and espDistanceAtivo
                if espDistanceAtivo then
                    local dist = (Camera.CFrame.Position - data.HRP.Position).Magnitude
                    data.DistanceLabel.Text = "[" .. math.floor(dist) .. "m]"
                end
            end
            if data.LineGui and data.Head then
                data.LineGui.Visible = ativo and espLineAtivo
                if espLineAtivo then
                    local headPos, onScreen = Camera:WorldToViewportPoint(data.Head.Position)
                    if onScreen then
                        data.LineGui.Position = UDim2.new(0, headPos.X, 1, 0)
                        data.LineGui.Size = UDim2.new(0, 2, 0, headPos.Y)
                    else
                        data.LineGui.Visible = false
                    end
                end
            end
        end
    end
end)

-- ============ LAYOUT ============
local COL_W = 215
local COL_L = 0
local COL_R = 225

-- BOTÕES PRINCIPAIS
local btnFly,   _, pillFly,   txtFly,   sideFly,   gFly   = criarBotao("Fly",            COL_L, 0,   COL_W)
local btnSpeed, _, pillSpeed, txtSpeed, sideSpeed, gSpeed = criarBotao("Speed",          COL_R, 0,   COL_W)
local btnNoclip,_, pillNoclip,txtNoclip,sideNoclip,gNoclip= criarBotao("Noclip",         COL_L, 48,  COL_W)
local btnJump,  _, pillJump,  txtJump,  sideJump,  gJump  = criarBotao("Infinite Jump",  COL_R, 48,  COL_W)
local btnTp,    _, pillTp,    txtTp,    sideTp,    gTp    = criarBotao("Click TP",       COL_L, 96,  COL_W)
local btnReset, _, pillReset, txtReset, sideReset, gReset = criarBotao("Reset",          COL_R, 96,  COL_W)

pillReset.Visible = false
sideReset.BackgroundColor3 = COR_VERMELHO
txtReset.TextColor3 = COR_VERMELHO2

btnFly.MouseButton1Click:Connect(function()
    toggleFly()
    setStatus(btnFly, pillFly, txtFly, sideFly, gFly, flyAtivo)
end)

btnSpeed.MouseButton1Click:Connect(function()
    toggleSpeed()
    setStatus(btnSpeed, pillSpeed, txtSpeed, sideSpeed, gSpeed, speedAtivo)
end)

btnNoclip.MouseButton1Click:Connect(function()
    toggleNoclip()
    setStatus(btnNoclip, pillNoclip, txtNoclip, sideNoclip, gNoclip, noclipAtivo)
end)

btnJump.MouseButton1Click:Connect(function()
    toggleInfJump()
    setStatus(btnJump, pillJump, txtJump, sideJump, gJump, infJumpAtivo)
end)

btnTp.MouseButton1Click:Connect(function()
    toggleClickTp()
    setStatus(btnTp, pillTp, txtTp, sideTp, gTp, clickTpAtivo)
end)

btnReset.MouseButton1Click:Connect(function()
    local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.Health = 0 end
end)

-- ============ SLIDER DE VELOCIDADE ============
local SliderBox = Instance.new("Frame")
SliderBox.Size = UDim2.new(0, 440, 0, 60)
SliderBox.Position = UDim2.new(0, 0, 0, 148)
SliderBox.BackgroundColor3 = COR_FUNDO2
SliderBox.BorderSizePixel = 0
SliderBox.ZIndex = 4
SliderBox.Parent = Content

arredondar(SliderBox, 12)
gradiente(SliderBox, COR_FUNDO2, COR_FUNDO, 90)

local sliderLabel = Instance.new("TextLabel")
sliderLabel.Size = UDim2.new(1, -20, 0, 18)
sliderLabel.Position = UDim2.new(0, 14, 0, 6)
sliderLabel.BackgroundTransparency = 1
sliderLabel.Text = "⚡ Velocidade: " .. SPEED_VALOR
sliderLabel.TextColor3 = COR_TEXTO
sliderLabel.Font = Enum.Font.GothamMedium
sliderLabel.TextSize = 12
sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
sliderLabel.ZIndex = 5
sliderLabel.Parent = SliderBox

local sliderBg = Instance.new("Frame")
sliderBg.Size = UDim2.new(1, -28, 0, 10)
sliderBg.Position = UDim2.new(0, 14, 0, 34)
sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 58)
sliderBg.BorderSizePixel = 0
sliderBg.ZIndex = 5
sliderBg.Parent = SliderBox
arredondar(sliderBg, 10)

local sliderFill = Instance.new("Frame")
sliderFill.Size = UDim2.new(0, 0, 1, 0)
sliderFill.BackgroundColor3 = COR_VERMELHO
sliderFill.BorderSizePixel = 0
sliderFill.ZIndex = 6
sliderFill.Parent = sliderBg
arredondar(sliderFill, 10)
gradiente(sliderFill, COR_VERMELHO2, COR_VERM_ESCURO, 0)

local knob = Instance.new("Frame")
knob.Size = UDim2.new(0, 16, 0, 16)
knob.Position = UDim2.new(0, 0, 0.5, -8)
knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
knob.BorderSizePixel = 0
knob.ZIndex = 7
knob.Parent = sliderBg
arredondar(knob, 8)

local knobStroke = Instance.new("UIStroke")
knobStroke.Color = COR_VERMELHO
knobStroke.Thickness = 2
knobStroke.Parent = knob

local SPEED_MIN = 16
local SPEED_MAX = 500

local pctInicial = (SPEED_VALOR - SPEED_MIN) / (SPEED_MAX - SPEED_MIN)
sliderFill.Size = UDim2.new(pctInicial, 0, 1, 0)
knob.Position = UDim2.new(pctInicial, -8, 0.5, -8)

local function atualizarSlider(pct)
    pct = math.clamp(pct, 0, 1)
    TweenService:Create(sliderFill, TweenInfo.new(0.08), {Size = UDim2.new(pct, 0, 1, 0)}):Play()
    knob.Position = UDim2.new(pct, -8, 0.5, -8)
    SPEED_VALOR = math.floor(SPEED_MIN + (SPEED_MAX - SPEED_MIN) * pct)
    sliderLabel.Text = "⚡ Velocidade: " .. SPEED_VALOR
    if speedAtivo then aplicarSpeed() end
end

local arrastando = false

local function processarInput(input)
    local posX = input.Position.X
    local absPos = sliderBg.AbsolutePosition.X
    local absSize = sliderBg.AbsoluteSize.X
    atualizarSlider((posX - absPos) / absSize)
end

knob.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        arrastando = true
        TweenService:Create(knob, TweenInfo.new(0.1), {Size = UDim2.new(0, 18, 0, 18)}):Play()
    end
end)

UIS.InputChanged:Connect(function(input)
    if arrastando and (input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch) then
        processarInput(input)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        if arrastando then
            arrastando = false
            TweenService:Create(knob, TweenInfo.new(0.1), {Size = UDim2.new(0, 16, 0, 16)}):Play()
        end
    end
end)

sliderBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        processarInput(input)
    end
end)

-- ============ TÍTULO DA SEÇÃO ESP ============
local espTitle = Instance.new("TextLabel")
espTitle.Size = UDim2.new(1, 0, 0, 20)
espTitle.Position = UDim2.new(0, 0, 0, 218)
espTitle.BackgroundTransparency = 1
espTitle.Text = "─────  ESP  ─────"
espTitle.TextColor3 = COR_VERMELHO2
espTitle.Font = Enum.Font.GothamBold
espTitle.TextSize = 11
espTitle.ZIndex = 5
espTitle.Parent = Content

-- ============ BOTÃO ESP PRINCIPAL ============
local btnEsp, _, pillEsp, txtEsp, sideEsp, gEsp = criarBotao("🟢 ESP Personagem", COL_L, 242, 440)
pillEsp.Visible = false

btnEsp.MouseButton1Click:Connect(function()
    espAtivo = not espAtivo
    if espAtivo then
        TweenService:Create(btnEsp, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(18, 45, 25)}):Play()
        TweenService:Create(sideEsp, TweenInfo.new(0.2), {BackgroundColor3 = COR_VERDE_CLARO}):Play()
        txtEsp.Text = "🟢 ESP Personagem"
        txtEsp.TextColor3 = COR_VERDE_CLARO
    else
        TweenService:Create(btnEsp, TweenInfo.new(0.2), {BackgroundColor3 = COR_PRETO}):Play()
        TweenService:Create(sideEsp, TweenInfo.new(0.2), {BackgroundColor3 = COR_PRETO}):Play()
        txtEsp.Text = "⚫ ESP Personagem"
        txtEsp.TextColor3 = COR_TEXTO
    end
end)

-- ============ BOTÕES ESP SECUNDÁRIOS ============
local espY = 292

local btnBox,  _, pillBox,  txtBox,  sideBox,  gBox  = criarBotao("⚫ Box (corpo)",   COL_L, espY,               COL_W)
local btnLine, _, pillLine, txtLine, sideLine, gLine = criarBotao("⚫ Lines",         COL_R, espY,               COL_W)
local btnDist, _, pillDist, txtDist, sideDist, gDist = criarBotao("⚫ Distance",      COL_L, espY + 48,         COL_W)
local btnName, _, pillName, txtName, sideName, gName = criarBotao("⚫ Name",          COL_R, espY + 48,         COL_W)
local btnHp,   _, pillHp,   txtHp,   sideHp,   gHp   = criarBotao("⚫ Health",        COL_L, espY + 96,         COL_W)

pillBox.Visible = false
pillLine.Visible = false
pillDist.Visible = false
pillName.Visible = false
pillHp.Visible = false

-- Helper pra togglar visual do botão ESP
local function toggleEspBtn(btn, side, txt, ativo, nome)
    if ativo then
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(18, 45, 25)}):Play()
        TweenService:Create(side, TweenInfo.new(0.2), {BackgroundColor3 = COR_VERDE_CLARO}):Play()
        txt.Text = "🟢 " .. nome
        txt.TextColor3 = COR_VERDE_CLARO
    else
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = COR_PRETO}):Play()
        TweenService:Create(side, TweenInfo.new(0.2), {BackgroundColor3 = COR_PRETO}):Play()
        txt.Text = "⚫ " .. nome
        txt.TextColor3 = COR_TEXTO
    end
end

btnBox.MouseButton1Click:Connect(function()
    espBoxAtivo = not espBoxAtivo
    toggleEspBtn(btnBox, sideBox, txtBox, espBoxAtivo, "Box (corpo)")
end)

btnLine.MouseButton1Click:Connect(function()
    espLineAtivo = not espLineAtivo
    toggleEspBtn(btnLine, sideLine, txtLine, espLineAtivo, "Lines")
end)

btnDist.MouseButton1Click:Connect(function()
    espDistanceAtivo = not espDistanceAtivo
    toggleEspBtn(btnDist, sideDist, txtDist, espDistanceAtivo, "Distance")
end)

btnName.MouseButton1Click:Connect(function()
    espNameAtivo = not espNameAtivo
    toggleEspBtn(btnName, sideName, txtName, espNameAtivo, "Name")
end)

btnHp.MouseButton1Click:Connect(function()
    espHealthAtivo = not espHealthAtivo
    toggleEspBtn(btnHp, sideHp, txtHp, espHealthAtivo, "Health")
end)

-- ============ RODAPÉ ============
local Footer = Instance.new("TextLabel")
Footer.Size = UDim2.new(1, -20, 0, 18)
Footer.Position = UDim2.new(0, 10, 1, -24)
Footer.BackgroundTransparency = 1
Footer.Text = "made with ❤  •  Dudu Panel Universal"
Footer.TextColor3 = COR_TEXTO_FRACO
Footer.Font = Enum.Font.Gotham
Footer.TextSize = 10
Footer.ZIndex = 4
Footer.Parent = Frame

print("[Dudu Panel] Carregado com sucesso! 🎯")
