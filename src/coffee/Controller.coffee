# import audio.WebAudioManager
# import audio.utils.SampleLoader
class Controller

	constructor: ( @view, @model ) ->

		@model.audioManager = new WebAudioManager()

		@signals = 
			tick: 			new signals.Signal()
			sampleDrop: 	new signals.Signal()
			loadError:		new signals.Signal()
			loadComplete: 	new signals.Signal()
			playSample:		new signals.Signal()
			selectSample:	new signals.Signal()

		#listeners added directly to signals
		@signals.sampleDrop.add @handleSampleDrop
		@signals.loadError.add @handleLoadError
		@signals.loadComplete.add @handleLoadComplete
		@signals.playSample.add @handlePlaySample

		#listeners added via object methods
		@view.addEvents @signals

		#listeners added to DOM
		document.body.onmousemove = @handleMouseMove

		#off we go!
		@update()

	update: =>
		@signals.tick.dispatch()

		requestAnimationFrame @update
		null

	handlePlaySample: ( label ) =>
		@model.audioManager.playSample label
		null

	handleLoadError: ( message ) =>
		console.error 'ERROR:', message
		null

	handleLoadComplete: =>
		console.log 'Sample Loaded'
		null

		# called when file is dropped on canvas
	handleSampleDrop: ( src ) =>
		if !src.type.match(/audio.*/)
			@signals.loadError.dispatch 'Not an Audio File dropped on canvas'
			return

		SampleLoader.loadSample src, @handleSampleLoaded
		null

	handleSampleLoaded: ( result ) =>
		id = 'drop'+@model.dropId
		@model.dropId++

		@model.audioManager.loadSamples [{url:result, id:id}], =>
			@signals.loadComplete.dispatch id, @signals.selectSample
		null
	

	handleMouseMove: ( e ) =>
		# console.log 'mousemove', e
		@model.mousePos.x = e.pageX
		@model.mousePos.y = e.pageY

		null