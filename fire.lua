-- LocalScript to automatically transform and send messages to chat

local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local player = Players.LocalPlayer

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
    S = "Ѕ"   -- Replace uppercase 'S'
}

-- Function to transform text
local function transformText(inputText)
    local transformedText = ""

    -- Apply letter transformations
    for i = 1, #inputText do
        local char = inputText:sub(i, i)
        transformedText = transformedText .. (letterTransformations[char] or char)
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

    return finalText
end

-- Function to listen for player chat input
local function onPlayerChatted(message)
    local transformedMessage = transformText(message)
    
    -- Send transformed message to chat
    TextChatService.TextChatInputBarModule:SendMessage(transformedMessage)
end

-- Connect the chat event
player.Chatted:Connect(onPlayerChatted)
