###
	=========================================
	SamplePlayer
	=========================================
	@version : 0.0.1
	@author  : desmarkie
	-----------------------------------------
	Plays AudioBufferNode objects
	provides volume control
	-----------------------------------------
	Requires:
		WebAudioBus
	-----------------------------------------
	options:
		(required) source - AudioBufferSourceNode
		(optional) volume - defaults to 1
		(optional) loop - defaults to false
		(optional) loopStart - start point of loop (seconds)
		(optional) loopEnd - end point of loop (seconds)
		(optional) delay - delay before firing note
		(optional) startPos - start position for initial play
		(optional) length - length for single play
		(optional) onComplete - callback for onended event
	-----------------------------------------
###
# import audio.core.WebAudioBus
class SamplePlayer extends WebAudioBus

	constructor: (context, props = {}) ->
		super context

		@source = context.createBufferSource()
		@source.buffer = props.source
		@source.connect @output

		@key = props.key

		@delay = 0
		@length = 0
		@startPos = 0

		if props.loop 		  then @source.loop 			  = props.loop
		if props.loopEnd 	  then @source.loopEnd 			  = props.loopEnd
		if props.loopStart 	  then @source.loopStart 		  = props.loopStart
		if props.playbackRate then @source.playbackRate.value = props.playbackRate
		if props.volume 	  then @output.gain.value 		  = props.volume
		if props.delay 		  then @delay 					  = props.delay
		if props.length 	  then @length 					  = props.length * @source.buffer.duration
		if props.startPos 	  then @startPos 				  = props.startPos * @source.buffer.duration

		if props.onComplete   then @source.onended			  = props.onComplete

		if @startPos != 0 or @length != 0
			@source.start @delay, @startPos, @length
		else
			@source.start @delay
		@startTime = context.currentTime

		# returns play position within section of sample (0..1)
	getPlayRatio: =>
		return (@context.currentTime - @startTime) / (@length / @source.playbackRate.value)

		# returns play position within entire sample (0..1)
	getSampleRatio: =>
		return ((@context.currentTime - @startTime) / (@source.buffer.duration / @source.playbackRate.value)) + (@startPos / @source.buffer.duration)
		
