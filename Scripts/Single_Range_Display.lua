--<<Shows blink dager range>>
require("libs.ScriptConfig")

config = ScriptConfig.new()
config:SetParameter("Hotkey", "O", config.TYPE_HOTKEY)
config:SetParameter("Range", 1200)
config:Load()

local range = config:GetParameter("Range")
local key = config.Hotkey

local activated = false
local effect = nil

function Key(msg,code)
	-- check if ingame and not chatting
    if msg ~= KEY_UP or code ~= key or client.chat or not client.connected or client.loading or client.console then
    	return
    end

    -- check if we already picked a hero
    local me = entityList:GetMyHero()
    if not me then
    	return
    end

    -- toggle activation
	activated = not activated

	if activated then
		-- add effect
		effect = Effect(me,"range_display")
		effect:SetVector(1,Vector(range,0,0))
	else
		RemoveEffect()
	end    
end
 
function RemoveEffect()
	effect = nil
	collectgarbage("collect")
	activated = false
end
 
script:RegisterEvent(EVENT_CLOSE,RemoveEffect) -- remove effect on game close
script:RegisterEvent(EVENT_KEY,Key)
