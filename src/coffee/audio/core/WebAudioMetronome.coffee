###
	Based on the Chris Wilson tutorial here:
	http://www.html5rocks.com/en/tutorials/audio/scheduling/
###
# import audio.core.WebAudioBus
class WebAudioMetronome extends WebAudioBus

	constructor: (context) ->
		super context

		@isPlaying = false
		@startTime = null
		@currentBeat = 0
		@tempo = 120

		@lookAhead = 25
		@scheduleAheadTime = 0.1
		@timer = null
		@nextBeatTime = 0

		@signals = null

		@pattern = [8,8,9,10,11,8,9,10,8,8,9,9,10,11,8,9]

		@output.connect @context.destination

		@bank = null

		@queue = []

	play: =>
		@isPlaying = true
		@currentBeat = 0
		@nextBeatTime = @context.currentTime
		null

	stop: =>
		@isPlaying = false
		null

	update: =>
		if @isPlaying
			@scheduleBeats()
			# curTime = @context.currentTime

		null

	scheduleBeats: =>
		while @nextBeatTime < @context.currentTime + @scheduleAheadTime
			#play a tone
			# osc = @context.createOscillator()
			# osc.connect @output
			# if @currentBeat%16 is 0
			# 	osc.frequency.value = 330
			# else if @currentBeat%4 is 0
			# 	osc.frequency.value = 220
			# else
			# 	osc.frequency.value = 0
			# osc.start @nextBeatTime
			# osc.stop @nextBeatTime + 0.1
			# increment the beat count
			if @signals != null then @signals.dispatch @currentBeat, @nextBeatTime
			secsPerBeat = 60 / @tempo
			@nextBeatTime += secsPerBeat * 0.25
			@currentBeat++
			if @currentBeat == 16 then @currentBeat = 0

		null

