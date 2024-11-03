local Rudinn, super = Class(EnemyBattler)

function Rudinn:init()
    super:init(self)

    self.name = "Rudinn EX"
    self:setActor("rudinnex")

    self.path = "enemies/rudinn"
    self.default = "idle"

    self.max_health = 120
    self.health = 5000
    self.attack = 20
    self.defense = 0
    self.money = 69

    self.spare_points = 0

    self.waves = {
        "rudinn/diamonds_up",
        "rudinn/diamonds_aim"
    }

    self.check = "AT 20 DF 0 - like Rudinn, but BETTER."

    self.text = {
        "* Rudinn EX is glimmering blindingly.",
        "* Rudinn EX has strong opinion.",
        "* Rudinn EX thinks about elaborate\nstones.",
        "* Rudinn EX disliked its boss,\nand quit.",
	    "* Smells like jewelry."
    }

    self.low_health_text = "* Rudinn EX's luster begins to fade."

    self:registerAct("Convince")
    self:registerAct("Lecture")

    self.dialogue_override = nil
end

function Rudinn:isXActionShort(battler)
    return true
end

function Rudinn:onShortAct(battler, name)
    if name == "Lecture" then
		self:setAnimation("tired")
		self.setTired(true)
        print("You lectured the enemies on the\nimportance of kindness.")
        if battler.chara.id == "kris" then
            return "* You lectured the enemies on the\nimportance of kindness."
        else
            return "* " .. battler.chara:getName() .. " lectured the enemies on the\nimportance of kindness."
        end
    elseif name == "Standard" then
        self:addMercy(10)
        if battler.chara.id == "noelle" then
            return "* Noelle encouraged the enemies!"
        elseif battler.chara.id == "susie" then
            return "* Susie motivated the enemies!"
        elseif battler.chara.id == "ralsei" then
            return "* Ralsei reasoned with the enemies!"
        end
    end
    return nil
end


function Rudinn:onAct(battler, name)
    if name == "Convince" then
        self:addMercy(10)
        return "* You told Rudinn EX to quit fighting.\n* It thought about this..."
    elseif name == "Lecture" then
		self:setAnimation("tired")
        self:setTired(true)
        self.dialogue_override = "(Yawn)...\nWhat? OK.."
        return "* You lectured Rudinn EX on the\nimportance of kindness.\nRudinn EX became [color:blue]TIRED[color:reset]..."

        --local heck = DamageNumber("damage", love.math.random(600), 200, 200, battler.actor.dmg_color)
        --self.parent:addChild(heck)
    elseif name == "Standard" then
        self:addMercy(50)
        if battler.chara.id == "noelle" then
			self.dialogue_override = "I know."
			Game.battle:startActCutscene(function(cutscene)
				cutscene:text("* Noelle tried to give encouragement!")
				cutscene:text("* That necklace is, um...\nit's really shiny!", "smile_closed", "noelle")
			end)
        elseif battler.chara.id == "susie" then
            self.dialogue_override = "How about no."
            Game.battle:startActCutscene(function(cutscene)
                cutscene:text("* Susie tried to give encouragement!")
                cutscene:text("* You! Get off your ass,\nor else!!", "teeth", "susie")
            end)
            return
        elseif battler.chara.id == "ralsei" then
			self.dialogue_override = "That's what \nI'm doing."
            Game.battle:startActCutscene(function(cutscene)
                cutscene:text("* Ralsei tried to give encouragement!")
                cutscene:text("* Don't feel bad about taking\nbreaks every so often...\nit's perfectly normal!", "smile", "ralsei")
            end)
            return
        end
    end
    return super:onAct(self, battler, name)
end

function Rudinn:getEnemyDialogue()
    if self.dialogue_override then
        local dialogue = self.dialogue_override
        self.dialogue_override = nil
        return dialogue
    end

    local dialogue
    if self.mercy >= 100 then
        dialogue = {
            "Yeah I\nguess that\nmakes\nsense.",
            "Alright,\nyou convinced\nme!!"
        }
    else
        dialogue = {
            "I'm the main\ncharacter, and\nyou have to like\nme.",
            "Long live\nthe guy (me)",
            "Shine,\nshine!",
            "Face my\nDiamond\nCutter!"
        }
    end
    return dialogue[math.random(#dialogue)]
end

return Rudinn