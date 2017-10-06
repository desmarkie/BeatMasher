# import ui.SimpleButton
class SampleAdjustButtons extends PIXI.DisplayObjectContainer

	constructor: (@sliceEditor, @label = 'Adjuster', initialValue = 1.000) ->
		super()

		@value = initialValue

		@title = @addText @label
		@title.position.x = 100
		@display = @addText ''

		@setValue @value

		@buttons = []
		vals = ['o ', 't ', 'h ', 'th']

		for val in vals
			plus  = @addButton '+' + val
			minus = @addButton '-' + val
			plus.position.y  = 20
			minus.position.y = 54
			if @buttons.length > 2
				prev = @buttons[@buttons.length - 3]
				plus.position.x = minus.position.x = prev.position.x + prev.width + 5

		@display.position.x = @buttons[0].padding * 0.5

	setValue: ( val ) ->
		@value = val
		str = @value.toString()
		if str.indexOf('.') != -1
			vals = str.split '.'
			vals[1] = vals[1].substr 0, 3
			str = vals[0]+'.'+vals[1]
		else
			if str.length < 4 then str += '.'

		while str.length < 5
				str = str + '0'

		@display.setText str
		null

	addButton: ( val ) ->
		but = new SimpleButton val
		but.onButtonClick = @handleButtonClick
		but.enable()
		@addChild but
		@buttons.push but
		return but
		
	addText: ( val ) ->
		text = new PIXI.Text val, {font:'11px "Lucida Console"', fill:'#3f3f3f'}
		@addChild text
		return text

	handleButtonClick: ( interactionData ) =>
		@sliceEditor.signals.adjustButtonUpdated.dispatch @, interactionData
		null