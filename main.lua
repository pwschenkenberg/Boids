function love.load()
	Boids = createBoids(100)
end

function love.update()
end

function love.draw()
	love.graphics.setColor(.5,1,1)
	for i,v in ipairs(Boids) do
		love.graphics.circle("line",v.x,v.y,3)
		love.graphics.line(v.x,v.y,v.x + 8*math.cos(v.angle),v.y + 8*math.sin(v.angle))
	end
end

function createBoids(qty)
	math.randomseed(os.time())
	local boids = {}
	local winWidth, winHeight = love.window.getMode()

	for i=1,qty do
		local newBoid = {
			x = math.random(10,winWidth-10),
			y = math.random(10,winHeight-10),
			angle = math.random() * 2 * math.pi,
			velocity = 100,
			range = 200 }

		table.insert(boids,newBoid)
	end

	return boids
end

function turnBoids()
	for i,v in ipairs(Boids) do
		--turn towards average angle of nearby boids
	end
end

function moveBoids()
	for i,v in ipairs(Boids) do
		--update x, y based on angle and speed
		
	end
