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
local ending = "GO UP!"

-- display
local background = display.newImageRect( "background.png", 360, 570 )
background.x = display.contentCenterX
background.y = display.contentCenterY

local platform = display.newImageRect( "platform.png", 300, 50 )
platform.x = display.contentCenterX
platform.y = display.contentHeight-25

local balloon = display.newImageRect( "balloon.png", 112, 112 )
balloon.x = display.contentCenterX
balloon.y = display.contentCenterY

local endText = display.newText( ending, display.contentCenterX, 20, native.systemFont, 40 )


-- physics
local physics = require( "physics" )
physics.start()
physics.addBody( platform, "static" )
physics.addBody( balloon, { radius=50, bounce=0.3 } )


-- interaction
local function pushBalloon()
    balloon:applyLinearImpulse( 0, -0.75, balloon.x, balloon.y )
end

balloon:addEventListener( "tap", pushBalloon )

local function isOnScreenByCenter( self, event )
   buffer = self.y/2
   if( (self.x + self.x/2) > right ) then
        ending = "game over"
        endText.text = "game over"
   end
   if( (self.x - self.x/2) < left) then
        ending = "game over"
        endText.text = "game over"
   end
   if( (self.y + self.y/2) > bottom ) then
        ending = "game over"
        endText.text = "game over"
   end
   if( (self.y - self.y/2) < top ) then
        ending = "game over"
        endText.text = "game over"
   end
end

balloon.enterFrame = isOnScreenByCenter
Runtime:addEventListener( "enterFrame", balloon )
