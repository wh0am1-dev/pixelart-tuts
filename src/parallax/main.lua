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
	for i=0,4 do
		local bg = {x=0,y=0}
		bg.image = love.graphics.newImage("bg_" .. i .. ".png")

		table.insert(entities,bg)
	end

	entities[1].scroll = 0
	entities[2].scroll = 0.1
	entities[3].scroll = 0.2
	entities[4].scroll = 0.3
	entities[5].scroll = 0.8
end

function love.update(dt)
	-- Move the camera with the mouse position
	camera.x = love.mouse.getX() - window_width*window_scale/2
	camera.y = love.mouse.getY() - window_height*window_scale/2
end

function love.draw(...)
	-- Let's draw everything in the canvas
	love.graphics.setCanvas(canvas)

	for k,e in pairs(entities) do
		-- *************************************************
		-- *** This is where the parallax magic happens! ***
		-- *************************************************
		local render_x, render_y
		render_x = (e.x - camera.x) * e.scroll
		render_y = (e.y - camera.y) * e.scroll

		love.graphics.draw(e.image, math.floor(render_x), math.floor(render_y) )
	end

	-- Draw canvas into the screen
	love.graphics.setCanvas()
	love.graphics.draw(canvas, 0, 0, 0, window_scale, window_scale)
	
	love.graphics.print("camera x,y = " .. camera.x .. ", " .. camera.y, 5, 5)
end

