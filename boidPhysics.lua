--Vector Math
--Sum vectors of any dimension 2+ from a list of vectors
function sumVectors(listOfVectors)

	--vector to be returned
	local vectorSum = {}

	for i, v in listOfVectors do
		for j, w in v do
			vectorSum[i] = vectorSum[i] + w

	return vectorSum

--return length of vector
function vectorLength(vector)
	local squareSum = 0

	for i, v in vector do
		squareSum = squareSum + v^2

	local length = math.sqrt(squareSum)

	return length

--returns vector in same direction with length of one
function normalizeVector(vector)
	return vector/vectorLength(vector)

--if vector length exceeds max length, returns vector with max length
function limitLength(vector, maxLength)
	if vectorLength(vector) > maxLength then
		return normalizeVector(vector) * maxLength
	else
		return vector

function angle2D(vector)
	return math.atan2(vector[2], vector[1])

function rotateVector2D(vector, radians)
	local newX = vector[1] * math.cos(radians) - vector[2] * math.sin(radians)
	local newY = vector[1] * math.sin(radians) + vector[2] * math.cos(radians)
	return({newX, newY})


--======================================================================
--Point math

function distance(point1, point2)
	local squares = {}
	local distance = 0

	for i, v in point1 do
		squares[i] = (v - point2[i])^2

	for i, v in squares do
		distance = distance + v

	return math.sqrt(distance)
