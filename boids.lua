
function createBoids(qty)
	math.randomseed(os.time())
	local boids = {}
	winWidth, winHeight = love.window.getMode()

	for i=1,qty do
		local newBoid = {

			--position
			x = math.random(10,winWidth-10),
			y = math.random(10,winHeight-10),

			--velocity
			vmax = 100,
			vx = math.random(-50, 50),
			vy = math.random(-50, 50),

			--acceleration
			ax = 0,
			ay = 0,

			--range of sight
			range = 300,
			avoidRange = 40,

			--force multipliers
			forceFlock = 1,
			forceAngle = 1,
			forceAvoid = 1 }

		table.insert(boids,newBoid)
	end

	return boids
end

function distance(b1,b2)
	return math.sqrt((b2.x-b1.x)^2 + (b2.y-b1.y)^2)
end

function sign(n)
	return n < 0 and -1 or n > 0 and 1 or 0
end

function applyForces()
	for i, current_boid in ipairs(Boids) do

		--reset acceleration
		current_boid.ax, current_boid.ay = 0, 0

		--Need center of nearby boids
		local flockCenterX, flockCenterY = 0, 0
		local flockCount = 0

		--Need average direction of nearby boids
		local flockVx, flockVy = 0, 0

		for j,target_boid in ipairs(Boids) do

			--check nearby boids, ignoring self
			local boidDistance = distance(current_boid, target_boid)

			if current_boid == target_boid then elseif boidDistance < current_boid.range then
				--update running total of locations and angles
				flockCount = flockCount + 1
				flockCenterX = flockCenterX + target_boid.x
				flockCenterY = flockCenterY + target_boid.y
				flockVx = flockVx + target_boid.vx
				flockVy = flockVy + target_boid.vy

				--avoid hitting other boids
				if boidDistance < current_boid.avoidRange then
					local angle = math.atan2(target_boid.y - current_boid.y, target_boid.x - current_boid.x)
					current_boid.ax = current_boid.ax + math.cos(angle) * (boidDistance - current_boid.avoidRange) * current_boid.forceAvoid
					current_boid.ay = current_boid.ay + math.sin(angle) * (boidDistance - current_boid.avoidRange) * current_boid.forceAvoid
				end
			end
		end

		--update forces from flocking

		--update velocity based on acceleration
		current_boid.vx = math.min(current_boid.vx + current_boid.ax,current_boid.vmax)
		current_boid.vy = math.min(current_boid.vy + current_boid.ay,current_boid.vmax)
	end
end


function moveBoids(dt)
	for i,v in ipairs(Boids) do
		--update x, y based on speed
		v.x = (v.x + v.vx * dt) % winWidth
		v.y = (v.y + v.vy * dt) % winHeight
	end
end

function drawBoid(b)
	local angle = math.atan2(b.vy, b.vx)
	love.graphics.circle("line",b.x,b.y,3)
	love.graphics.line(b.x,b.y,b.x + 8*math.cos(angle),b.y + 8*math.sin(angle))
end