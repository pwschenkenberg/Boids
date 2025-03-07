
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

function distance(b1,b2)
	return math.sqrt((b2.x-b1.x)^2 + (b2.y-b1.y)^2)
end

function turnBoids(dt)
	for i,v in ipairs(Boids) do
		for j,w in ipairs(Boids) do
			--turn towards average angle of nearby boids
			if distance(v,w) < v.range then
				

		end
	end
end

function moveBoids(dt)
	for i,v in ipairs(Boids) do
		--update x, y based on angle and speed
		v.x = v.x + math.cos(v.angle) * v.velocity * dt
		v.y = v.y + math.sin(v.angle) * v.velocity * dt
	end
end