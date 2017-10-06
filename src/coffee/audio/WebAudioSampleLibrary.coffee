###
	=========================================
	WebAudioSampleLibrary
	=========================================
	@version : 0.0.1
	@author  : desmarkie
	-----------------------------------------
	Stores loaded audio as 
	AudioBufferSourceNode objects
	-----------------------------------------
	notes:
		sample object format
		{url:<audio url>, id(optional):<defaults to url>}
	-----------------------------------------
###
class WebAudioSampleLibrary

		# @param @context AudioContext
		# @param @urlArray (optional array of sample objects to load)
	constructor: ( @context, @urlArray = [] ) ->
		@samples = {}


	###
	---------------
      P U B L I C  
    ---------------
	###

	getAllIds: =>
		arr = []
		for key of @samples
			arr.push key
		return arr

		# Returns an AudioBufferNode
	getSampleBuffer: ( id ) =>
		return @samples[id]

		# Loads files in urlArray
		# appends any supplied objects to urlArray
	loadFiles: ( arr = [], callback = null ) =>
		#append any new files
		for file in arr
			@urlArray.push file

		if @urlArray.length is 0
			if callback != null then callback()
			return

		#take first from url array
		obj = @urlArray.splice(0, 1)[0]
		url = obj.url
		id = obj.id || obj.url #defaults to url

		#load it
		@req = new XMLHttpRequest()
		@req.open 'GET', url, true
		@req.responseType = 'arraybuffer'
		@req.onload = =>
			# decode
			@context.decodeAudioData @req.response, (audioBuffer) =>
				#success - store buffer in samples object with id reference
				@samples[id] = audioBuffer
				#keep loading if there's files left
				@loadFiles [], callback
				null
			, =>
				#error - halts everything
				throw new Error 'Error Parsing audio file', url
				null
		@req.send()
		null

