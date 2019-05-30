-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------


-- variables
local bottom = display.contentHeight + (display.actualContentHeight - display.contentHeight)/2
local endText = "Game over!"
local ballsGroup = display.newGroup()
local gradient

math.randomseed(os.time())

-- display
display.setStatusBar(display.HiddenStatusBar)

local background = display.newImageRect("background.png", 360, 570)
background.x = display.contentCenterX
background.y = display.contentCenterY

local endText = display.newText("", display.contentCenterX, 20, native.systemFont, 40 )
endText:setFillColor(0, 0, 0)


-- physics
local physics = require("physics")
physics.start()
physics.setGravity(0, 9)


-- functions
local function createBall()

end

local function pushBall()
    ball:applyTorque(math.random(-100, 100))
    ball:applyLinearImpulse( 0, -0.75, ball.x, ball.y )
end

local function isAtBottom( self, event )
   buffer = self.y/2
   if( (self.y + self.y/2) > bottom ) then
        endText.text = endText
   end
end
local ball = display.newCircle(180, 0, 50)
gradient = {
    type="gradient",
    color1={math.random(), math.random(), math.random()},
    color2={math.random(), math.random(), math.random()},
    direction="down"
    }
ball:setFillColor(gradient)
ball:addEventListener("tap", pushBall)
--ball:applyTorque(math.random(-100, 100))
--table.insert(ballsGroup, ball)
physics.addBody(ball, {radius=50})
ball.enterFrame = isAtBottom
Runtime:addEventListener("enterFrame", ball)
