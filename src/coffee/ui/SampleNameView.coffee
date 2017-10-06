class SampleNameView extends PIXI.DisplayObjectContainer

	constructor: ( @label ) ->
		super()

		@text = new PIXI.Text @label, {fill:'white'}
		@text.position.x = 6
		@text.position.y = 3

		@border = new PIXI.Graphics()
		@border.lineStyle 2, 0xFFFFFF
		@border.beginFill 0, 0.3
		@border.drawRect 0, 0, 200, 40
		@border.endFill()

		@addChild @border
		@addChild @text