function love.load(...)
	
	-- Setup canvas and rendering
	window_width, window_height, window_scale = 128, 128, 4
	love.window.setMode(window_width*window_scale, window_height*window_scale, {msaa = 0})
	canvas = love.graphics.newCanvas(window_width, window_height,"normal",0)
	canvas:setFilter("nearest", "nearest")

	-- Create sprites
	image_outine = love.graphics.newImage("image_outline.png")
	image_blink = love.graphics.newImage("image_blink.png")
	image_wave = love.graphics.newImage("image_wavy.png")
end

function love.update(dt)
	
end

function love.draw(...)
	-- Let's draw everything in the canvas
	love.graphics.setCanvas(canvas)

	-- Clear BG
	love.graphics.setColor(50, 80, 100)
	love.graphics.rectangle("fill", 0, 0, window_width, window_height)

	-- draw with outline
	love.graphics.setColor(0, 0, 0)
	love.graphics.draw(image_outine, 4, 10+1)
	love.graphics.draw(image_outine, 4, 10-1)
	love.graphics.draw(image_outine, 4+1, 10)
	love.graphics.draw(image_outine, 4-1, 10)

	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(image_outine, 4, 10)


	-- blinking sprite
	local game_time = math.floor(love.timer.getTime()*30) --30 is the framerate
	if game_time%4<2 then
		love.graphics.draw(image_blink, 44, 10)
	end

	-- wavy sprite
	local slice = image_wave:getHeight() / 10

	for i=0,9 do
		my_quad = love.graphics.newQuad(0, slice * i, image_wave:getWidth(), slice, image_wave:getWidth(), image_wave:getHeight())
		displace_x = math.floor(math.sin(love.timer.getTime()*10 + i*0.75))
		love.graphics.draw(image_wave, my_quad, 88 + displace_x, 10 + slice * i)
	end


	-- Draw canvas into the screen
	love.graphics.setCanvas()
	love.graphics.draw(canvas, 0, 0, 0, window_scale, window_scale)
end

