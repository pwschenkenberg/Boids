require("vec3")

function createBoids(qty)
	math.randomseed(os.time())
	local boids = {}
	winWidth, winHeight = love.window.getMode()

	for i=1,qty do
		local newBoid = {

			--position
			pos = Vector.new(math.random(10,winWidth-10), math.random(10,winHeight-10)),

			--velocity
			vmax = math.random(30,100),
			vel = Vector.new(),

			--acceleration
			acc = Vector.new(0,0),

			--range of sight
			range = 150,
			avoidRange = 25,

			--mass/size
			mass = math.random(1,5),

			--force multipliers
			forceFlock = .1,
			forceAngle = 1,
			forceAvoid = 1,
			forceRandom = 0,
			forceDamping = .99 }

		table.insert(boids,newBoid)
	end

	return boids
end

-- applies forces to Boids list - avoid other boids, move towards center
function applyForces()

	for i, current_boid in ipairs(Boids) do

		local flockForce = Vector.new()
		local flockCenter = Vector.new()
		local flockCount = 0

		for j, target_boid in ipairs(Boids) do
			-- ignore self
			if current_boid == target_boid then else

				--if distance(current_boid.pos, target_boid.pos) <= current_boid.range then
					flockForce = flockForce + (target_boid.pos - current_boid.pos)*current_boid.forceFlock
					flockCenter = flockCenter + target_boid.pos
					flockCount = flockCount + 1
				--end
			end
		end

		current_boid.acc = (flockCenter / flockCount)

	end


	
end


function moveBoids(dt)
	local winWidth, winHeight = love.window.getMode()

	for i, boid in ipairs(Boids) do
		-- update velocity from acceleration
		boid.vel = vecLimit(boid.vel + boid.acc, boid.vmax) * boid.forceDamping

		-- update positions from velocity
		boid.pos = boid.pos + boid.vel * dt
		boid.pos.x = boid.pos.x % winWidth
		boid.pos.y = boid.pos.y % winHeight
	end
end

function drawBoid(b)
	local angle = angle2(b.vel)
	love.graphics.circle("line",b.pos.x,b.pos.y,b.mass)
	love.graphics.line(b.pos.x,b.pos.y,b.pos.x + 8*math.cos(angle),b.pos.y + 8*math.sin(angle))
end