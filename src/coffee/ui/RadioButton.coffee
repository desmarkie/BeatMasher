class RadioButton extends PIXI.DisplayObjectContainer

	constructor: (@innerRadius = 5, @outerRadius = 10, @innerColor = 0x3f3f3f, @outerColor = 0x3f3f3f, @outerWeight = 1) ->
		super()
		@isActive = false

		@inner = new PIXI.Graphics()
		@outer = new PIXI.Graphics()

		@addChild @outer
		@addChild @inner

		@draw()


	setState: ( state ) =>
		@isActive = state
		@draw()
		null


	draw: ->
		@inner.clear()
		if @isActive
			@inner.beginFill @color
			@inner.drawCircle 0, 0, @innerRadius
			@inner.endFill()

		@outer.clear()
		@outer.beginFill 0xFFFFFF, 0.01
		@outer.lineStyle 1, @color
		@outer.drawCircle 0, 0, @outerRadius
		@outer.endFill()
		null
