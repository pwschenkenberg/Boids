require("boids")

function love.load()
	Boids = createBoids(100)
end

function love.update(dt)
	turnBoids(dt)
	moveBoids(dt)
end

function love.draw()
	love.graphics.setColor(.5,1,1)
	for i,v in ipairs(Boids) do
		love.graphics.circle("line",v.x,v.y,3)
		love.graphics.line(v.x,v.y,v.x + 8*math.cos(v.angle),v.y + 8*math.sin(v.angle))
	end
end



