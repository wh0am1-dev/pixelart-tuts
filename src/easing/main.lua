
-- BASIC EASING FUNCIONS CHEAT CHEET
-- (most of them are based on glide by Jacob Albano)
function ease_linear(t)
	return t
end

function ease_cube_in(t)
	return t * t * t
end

function ease_cube_in_out(t)
	if t <= .5 then
		return t * t * t * 4
	else
		t = t - 1
		return 1 + t * t * t * 4
	end
end

function ease_cube_out(t)
	t = t - 1
	return 1 + t * t * t
end

function ease_back_in(t)
	return t * t * (2.70158 * t - 1.70158)
end

function ease_back_out(t)
	t = t - 1
	return (1 - t * t * (-2.70158 * t - 1.70158))
end

function ease_back_in_out(t)
	t = t * 2
    
    if (t < 1) then
    	return t * t * (2.70158 * t - 1.70158) / 2
    else
	    t = t - 2;
	    return (1 - t * t * (-2.70158 * t - 1.70158)) / 2 + .5
	end
end

function ease_elastic_in(t)
	return math.sin(13 * (math.pi/2) * t) * math.pow(2, 10 * (t - 1))
end

function ease_elastic_out(t)
	return math.sin(-13 * (math.pi/2) * (t + 1)) * math.pow(2, -10 * t) + 1
end

function ease_elastic_in_out(t)
	if (t < 0.5) then
        return 0.5 * (math.sin(13 * (math.pi/2) * (2 * t)) * math.pow(2, 10 * ((2 * t) - 1)))
    else
    	return 0.5 * (math.sin(-13 * (math.pi/2) * ((2 * t - 1) + 1)) * math.pow(2, -10 * (2 * t - 1)) + 2)
    end
end








-- Here's an application example
function love.load(...)
	
	-- Setup canvas and rendering
	window_width, window_height, window_scale = 128, 128, 4

	love.window.setMode(window_width*window_scale, window_height*window_scale, {msaa = 0})
	canvas = love.graphics.newCanvas(window_width, window_height,"normal",0)
	canvas:setFilter("nearest", "nearest")

	-- Create a camera
	camera = {x=0,y=0}

	-- Create entities list
	entities = {}

	-- Create some objects to draw on the screen
	table.insert(entities, {x=32, y=6 + 12*0, ease=ease_linear, 		t=0, duration=1, start_x=32, target_x=window_width - 32, name="linear"})
	table.insert(entities, {x=32, y=6 + 12*1, ease=ease_cube_in, 		t=0, duration=1, start_x=32, target_x=window_width - 32, name="cube_in"})
	table.insert(entities, {x=32, y=6 + 12*2, ease=ease_cube_in_out,	t=0, duration=1, start_x=32, target_x=window_width - 32, name="cube_in_out"})
	table.insert(entities, {x=32, y=6 + 12*3, ease=ease_cube_out, 		t=0, duration=1, start_x=32, target_x=window_width - 32, name="cube_out"})
	table.insert(entities, {x=32, y=6 + 12*4, ease=ease_back_in,		t=0, duration=1, start_x=32, target_x=window_width - 32, name="back_in"})
	table.insert(entities, {x=32, y=6 + 12*5, ease=ease_back_out, 		t=0, duration=1, start_x=32, target_x=window_width - 32, name="back_out"})
	table.insert(entities, {x=32, y=6 + 12*6, ease=ease_back_in_out,	t=0, duration=1, start_x=32, target_x=window_width - 32, name="back_in_out"})
	table.insert(entities, {x=32, y=6 + 12*7, ease=ease_elastic_in,		t=0, duration=1, start_x=32, target_x=window_width - 32, name="elastic_in"})
	table.insert(entities, {x=32, y=6 + 12*8, ease=ease_elastic_out,	t=0, duration=1, start_x=32, target_x=window_width - 32, name="elastic_out"})
	table.insert(entities, {x=32, y=6 + 12*9, ease=ease_elastic_in_out,	t=0, duration=1, start_x=32, target_x=window_width - 32, name="elastic_in_out"})
end

function love.update(dt)
	-- Very rudimentar entity update system
	for k,e in pairs(entities) do
		-- percent is time/duration
		local percent = e.t/e.duration

		if percent<=1 then
			-- moving only on the X, since this is just a simple example
			-- current_position = start_position + easing_function(percent) * distance_to_travel
			e.x = e.start_x + e.ease(percent) * (e.target_x - e.start_x)
		else
			-- if percent is bigger then 1, this means the tween is complete
			e.x = e.start_x + e.ease(1) * (e.target_x - e.start_x)
		end

		e.t = e.t + dt
	end

	if love.keyboard.isDown("space") then
		for k,e in pairs(entities) do
			e.t=0
		end
	end
end

function love.draw(...)
	-- Let's draw everything in the canvas
	love.graphics.setCanvas(canvas)

	-- clear canvas
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", 0, 0, window_width, window_height)

	-- Very rudimentar entity draw system
	for k,e in pairs(entities) do

		-- just some background rectangles so we can see the movement better 
		love.graphics.setColor(10,10,10)
		love.graphics.rectangle("fill", 0, e.y-2, window_width, 11)
		love.graphics.setColor(25,25,25)
		love.graphics.rectangle("fill", 30, e.y-1, (e.target_x - e.start_x) + 12 , 10)

		love.graphics.setColor(255 * e.t/e.duration, 255 * e.t/e.duration, 255, 255)
		love.graphics.rectangle("fill", e.x, e.y, 8, 8)
	end

	-- Draw canvas into the screen
	love.graphics.setCanvas()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(canvas, 0, 0, 0, window_scale, window_scale)

	love.graphics.setColor(255, 255, 255)
	for k,e in pairs(entities) do
		love.graphics.print(e.name, 8, e.y * window_scale + 16)
	end
end

