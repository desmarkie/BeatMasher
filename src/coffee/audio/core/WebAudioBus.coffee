###
	=========================================
	WebAudioBus
	=========================================
	@version : 0.0.1
	@author  : desmarkie
	-----------------------------------------
	Simple bus to provide ability for custom
	AudioNode objects
	-----------------------------------------
	Notes:
		Should be extended, does not connect
		input to output by default
	-----------------------------------------
###
class WebAudioBus

	constructor: (@context) ->
		@input = @context.createGain()
		@output = @context.createGain()

	connect: (target) =>
		@output.connect target
		null

	setVolume: ( vol ) =>
		@output.gain.value = vol
		null