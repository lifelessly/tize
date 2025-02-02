-- Create a ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ChatBypasserV1.0"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create a Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.4, 0, 0.5, 0)
frame.Position = UDim2.new(0.3, 0, 0.25, 0)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
frame.Parent = screenGui

-- Title Label with Glow Effect
local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "ChatBypasserV1.0"
titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.TextStrokeTransparency = 0.5
titleLabel.TextSize = 24
titleLabel.Parent = frame

-- Input TextBox
local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(0.9, 0, 0.2, 0)
inputBox.Position = UDim2.new(0.05, 0, 0.15, 0)
inputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.ClearTextOnFocus = true
inputBox.PlaceholderText = "Enter your text here..."
inputBox.Parent = frame

-- Output TextBox
local outputBox = Instance.new("TextBox")
outputBox.Size = UDim2.new(0.9, 0, 0.2, 0)
outputBox.Position = UDim2.new(0.05, 0, 0.4, 0)
outputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
outputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
outputBox.ClearTextOnFocus = false
outputBox.TextEditable = false
outputBox.Parent = frame

-- Transform Button
local transformButton = Instance.new("TextButton")
transformButton.Size = UDim2.new(0.3, 0, 0.1, 0)
transformButton.Position = UDim2.new(0.35, 0, 0.65, 0)
transformButton.BackgroundColor3 = Color3.fromRGB(187, 134, 252)
transformButton.TextColor3 = Color3.fromRGB(18, 18, 18)
transformButton.Text = "Transform Text"
transformButton.TextScaled = true
transformButton.Parent = frame

-- Function to transform text and send to chat
local function transformText()
    local inputText = inputBox.Text
    local transformedText = inputText

    -- Letter transformations
    local letterTransformations = {
        c = "с", C = "С", a = "а", A = "А",
        o = "о", O = "О", j = "ј", p = "р",
        l = "ӏ", e = "е", i = "ı̇", I = "І",
        y = "у", B = "В", S = "Ѕ"
    }

    -- Apply letter transformations
    for original, replacement in pairs(letterTransformations) do
        transformedText = string.gsub(transformedText, original, replacement)
    end

    -- Replace spaces with ' ̃'
    transformedText = string.gsub(transformedText, " ", " ̃")

    -- Randomly add line break character (U+2028) in the middle of words with a 5% chance
    local finalText = ""
    for i = 1, #transformedText do
        finalText = finalText .. transformedText:sub(i, i)
        if math.random() < 0.05 then -- 5% chance
            finalText = finalText .. "\u{2028}" -- Add line break character
        end
    end

    -- Display transformed text in the output box
    outputBox.Text = finalText

    -- Send transformed text to chat
    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(finalText, "All")
end

-- Connect button click to the transform function
transformButton.MouseButton1Click:Connect(transformText)
