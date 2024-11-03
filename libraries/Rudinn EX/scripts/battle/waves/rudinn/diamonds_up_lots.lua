local DiamondsUpLots, super = Class(Wave)

function DiamondsUpLots:init()
	super:init(self)
	
	self.time = 10
end

function DiamondsUpLots:onStart()
    self.timer:every(1/30, function()
        local x = Utils.random(Game.battle.arena.left - 20, Game.battle.arena.right + 20)
        local y = Utils.random(Game.battle.arena.bottom + 50, Game.battle.arena.bottom + 100)

        self:spawnBullet("rudinn/diamond_mix", x, y, math.rad(270+love.math.random(-10,10)))
    end)
end

return DiamondsUpLots