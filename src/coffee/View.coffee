# import views.SampleBankView
# import views.SampleEditView
class View

	constructor: ( @model ) ->

		@pixi = PIXI.autoDetectRenderer window.innerWidth, window.innerHeight
		@stage = new PIXI.Stage 0x323232

		document.body.appendChild @pixi.view

		@sampleBankView = new SampleBankView()
		@sampleBankView.position.x = 
		@sampleBankView.position.y = 30
		@stage.addChild @sampleBankView

		@sampleEditView = new SampleEditView()
		@sampleEditView.position.x = 240
		@sampleEditView.position.y = 30
		@stage.addChild @sampleEditView



	addEvents: ( signals ) ->
		@pixi.view.addEventListener 'dragover', (e) =>
			e.preventDefault()
			null

		@pixi.view.addEventListener 'drop', (e) =>
			e.preventDefault()
			signals.sampleDrop.dispatch e.dataTransfer.files[0]
			null

		signals.tick.add @render

		signals.loadComplete.add @addSampleToBank

		signals.selectSample.add @editSample

		null

	render: =>
		# console.log 'RENDER'
		@pixi.render @stage

		null

	editSample: ( label ) =>
		# @audioManager.sampleLib.getSampleBuffer(id), callback
		@sampleEditView.openSample @model.audioManager.sampleLib.getSampleBuffer(label)
		null

	addSampleToBank: ( label, playSignal ) =>
		
		but = @sampleBankView.addSample label
		but.interactive = true
		but.buttonMode = true
		but.click = =>
			playSignal.dispatch label

		null