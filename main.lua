require("boids")

function love.load()
	love.window.setMode(1200,800)
	Boids = createBoids(500)
end

function love.update(dt)
	applyForces()
	moveBoids(dt)
end

function love.draw()
	love.graphics.setColor(.5,1,1)
	for i,v in ipairs(Boids) do
		drawBoid(v)
	end
end
