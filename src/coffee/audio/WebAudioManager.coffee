###
	=========================================
	WebAudioManager
	=========================================
	@version : 0.0.1
	@author  : desmarkie
	-----------------------------------------
	Sound manager for javascript applications
	utilising the WebAudio API
	-----------------------------------------
###

# import audio.WebAudioSampleLibrary
# import audio.modules.*
class WebAudioManager

	constructor: ->
		@context = WebAudioManager.GetContext()

		# TODO remove this DEBUG reference
		if DEBUG then console.log 'new WebAudioManager ::', @context.toString()

		@input = @context.createGain()
		@output = @context.createGain()

		@input.connect @output
		@output.connect @context.destination

		@sampleLib = new WebAudioSampleLibrary @context

		@key = 0
		@samples = {}
		@loops = {}

		

	###
	---------------
      P U B L I C  
    ---------------
	###

		# Set overall volume
		# @param vol - Target Volume
	setVolume: ( vol ) =>
		@output.gain.value = vol
		null

		# Stop any playing sounds
	stopAllSounds: =>
		for key of @samples
			@stopSample key

		for key of @loops
			@stopLoop key
		null

		# Play a sample from the Library
		# @param id - ID of sample (URL if none provided)
		# @param props - properties for sample playback (see modules/SamplePlayer for info)
		# returns SamplePlayer object 
	playSample: ( id, props = {} ) =>
		key = @getKey()
		props.source = @sampleLib.getSampleBuffer id
		props.key = key
		props.onComplete = =>
			@handleSampleEnd key

		sample = new SamplePlayer @context, props
		sample.connect @input

		@samples[key] = sample
		return sample

		# Stop a sample
		# @param id - ID of sample (URL if none provided)
	stopSample: ( key, delay = 0 ) =>
		if !@samples[key] then return
		@samples[key].source.stop delay
		delete @samples[key]
		null

		# Loop a sample from the library
		# @param id - ID of sample (URL if none provided)
		# @param props - properties for sample playback (see modules/SamplePlayer for info)
		# @param key - reference to stop loop with
	playLoop: ( id, key, props = {} ) =>
		props.loop = true
		props.source = @sampleLib.getSampleBuffer id
		sample = new SamplePlayer @context, props
		sample.connect @input

		@loops[key || @getKey()] = sample
		null

		# Stop a loop
		# @param id - ID of sample (URL if none provided)
	stopLoop: ( key ) =>
		if !@loops[key] then return
		@loops[key].source.stop()
		delete @loops[key]
		null

		# Load an array of sample objects (see WebAudioSampleLibrary for info)
	loadSamples: (samples, callback) =>
		@sampleLib.loadFiles samples, callback
		null
	
		# return an array of all available sample ids
	getAllSampleIds: =>
		return @sampleLib.getAllIds()

	###
	-----------------
      P R I V A T E  
    -----------------
	###

		# generate a unique(ish) key for storing samples
	getKey: =>
		ret = @key.toString()
		@key++
		@key %= 10000
		return ret 

	handleSampleEnd: (key) =>
		delete @samples[key]
		null

	###
	---------------
      S T A T I C  
    ---------------
	###

		# returns new AudioContext
	@GetContext: =>
		if typeof AudioContext != 'undefined'
			return new AudioContext()
		else if typeof webkitAudioContext != 'undefined'
			return new webkitAudioContext()
		else
			throw new Error 'AudioContext not supported'
		null