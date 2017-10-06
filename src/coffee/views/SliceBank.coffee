# import ui.LightButton
class SliceBank extends PIXI.DisplayObjectContainer

	constructor: (@audioManager) ->
		super()

		@currentSlice = ''
		@buttons = {}

		@signals = null

		tx = 0
		ty = 0
		spacing = 66
		for i in [0...16]
			key = i.toString()
			but = new LightButton key
			but.position.x = tx * spacing
			but.position.y = ty * spacing
			@buttons[key] = but

			@addChild but

			but.mousedown = but.touchstart = @handleButtonClick
			but.enable()

			tx++
			if tx == 4
				tx = 0
				ty++

	setPadStates: ( data ) =>
		for key of data
			if key != 'samples'
				@buttons[key].setColor data[key].props.color
				# console.log 'setting pad state', data[key].props.sampleId
				if data[key].props.sampleId is 'empty' then @buttons[key].turnOff() else @buttons[key].turnOn()
				if data[key].player is null then @buttons[key].release()
		null

	setPatternStates: ( pattern ) =>
		for i in [0...16]
			if pattern[i] then @buttons[i.toString()].turnOn() else @buttons[i.toString()].turnOff()
		null

	showSliceTargets: ( startId ) =>
		for i in [startId...16]
			@buttons[i.toString()].turnOn()
			if i is startId then @buttons[i.toString()].hit()
		null

	hitButton: ( id ) =>
		@buttons[id].hit()
		null

	releaseButton: ( id ) =>
		@buttons[id].release()
		null

	setButtonOn: ( id, val = true ) =>
		if val then @buttons[id].turnOn() else @buttons[id].turnOff()
		null

	pulseButton: ( id ) =>
		@buttons[id].pulse()
		null

	handleButtonClick: ( interactionData ) =>
		if @signals != null then @signals.dispatch interactionData.target.label
		null

	###

	MOVE
	

	###

	selectSlice: ( id ) =>
		@currentSlice = if @currentSlice is id then '' else id
		console.log 'selectSlice', id
		if @currentSlice != '' and @slots[@currentSlice].props == 'empty'
			slice = @slots[@currentSlice]
			slice.props = 
				playbackRate: 1
				sampleId: 'amen'
				startPos: 0
				length: 1
		null

	updateProperties: ( props ) =>
		if @currentSlice is '' then return
		slice = @slots[@currentSlice]
		for key of props
			slice.props[key] = props[key]
		null

	

