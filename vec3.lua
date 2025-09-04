-- Operator overloading for vec3 functionality
-- vector metatable:
Vector = {}
Vector.__index = Vector

-- vector constructor:
function Vector.new(x, y, z)
  local v = {x = x or 0, y = y or 0, z = z or 0}
  setmetatable(v, Vector)
  return v
end

-- vector addition:
function Vector.__add(a, b)
  return Vector.new(a.x + b.x, a.y + b.y, a.z + b.z)
end

-- vector subtraction:
function Vector.__sub(a, b)
  return Vector.new(a.x - b.x, a.y - b.y, a.z - b.z)
end

-- multiplication of a vector by a scalar:
function Vector.__mul(a, b)
  if type(a) == "number" then
    return Vector.new(b.x * a, b.y * a, b.z * a)
  elseif type(b) == "number" then
    return Vector.new(a.x * b, a.y * b, a.x * b)
  else
    error("Can only multiply vector by scalar.")
  end
end

-- dividing a vector by a scalar:
function Vector.__div(a, b)
   if type(b) == "number" then
      return Vector.new(a.x / b, a.y / b, a.z / b)
   else
      error("Invalid argument types for vector division.")
   end
end

-- vector equivalence comparison:
function Vector.__eq(a, b)
	return a.x == b.x and a.y == b.y and a.z == b.z
end

-- vector not equivalence comparison:
function Vector.__ne(a, b)
	return not Vector.__eq(a, b)
end

-- unary negation operator:
function Vector.__unm(a)
	return Vector.new(-a.x, -a.y, -a.z)
end

-- vector < comparison:
function Vector.__lt(a, b)
	 return a.x < b.x and a.y < b.y and a.z < b.z
end

-- vector <= comparison:
function Vector.__le(a, b)
	 return a.x <= b.x and a.y <= b.y and a.z <= b.z
end

-- vector value string output:
function Vector.__tostring(v)
	 return "(" .. v.x .. ", " .. v.y .. ", " .. v.z .. ")"
end

-- ===================
-- Functions

-- return length of vector
function magnitude(v)
	return math.sqrt(v.x^2 + v.y^2 + v.z^2)
end

-- return normalized vector
function normalize(v)
	return v/magnitude(v)
end

-- return dot product of two vectors
function dotProduct(a, b)
	return (a.x * b.x) + (a.y * b.y) + (a.z * b.z)
end

-- return the cross product of two vectors
function crossProduct(a, b)
	return {(a.y * b.z - a.z * b.y), 
			(a.z * b.x - a.x * b.z),
			(a.x * b.y - a.y * b.x)}
end

-- return angle of a vector within a given plane, default to xy
function angle2(v, plane)
	plane = plane or "xy"
	if plane == "xy" then
		return math.atan2(v.y, v.x)
	elseif plane == "xz" then
		return math.atan2(v.z, v.x)
	elseif plane == "yz" then
		return math.atan2(v.z, v.y)
	else
		error("Invalid plane specified for vector angle.")
	end
end

-- return the distance between the ends of two vectors
function distance(a, b)
	return magnitude(b-a)
end

-- limit a vector's magnitude to a scalar
function vecLimit(v,lim)
	if magnitude(v) > lim then
		return normalize(v) * lim
	else
		return v
	end
end