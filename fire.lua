-- LocalScript to automatically transform and send messages to chat

local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local player = Players.LocalPlayer

-- Show a simple working notification
player.PlayerGui:SetCore("SendNotification", {
    Title = "Welcome";
    Text = "Script activated: Text transformation is now enabled.";
    Duration = 5; -- Duration in seconds
})

-- Specific letter transformations
local letterTransformations = {
    c = "с", C = "С",
    a = "а", A = "А",
    o = "о", O = "О",
    j = "ј", J = "Ј",
    p = "р", P = "Р",
    l = "ӏ",  -- Keep capital L unchanged
    e = "е", E = "Е",
    i = "ı̇", I = "І",  -- Replace lowercase 'i' with 'ı̇'
    y = "у", -- Keep capital Y unchanged
    B = "В",  -- Replace uppercase 'B'
    S = "Ѕ",  -- Replace uppercase 'S'
    N = "Ν"   -- Replace capital 'N'
}

-- Function to transform text
local function transformText(inputText)
    local transformedText = ""

    -- Apply letter transformations
    for i = 1, #inputText do
        local char = inputText:sub(i, i)
        transformedText = transformedText .. (letterTransformations[char] or char)
    end

    -- Replace spaces with a space followed by a combining tilde (U+0303)
    transformedText = string.gsub(transformedText, " ", " ̃")  -- Using the combining tilde directly

    return transformedText
end

-- Function to listen for player chat input
local function onPlayerChatted(message)
    local transformedMessage = transformText(message)
    
    -- Send transformed message to chat
    TextChatService.TextChatInputBarModule:SendMessage(transformedMessage)
end

-- Connect the chat event
player.Chatted:Connect(onPlayerChatted)
