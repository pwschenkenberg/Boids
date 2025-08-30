require("boids")

function love.load()
	love.window.setMode(1600,1000)
	--Boids = createBoids(100)
end

function love.update(dt)
	--applyForces()
	--moveBoids(dt)
end

function love.draw()
	--[[love.graphics.setColor(.5,1,1)
	for i,v in ipairs(Boids) do
		drawBoid(v)
	end
]]
--[[
	local startline = 10
	for i,v in ipairs(Boids) do
		love.graphics.print(math.floor(v.x)..", "..math.floor(v.y),10,startline)
		startline = startline + 12

	end
]]

end
