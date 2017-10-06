###
	=========================================
	SimpleButton
	=========================================
	@version : 0.0.1
	@author  : desmarkie
	-----------------------------------------
	Basic pixi button skeleton
	-----------------------------------------
	dependencies:
		Pixi.js < http://www.pixijs.com >
	-----------------------------------------
###
class SimpleButton extends PIXI.DisplayObjectContainer

	constructor: ( @label = 'button' ) ->
		super()
		@text = new PIXI.Text @label, {font:'11px "Lucida Console", monospaced', fill:'#f3f3f3'}
		@bg   = new PIXI.Graphics()

		@padding = 20

		@addChild @bg
		@addChild @text

		@update()


	###
	---------------
      P U B L I C  
    ---------------
	###

		# updates text label on button
	setLabel: ( label ) =>
		@label = label
		@update()
		null

		# enable / disable
	enable: =>
		@interactive = @buttonMode  = true
		@click 	     = @onButtonClick
		@tap 		 = @onButtonClick
		@mouseover   = @onButtonOver
		@mouseout    = @onButtonOut
		null

	disable: =>
		@click = @tap = @mouseover = @mouseout = null
		@buttonMode = @interactive = false
		null


	###
	-------------------
      O V E R R I D E  
    -------------------
	###
	update: =>
		@text.setStyle {font:'11px "Lucida Console"', fill:'#f3f3f3'}
		@text.setText @label
		
		@bg.clear()
		@bg.beginFill 0x5f5f5f
		@bg.drawRect 0, 0, @text.width+@padding, @text.height+@padding
		@bg.endFill()

		@text.position.x = @text.position.y = (@padding * 0.5)

		null

	onButtonOver: ( interactionData ) =>
		null

	onButtonOut: ( interactionData ) =>
		null

	onButtonClick: ( interactionData ) =>
		null
