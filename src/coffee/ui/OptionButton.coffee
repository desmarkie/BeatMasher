class OptionButton extends PIXI.DisplayObjectContainer

	constructor: (@label = 'Button') ->
		super()

		@on = false

		@bg   = new PIXI.Sprite(PIXI.Texture.fromImage('img/light-button/option-button-base.png'))
		@half = new PIXI.Sprite(PIXI.Texture.fromImage('img/light-button/option-button-half.png'))
		@full = new PIXI.Sprite(PIXI.Texture.fromImage('img/light-button/option-button-full.png'))
		@text = new PIXI.Text @label, {font:'bold 11px "Lucida Console", monospaced', fill:'#3f3f3f'}
		@text.anchor.x = @text.anchor.y = 0.5
		@text.position.x = 31
		@text.position.y = 18

		@half.alpha = @full.alpha = 0

		@addChild @bg
		@addChild @half
		@addChild @full
		@addChild @text

	
	###
	---------------
      P U B L I C  
    ---------------
	###

	turnOn: =>
		@on = true
		TweenMax.killTweensOf @half
		TweenMax.to @half, 0.1, {alpha:1, ease:Sine.easeOut}
		null

	turnOff: =>
		@on = false
		TweenMax.killTweensOf @half
		TweenMax.to @half, 0.1, {alpha:0, ease:Sine.easeOut}
		null

	hit: =>
		TweenMax.killTweensOf @full
		TweenMax.to @full, 0.1, {alpha:1, ease:Sine.easeOut}
		null

	release: =>
		# TweenMax.killTweensOf @full
		TweenMax.to @full, 0.1, {alpha:0, ease:Sine.easeOut}
		null

	setColor: ( color ) =>
		lastMute = @muteColor
		lastColor = @activeColor
		# red, green, orange, blue
		if color is 'red'
			@activeColor = @red
			@muteColor = @redMute
		if color is 'orange'
			@activeColor = @orange
			@muteColor = @orangeMute
		if color is 'blue'
			@activeColor = @blue
			@muteColor = @blueMute
		if color is 'green'
			@activeColor = @green
			@muteColor = @greenMute

		TweenMax.to @muteColor, 0.1, {alpha:1, ease:Sine.easeOut, onComplete: =>
			lastMute.alpha = 0
		}
		if @on
			@addChild @activeColor
			TweenMax.to @activeColor, 0.1, {alpha:1, ease:Sine.easeOut, onComplete: =>
				lastColor.alpha = 0
			}

		null

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
		@mousedown = @touchstart = =>
			@hit()
			@mouseup = @mouseupoutside = @touchend = @touchendoutside = =>
				@mouseup = @mouseupoutside = @touchend = @touchendoutside = null
				@release()
				null
			null
		null

	disable: =>
		@click = @tap = @mouseover = @mouseout = null
		@mousedown = @touchstart = @mouseup = @mouseupoutside = @touchend = @touchendoutside = null
		@buttonMode = @interactive = false
		null

	pulse: =>
		@hit()
		TweenMax.to @, 0.3, {onComplete:@release}
		null


	###
	-------------------
      O V E R R I D E  
    -------------------
	###
	update: =>
		@text.setStyle {font:'bold 11px "Lucida Console"', fill:'#3f3f3f'}
		@text.setText @label

		@text.position.x = (@width - @text.width) * 0.5
		@text.position.y = 5

		null

	onButtonOver: ( interactionData ) =>
		null

	onButtonOut: ( interactionData ) =>
		null

	onButtonClick: ( interactionData ) =>
		null
