local Spamemail, super = Class(Encounter)

function Spamemail:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* What the [[FiftyPercentOff]]?!?!??!!"

    -- Battle music ("battle" is rude buster)
    self.music = "spamemail"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the Spamemail enemy to the encounter
    self:addEnemy("spamemail")

    --- Uncomment this line to add another!
    --self:addEnemy("Spamemail")
end

return Spamemail