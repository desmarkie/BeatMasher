# import ui.*
class BeatSliceEditor extends PIXI.DisplayObjectContainer

	constructor: ( @audioManager ) ->
		super()

		@props =
			playbackRate: 1
			startPos: 0
			length: 1

		@buttons = []
		@sample = ''
		@samplePlayer = null

		# @signals =
		# 	adjustButtonUpdated: new signals.Signal()

		# @signals.adjustButtonUpdated.add @onPropertiesUpdated

		@sampleDisplay = new SampleDisplay 257, 60

		@modifying = null
		
		# @playbackRateControl = new SampleAdjustButtons @, 'Playback Rate'
		# @playbackRateControl = new Slider {slideWidth:200, slideSize:30, label:'Playback Rate', rangeEnd:2, initialValue:0.5}
		# @playbackRateControl.position.y = 108

		# @startControl = new SampleAdjustButtons @, 'Start Position', 0
		# @startControl = new Slider {slideWidth:200, slideSize:30, label:'Start Position'}
		# @startControl.position.y = 165
		
		# @endControl = new Slider {slideWidth:200, slideSize:30, label:'End Position', initialValue:1}
		# @endControl.position.y = 222

		# @playbackRateControl.onValueUpdated =
		# @startControl.onValueUpdated = 
		# @endControl.onValueUpdated = @onPropertiesUpdated

		# nudge = 40
		# @startControl.position.y -= nudge
		# @endControl.position.y -= nudge * 2

		# @sampleType = new SampleOptionButtons @, ['Single', 'Loop']
		# @sampleType.position.x = 305
		# @sampleType.position.y = 105

		# toAdd = @audioManager.getAllSampleIds()
		# ct = 0
		# for id in toAdd
		# 	but = @addButton id, 305, 35 + (ct * 35), @handleSampleClick
		# 	ct++

		# but = @addButton 'Play', 305, 0, @handlePlayClick

		@addChild @sampleDisplay
		# @addChild @playbackRateControl
		# @addChild @startControl
		# @addChild @endControl
		# @addChild @sampleType

		# @endControl.enable()
		# @startControl.enable()
		# @playbackRateControl.enable()

	addButton: ( text, x, y, click ) ->
		but = new SimpleButton text
		but.onButtonClick = click
		but.position.x = x
		but.position.y = y
		but.enable()
		@buttons.push but
		@addChild but
		return but

	enableTouchScreen: =>
		@sampleDisplay.buttonMode = true
		@sampleDisplay.interactive = true
		@sampleDisplay.mousedown = @sampleDisplay.touchstart = @handleTouchDown
		null

	diableTouchScreen: =>
		@sampleDisplay.buttonMode = false
		@sampleDisplay.interactive = false
		@sampleDisplay.mousedown = @sampleDisplay.touchstart = null
		null

	getNearestPoint: ( touchPos ) =>
		startDif = Math.abs(@props.startPos - touchPos)
		endDif = Math.abs((@props.startPos+@props.length) - touchPos)
		if endDif < startDif then return 'end' else return 'start'

	handleTouchDown: (interactionData) =>
		# console.log 'TOUCH DOWN', interactionData.getLocalPosition(@sampleDisplay).x/@sampleDisplay.width
		@modifying = @getNearestPoint interactionData.getLocalPosition(@sampleDisplay).x/@sampleDisplay.width
		@sampleDisplay.mousemove = @sampleDisplay.touchmove = @handleTouchMove
		@sampleDisplay.mouseup = @sampleDisplay.mouseupoutside = 
		@sampleDisplay.touchend = @sampleDisplay.touchendoutside = @handleTouchEnd
		null

	handleTouchMove: (interactionData) =>
		if @modifying is 'start'
			@props.startPos = interactionData.getLocalPosition(@sampleDisplay).x/@sampleDisplay.width
			if @signals != null then @signals.dispatch 'start', @props.startPos
		else if @modifying is 'end'
			endPos = interactionData.getLocalPosition(@sampleDisplay).x/@sampleDisplay.width
			length = endPos - @props.startPos
			@props.length = length
			if @signals != null then @signals.dispatch 'length', @props.length
		@sampleDisplay.drawPlayArea @props.startPos, @props.startPos+@props.length
		null

	handleTouchEnd: (interactionData) =>
		@modifying = null
		null

	drawSample: ( id, callback ) =>
		if id is 'empty'
			@sampleDisplay.clear()
		else
			@sampleDisplay.readSample @audioManager.sampleLib.getSampleBuffer(id), callback
		null

	setProperties: ( props, sampleId ) =>
		
		if props is 'empty'
			@sampleDisplay.clear()
		else
			for key of props
				# console.log 'setting '+key+' to '+props[key]
				@props[key] = props[key]
			@setSample sampleId
			@sampleDisplay.drawPlayArea props.startPos, props.startPos+props.length
		
		# @playbackRateControl.setRangedValue @props.playbackRate || 1
		# @startControl.setRangedValue @props.startPos || 0
		# @endControl.setRangedValue (@props.startPos || 0) + (@props.length || 1)
		# @sampleDisplay.drawPlayArea @startControl.getRangedValue(), @endControl.getRangedValue()
		null

	setSample: (id, callback) =>
		@currentSample = id
		@drawSample id, callback
		# @props.sampleId = id
		null

	setSampleButton: ( buttonId ) =>
		@props['sampleId'] = buttonId
		null

	update: =>
		if @samplePlayer != null and @sampleDisplay != null
			bufferRatio = @samplePlayer.getSampleRatio()
			@sampleDisplay.drawProgress bufferRatio
			dur = @samplePlayer.source.buffer.duration
			if bufferRatio > 1 or bufferRatio - (@samplePlayer.startPos / dur) > @samplePlayer.length / dur
				@samplePlayer = null

		# @playbackRateControl.update()
		# @startControl.update()
		# @endControl.update()
		null

	getAddValue: ( id ) ->
		mult = if id.charAt(0) is '+' then 1 else -1
		val = 0
		str = id.substr 1, id.length
		switch str
			when 'o ' then val = 1
			when 't ' then val = 0.1
			when 'h ' then val = 0.01
			when 'th' then val = 0.001
			else val = 0

		return val * mult

	handlePlayClick: =>
		if @samplePlayer != null
			@audioManager.stopSample @samplePlayer.key
		@samplePlayer = @audioManager.playSample @currentSample, @props
		null

	handleSampleClick: ( interactionData ) =>
		console.log 'click', interactionData.target.label
		@setSample interactionData.target.label
		null

	onPropertiesUpdated: =>
		@props.playbackRate = @playbackRateControl.getRangedValue()
		@props.startPos = @startControl.getRangedValue()
		@props.length = @endControl.getRangedValue() - @props.startPos
		
		@sampleDisplay.drawPlayArea @props.startPos, @endControl.getRangedValue()

		@signals.adjustButtonUpdated.dispatch()
		null

