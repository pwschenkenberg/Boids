require("boidPhysics")

function createBoids(qty)
	math.randomseed(os.time())
	local boids = {}
	winWidth, winHeight = love.window.getMode()

	for i=1,qty do
		local newBoid = {

			--position
			pos = {math.random(10,winWidth-10), math.random(10,winHeight-10)},

			--velocity
			vmax = math.random(30,100),
			vel = {math.random(-50, 50), math.random(-50, 50),}

			--acceleration
			accel = {0, 0},

			--range of sight
			range = 50,
			avoidRange = 30,

			--force multipliers
			forceFlock = .02,
			forceAngle = .02,
			forceAvoid = .1,
			forceRandom = 0,
			forceDamping = 1 }

		table.insert(boids,newBoid)
	end

	return boids
end

function canSee(b1,b2)
	--get vision angle and angle to target
	local angle = math.atan2(b1.vy, b1.vx)
	local angleToTarget = math.atan2(b2.y-b1.y,b2.x-b1.x)

	--compare angles and return whether angles are close
	return math.abs(angle - angleToTarget) < math.pi
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

			if current_boid == target_boid then elseif boidDistance < current_boid.range then --and canSee(current_boid,target_boid) then
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

		--avoid walls
--[[		local wallDistance = 150
		local wallForce = .12
		if current_boid.x < wallDistance then
			current_boid.ax = current_boid.ax + (wallDistance - current_boid.x) * wallForce
		elseif current_boid.x > (winWidth - wallDistance) then
			current_boid.ax = current_boid.ax - (wallDistance - (winWidth - current_boid.x)) * wallForce
		end

		if current_boid.y < wallDistance then
			current_boid.ay = current_boid.ay + (wallDistance - current_boid.y) * wallForce
		elseif current_boid.y > (winHeight - wallDistance) then
			current_boid.ay = current_boid.ay - (wallDistance - (winHeight - current_boid.y)) * wallForce
		end
]]

		--pull towards center of nearby boids
		flockCenterX = flockCenterX / flockCount
		flockCenterY = flockCenterY / flockCount

		current_boid.ax = current_boid.ax + ((flockCenterX - current_boid.x) * current_boid.forceFlock)
		current_boid.ay = current_boid.ay + ((flockCenterY - current_boid.y) * current_boid.forceFlock)

		--match angle of nearby boids
		flockVx = flockVx / flockCount
		flockVy = flockVy / flockCount

		current_boid.ax = current_boid.ax + (flockVx * current_boid.forceAngle)
		current_boid.ay = current_boid.ay + (flockVy * current_boid.forceAngle)	

--[[
		--add random force
		current_boid.forceRandom = current_boid.forceRandom + math.random(-.01,.01)
		current_boid.ax = current_boid.ax + (current_boid.forceRandom * math.random(-1,1))
		current_boid.ay = current_boid.ay + (current_boid.forceRandom * math.random(-1,1))
]]	

		--update velocity based on acceleration
		current_boid.vx = (current_boid.vx + current_boid.ax) * current_boid.forceDamping
		current_boid.vy = (current_boid.vy + current_boid.ay) * current_boid.forceDamping


		--limit velocity if needed according to boid.vmax
		current_boid.vel = limitLength(current_boid.vel,current_boid.vmax)

	end
end


function moveBoids(dt)
	for i,v in ipairs(Boids) do
		--update x, y based on speed
		v.x = (v.x + v.vx * dt) % winWidth
		v.y = (v.y + v.vy * dt) % winHeight

		if v.x ~= v.x then
			v.x = 200
			v.y = 200
			v.vx = 10
			v.vy = 10
			v.ax = 0
			v.ay = 0
		end

	end
end

function drawBoid(b)
	local angle = math.atan2(b.vy, b.vx)
	love.graphics.circle("line",b.x,b.y,3)
	love.graphics.line(b.x,b.y,b.x + 8*math.cos(angle),b.y + 8*math.sin(angle))
end