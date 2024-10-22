local Dummy, super = Class(Encounter)

function Dummy:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Smells like diamonds..."

    -- Battle music ("battle" is rude buster)
    self.music = "rudinnex"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("rudinn")

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
end

return Dummy