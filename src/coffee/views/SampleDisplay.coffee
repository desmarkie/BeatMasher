###
	=========================================
	SampleDisplay
	=========================================
	@version : 0.0.1
	@author  : desmarkie
	-----------------------------------------
	Creates a window for displaying audio
	waveforms and overlays
	-----------------------------------------
	dependencies:
		Pixi.js < http://www.pixijs.com >
	-----------------------------------------
###
class SampleDisplay extends PIXI.DisplayObjectContainer

	constructor: (@sampleWidth = 300, @sampleHeight = 100) ->
		super()
		# rendering
		@readingSample = false
		# background
		# @bg 			= new PIXI.Graphics()
		# @bg 			= new PIXI.Sprite(PIXI.Texture.fromImage('img/light-button/sample-display-bg.png'))
		# foreground
		# @fg 			= new PIXI.Sprite(PIXI.Texture.fromImage('img/light-button/sample-display-fore.png'))
		# draw the waveform data in here
		@waveHolder		= new PIXI.DisplayObjectContainer()
		@renderer 		= new PIXI.Graphics()
		# used for rendering the waveform in parts
		# @renderTex 		= new PIXI.RenderTexture @sampleWidth, @sampleHeight
		# @renderSprite 	= new PIXI.Sprite @renderTex
		# highlights play area
		@playArea		= new PIXI.Graphics()
		# draws progress lines on top of the waveform display
		@traceLines		= new PIXI.Graphics()
		# displays messages
		@text 			= new PIXI.Text '', {font:'23px Arial, sans-serif', fill:'#def5fd'}
		@text.position.x = 10
		@text.position.y = 18
		@text.alpha = 0

		# @addChild @bg
		@addChild @waveHolder
		# @addChild @playArea
		@addChild @traceLines
		@addChild @text
		# @addChild @fg
		@waveHolder.addChild @renderer
		# @waveHolder.addChild @renderSprite

		# @renderTex.render @waveHolder
		

		# Reads the data from the supplied source and draws to the canvas
	readSample: ( source, callback = null, grain = 5 ) =>
		if @readingSample then return
		@readingSample = true

		TweenMax.to @text, 0.1, {alpha:0, ease:Sine.easeOut}

		chan = source.getChannelData 0
		if source.numberOfChannels > 1
			chan2 = source.getChannelData 1
		else 
			chan2 = chan
		if grain < 1 then grain = 1
		skip = Math.floor chan.length / (@sampleWidth * grain)

		@renderTex = new PIXI.RenderTexture @sampleWidth, @sampleHeight
		if !@renderSprite
			@renderSprite 	= new PIXI.Sprite @renderTex
			@waveHolder.addChild @renderSprite
		@renderSprite.setTexture @renderTex

		halfHeight = @sampleHeight * 0.5
		@renderer.clear()
		for i in [0...chan.length] by skip
			x = 1 + ((@sampleWidth-2) * (i / chan.length))
			y = chan[i] * halfHeight
			# @renderer.clear()
			@renderer.lineStyle 0.2, 0xdef5fd
			# @renderer.lineStyle 0.1, 0xF3F3F3
			@renderer.beginFill 0, 0
			@renderer.moveTo x, halfHeight - y
			y = chan2[i] * halfHeight
			@renderer.lineTo x, halfHeight + y
			@renderer.endFill()
			# @renderTex.render @waveHolder

		# @renderer.clear()
		@readingSample = false
		@drawPlayArea()

		TweenMax.to @text, 0.1, {alpha:0, ease:Sine.easeOut}
		TweenMax.to @waveHolder, 0.1, {alpha:1, ease:Sine.easeOut}
		TweenMax.to @playArea, 0.1, {alpha:1, ease:Sine.easeOut}

		if callback != null then callback()

		null

	showMessage: ( msg ) =>
		@text.setText msg
		TweenMax.to @text, 0.1, {alpha:1, ease:Sine.easeOut}
		TweenMax.to @waveHolder, 0.1, {alpha:0, ease:Sine.easeOut}
		TweenMax.to @playArea, 0.1, {alpha:0, ease:Sine.easeOut}
		null

	drawPlayArea: (startRatio = 0, endRatio = 1, color = 0xdef5fd, alpha = 0.15) =>
		@playArea.clear()
		@playArea.beginFill color, alpha
		@playArea.drawRect startRatio*@sampleWidth, 1, (endRatio-startRatio)*@sampleWidth, @sampleHeight-1
		@playArea.endFill()
		null

	drawProgress: (ratio, color = 0x77D9FF) =>
		@traceLines.clear()
		if ratio < 1
			@traceLines.lineStyle 0.5, color
			@traceLines.moveTo ratio*@sampleWidth, 1
			@traceLines.lineTo ratio*@sampleWidth, @sampleHeight-2
		null

	clear: =>
		@traceLines.clear()
		@playArea.clear()
		@renderTex = new PIXI.RenderTexture @sampleWidth, @sampleHeight
		@renderSprite.setTexture @renderTex
		null


