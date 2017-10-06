class ContextButtons extends PIXI.DisplayObjectContainer

	constructor: ->
		super()

		@signals = null

		@buttons = []

		@aButton = @addButton 'A'
		@bButton = @addButton 'B', 66
		@cButton = @addButton 'C', 132
		@dButton = @addButton 'D', 198
		
		@eButton = @addButton 'E', 0, 32
		@fButton = @addButton 'F', 66, 32
		@gButton = @addButton 'G', 132, 32
		@hButton = @addButton 'H', 198, 32

		
		
		
		
		@aButton.click = @aButton.tap = 
		@bButton.click = @bButton.tap =
		@cButton.click = @cButton.tap =
		@dButton.click = @dButton.tap =
		@eButton.click = @eButton.tap =
		@fButton.click = @fButton.tap =
		@gButton.click = @gButton.tap = 
		@hButton.click = @hButton.tap = @buttonClicked

		@curButton = @aButton


	addButton: ( label, x = 0, y = 0 ) ->
		but = new OptionButton label
		but.position.x = x
		but.position.y = y
		but.enable()
		but.turnOn()
		@buttons.push but
		@addChild but

	pulse: =>
		for but in @buttons
			but.pulse()
		null

	hit: =>
		for but in @buttons
			but.hit()
		null

	release: =>
		for but in @buttons
			but.release()
		null


	select: ( id ) =>
		if id is 'B' then nextButton = @bButton
		if id is 'A' then nextButton = @aButton
		if id is 'C' then nextButton = @cButton

		if nextButton != @curButton
			@curButton.release()
			@curButton = nextButton

		@curButton.hit()

		null

	buttonClicked: (interactionData) =>
		target = interactionData.target
		msg = ''
		if target is @aButton then msg = 'A'
		else if target is @bButton then msg = 'B'
		else if target is @cButton then msg = 'C'
		else if target is @dButton then msg = 'D'
		else if target is @eButton then msg = 'E'
		else if target is @fButton then msg = 'F'
		else if target is @gButton then msg = 'G'
		else if target is @hButton then msg = 'H'

		if @signals != null then @signals.dispatch msg
		null