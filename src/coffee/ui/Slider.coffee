###
Properties
	slideWidth - width of the slider (200)
	slideSize - size of the handle (30)
	label - title for the slider (Value)
	initialValue - (0)
	color - (0x5f5f5f)
	lineWidth - (1)
	lineColor - (0x0f0f0f)
###
class Slider extends PIXI.DisplayObjectContainer

	constructor: (props = {}) ->
		super()

		@slideWidth = props.slideWidth 	 || 200
		@slideSize  = props.slideSize 	 || 30
		@label 		= props.label 		 || 'Value'
		@slideValue = props.initialValue || 0
		@color 		= props.color 		 || 0x5f5f5f
		@lineWidth  = props.lineWidth 	 || 1
		@lineColor  = props.lineColor 	 || 0x0f0f0f
		@rangeStart = props.rangeStart	 || 0
		@rangeEnd	= props.rangeEnd	 || 1

		@handleUp = true
		@onValueUpdated = null

		@handle = new PIXI.Graphics()
		@line   = new PIXI.Graphics()
		@copy   = new PIXI.Text @label+' [ '+@slideValue+' ]', {font:'11px "Lucida Console", monospaced', fill:'#5f5f5f'}

		@addChild @line
		@addChild @handle
		@addChild @copy

		@minPos = @slideSize * 0.5
		@maxPos = @slideWidth - @minPos
		@dragDist = @slideWidth - @slideSize
		@midPos = @minPos + (@dragDist * 0.5)
		@dragStartPos = 0
		@handle.position.y = @slideSize * 0.5

		@copy.position.y = @slideSize + 5

		@draw()


	enable: =>
		@handle.interactive = true
		@handle.buttonMode = true
		@handle.touchstart = @handle.mousedown = @onDragStart
		null

	disable: =>
		@handle.interactive = false
		@handle.buttonMode = false
		@handle.touchstart = @handle.mousedown = null
		null


	getRangedValue: =>
		return @rangeStart + (@slideValue * (@rangeEnd - @rangeStart))

	setRangedValue: ( value ) =>
		total = @rangeEnd - @rangeStart
		@slideValue = value / total
		null


	update: =>
		# if @handleUp
		@handle.position.x = @minPos + (@slideValue * @dragDist)
		@copy.setText @label + '[' + (@rangeStart + (@slideValue * (@rangeEnd - @rangeStart))) + ']'

		null


	draw: ->
		@handle.clear()
		@handle.beginFill @color
		@handle.drawRect -@slideSize * 0.5, -@slideSize * 0.5, @slideSize, @slideSize
		@handle.endFill()

		@line.clear()
		@line.lineStyle @lineWidth, @lineColor
		# @line.moveTo @minPos, @slideSize * 0.5
		# @line.lineTo @maxPos, @slideSize * 0.5
		@line.drawRect 0, 0, @slideWidth, @slideSize

		null

	onDragStart: ( interactionData ) =>
		@dragStartPos = interactionData.getLocalPosition(@).x
		@handle.touchend = @handle.touchendoutside = @onDragEnd
		@handle.mouseup = @handle.mouseupoutside = @onDragEnd
		@handle.touchmove = @handle.mousemove = @onDragMove
		@handleUp = false
		null

	onDragMove: ( interactionData ) =>
		curPos = interactionData.getLocalPosition(@).x
		if curPos > @maxPos then curPos = @maxPos
		else if curPos < @minPos then curPos = @minPos
		@slideValue = (curPos-@minPos) / @dragDist
		if @onValueUpdated != null then @onValueUpdated()
		null

	onDragEnd: =>
		@handle.touchend = @handle.touchendoutside = null
		@handle.mouseup = @handle.mouseupoutside = null
		@handle.touchmove = @handle.mousemove = null
		@handleUp = true
		null

