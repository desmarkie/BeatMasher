# import ui.SampleNameView
class SampleBankView extends PIXI.DisplayObjectContainer

	constructor: ->
		super()

		@buttons = []

	addSample: ( label ) ->
		
		but = new SampleNameView label
		but.position.y = @buttons.length * 44
		@addChild but
		@buttons.push but

		return but