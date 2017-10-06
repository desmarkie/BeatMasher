class LightButton extends PIXI.DisplayObjectContainer

	constructor: (@label = 'Button') ->
		super()

		@on = false

		@bg = new PIXI.Sprite(PIXI.Texture.fromImage('img/light-button/light-button-base.png'))
		@red = new PIXI.Sprite(PIXI.Texture.fromImage('img/light-button/light-button-red.png'))
		@green = new PIXI.Sprite(PIXI.Texture.fromImage('img/light-button/light-button-green.png'))
		@blue = new PIXI.Sprite(PIXI.Texture.fromImage('img/light-button/light-button-blue.png'))
		@orange = new PIXI.Sprite(PIXI.Texture.fromImage('img/light-button/light-button-orange.png'))
		@redMute = new PIXI.Sprite(PIXI.Texture.fromImage('img/light-button/light-button-red-mute.png'))
		@greenMute = new PIXI.Sprite(PIXI.Texture.fromImage('img/light-button/light-button-green-mute.png'))
		@blueMute = new PIXI.Sprite(PIXI.Texture.fromImage('img/light-button/light-button-blue-mute.png'))
		@orangeMute = new PIXI.Sprite(PIXI.Texture.fromImage('img/light-button/light-button-orange-mute.png'))

		@red.alpha = @green.alpha = @blue.alpha = @orange.alpha = 0
		@redMute.alpha = @greenMute.alpha = @blueMute.alpha = @orangeMute.alpha = 0

		@muteColor = @orangeMute
		@activeColor = @orange

		@addChild @bg
		@addChild @redMute
		@addChild @greenMute
		@addChild @blueMute
		@addChild @orangeMute
		@addChild @red
		@addChild @green
		@addChild @blue
		@addChild @orange

	
	###
	---------------
      P U B L I C  
    ---------------
	###

	turnOn: =>
		@on = true
		TweenMax.to @muteColor, 0.1, {alpha:1, ease:Sine.easeOut}
		null

	turnOff: =>
		@on = false
		TweenMax.to @muteColor, 0.1, {alpha:0, ease:Sine.easeOut}
		null

	hit: =>
		TweenMax.killTweensOf @activeColor
		TweenMax.to @activeColor, 0.1, {alpha:1, ease:Sine.easeOut}
		null

	release: =>
		TweenMax.to @activeColor, 0.1, {alpha:0, ease:Sine.easeOut}
		null

	pulse: =>
		@activeColor.alpha = 1
		TweenMax.to @activeColor, 0.075, {alpha:0, ease:Sine.easeOut}
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

		if @activeColor != lastColor
			@addChild @muteColor
			if @on
				TweenMax.to @muteColor, 0.1, {alpha:1, ease:Sine.easeOut, onComplete: =>
					lastMute.alpha = 0
				}
				@activeColor.alpha = 0
				lastColor.alpha = 0
				@addChild @activeColor

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

		@text.position.x = @text.position.y = (@padding * 0.5)

		null

	onButtonOver: ( interactionData ) =>
		null

	onButtonOut: ( interactionData ) =>
		null

	onButtonClick: ( interactionData ) =>
		null
