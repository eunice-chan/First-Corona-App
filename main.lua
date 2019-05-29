-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------


--variables
local left = 0-(display.actualContentWidth - display.contentWidth)/2
local top = 0-(display.actualContentHeight - display.contentHeight)/2
local right = display.contentWidth + (display.actualContentWidth - display.contentWidth)/2
local bottom = display.contentHeight + (display.actualContentHeight - display.contentHeight)/2

local endText = "Game over!"

local ballsGroup = display.newGroup()
local gradient

math.randomseed( os.time() )

-- display
local background = display.newImageRect("background.png", 360, 570)
background.x = display.contentCenterX
background.y = display.contentCenterY

local ball = display.newCircle(112, 112, 50)
gradient = {
    type="gradient",
    color1={ 1, 0.2, 0.1 }, color2={ 0.7, 0.8, 0.3 }, direction="down"
}
ball:setFillColor(gradient)

local endText = display.newText("", display.contentCenterX, 20, native.systemFont, 40 )
endText:setFillColor(0, 0, 0)


-- physics
local physics = require("physics")
physics.start()
physics.setGravity(0, 9)
physics.addBody(ball, {radius=50})


-- interaction
local function pushBall()
    ball:applyTorque(10)
    ball:applyLinearImpulse( 0, -0.75, ball.x, ball.y )
end

ball:addEventListener( "tap", pushBall )

local function isAtBottom( self, event )
   buffer = self.y/2
   if( (self.y + self.y/2) > bottom ) then
        endText.text = endText
   end
end

ball.enterFrame = isAtBottom
Runtime:addEventListener( "enterFrame", ball )
