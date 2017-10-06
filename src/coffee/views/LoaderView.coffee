class LoaderView extends PIXI.DisplayObjectContainer

	constructor: ->
		super()
		@text = new PIXI.Text 'L O A D I N G . . .', {font:'10px "Lucida Console"', fill:'#5f5f5f'}
		@text.anchor.x = @text.anchor.y = 0.5
		@addChild @text

		@position.x = Math.floor(window.innerWidth * 0.5)
		@position.y = Math.floor(window.innerHeight * 0.5)


	hide: ( callback ) =>
		TweenMax.to @, 0.8, {alpha:0, ease:Power4.easeOut, onComplete:callback}
		null

	show: =>

		null