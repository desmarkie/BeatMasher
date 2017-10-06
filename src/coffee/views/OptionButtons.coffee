class OptionButtons extends PIXI.DisplayObjectContainer

	constructor: ->
		super()

		@signals = null

		@padsButton = @addButton 'pads'
		@editButton = @addButton 'edit', 66
		@prgmButton = @addButton 'prgm', 132
		@tempoButton = @addButton 'tempo', 198
		
		@playButton = @addButton 'play', 0, 32
		@stopButton = @addButton 'stop', 66, 32
		@minusButton = @addButton '-', 132, 32
		@plusButton = @addButton '+', 198, 32

		@minusButton.click = @minusButton.tap = 
		@plusButton.click = @plusButton.tap =
		@playButton.click = @playButton.tap =
		@stopButton.click = @stopButton.tap =
		@editButton.click = @editButton.tap =
		@prgmButton.click = @prgmButton.tap =
		@padsButton.click = @padsButton.tap = 
		@tempoButton.click = @tempoButton.tap = @buttonClicked

		@curButton = @padsButton
		@curButton.hit()


	addButton: ( label, x = 0, y = 0 ) ->
		but = new OptionButton label
		but.position.x = x
		but.position.y = y
		but.enable()
		but.turnOn()
		@addChild but


	select: ( id ) =>
		if id is 'edit' then nextButton = @editButton
		if id is 'pads' then nextButton = @padsButton
		if id is 'prgm' then nextButton = @prgmButton

		if nextButton != @curButton
			@curButton.release()
			@curButton = nextButton

		@curButton.hit()

		null

	buttonClicked: (interactionData) =>
		target = interactionData.target
		msg = ''
		if target is @padsButton then msg = 'pads'
		else if target is @prgmButton then msg = 'prgm'
		else if target is @editButton then msg = 'edit'
		else if target is @stopButton then msg = 'stop'
		else if target is @playButton then msg = 'play'
		else if target is @plusButton then msg = 't++'
		else if target is @minusButton then msg = 't--'
		else if target is @tempoButton then msg = 'tempo'

		if @signals != null then @signals.dispatch msg

		if msg is 'play' then @playButton.hit()
		else if msg is 'stop' then @playButton.release()
		null