# import views.SampleDisplay
class SampleEditView extends PIXI.DisplayObjectContainer

	constructor: ->
		super()

		@waveform = new SampleDisplay 600, 100

		@addChild @waveform

	openSample: ( sampleBuffer ) ->
		@waveform.readSample sampleBuffer
		null