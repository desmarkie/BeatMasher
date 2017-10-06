# import ui.SimpleButton
class SampleOptionButtons extends PIXI.DisplayObjectContainer

	constructor: (@slideEditor, @options, @label = 'Options') ->
		super()

		@buttons = []
		@curOption = 0

		i = 0
		for opt in @options
			@addOptionButton opt, i
			i++

		@selectOption @curOption

	addOptionButton: (label, num) ->
		cont = new PIXI.DisplayObjectContainer()
		cont.position.y = 35 * num

		rad = new RadioButton 5, 10, 0x3f3f3f, 0x3f3f3f, 1
		rad.position.x = 
		rad.position.y = 15
		but = new SimpleButton label
		but.position.x = 35
		but.onButtonClick = @handleOptionSelect
		but.enable()

		cont.addChild but
		cont.addChild rad
		@addChild cont

		@buttons.push {cont:cont, but:but, rad:rad}
		null

	selectOption: ( id ) ->
		@curOption = id
		for i in [0...@buttons.length]
			@buttons[i].rad.setState i is @curOption
		null

	handleOptionSelect: ( interactionData ) =>
		label = interactionData.target.label
		for i in [0...@options.length]
			if label is @options[i]
				@selectOption i
				return
		null

