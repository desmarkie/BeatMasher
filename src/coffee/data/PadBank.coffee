class PadBank

	constructor: ->

		@data = {}
		@data.samples = {}
		buts = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
		for but in buts
			@data.samples[but] = 
				baseSpeed: 1
				sampleId: 'empty'

		cols = ['orange', 'red', 'blue', 'green']
		ct = 0
		for i in [0...16]
			# sequence, temp set to autoslice params so it plays it's one beeat in time
			arr = []
			for j in [0...16]
				arr.push 0
				# arr.push if i is j then 1 else 0

			# if i is 0
			# 	arr[0] = 1
			# if i is 4
			# 	arr[2] = 1
			# if i is 2
			# 	arr[8] = 1
			# if i is 6
			# 	arr[10] = 1
			# if i is 8
			# 	arr = [1,1,0,0,0,1,0,0,1,1,0,0,0,0,1,0]
			# if i is 9
			# 	arr = [0,0,1,0,0,0,1,0,0,0,1,1,0,0,0,1]
			# if i is 10
			# 	arr = [0,0,0,1,0,0,0,1,0,0,0,0,1,0,0,0]
			# if i is 11
			# 	arr = [0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0]
			# if i >= 12
			# 	arr[i] = 1

			props =
				playbackRate: 1
				padRate: 1
				baseRate: 1
				startPos: 0
				length: 1
				sampleId: 'empty'
				color: 'orange'
				buttonId: i.toString()


			# if i < 8
			# 	props =
			# 		playbackRate: 0.65
			# 		startPos: (1/8) * i
			# 		length: 1/8
			# 		sampleId: 'B'
			# 		color: cols[i % 4]
			# else
			# 	props =
			# 		playbackRate: 1.23
			# 		startPos: (1/16) * i
			# 		length: 1/16
			# 		sampleId: 'A'
			# 		color: cols[i % 4]

			ct++
			if ct is 4
				ct = 0
				val = cols[0]
				cols.splice 0, 1
				cols.push val

			@data[i.toString()] = {props:props, pattern:arr, player:null}


	getPadSampleData: ( id ) =>
		return @data[id].props

	setPadSampleData: ( id, props ) =>
		for key of props
			@data[id].props[key] = props[key]
		null

	getPadPatternData: ( id ) =>
		return @data[id].pattern

	getSample: ( buttonId ) =>
		return @data.samples[buttonId]

	setSample: ( buttonId, sampleId ) =>
		@data.samples[buttonId].sampleId = sampleId
		null

	setSampleSpeed: ( buttonId, sampleSpeed ) =>
		@data.samples[buttonId].baseSpeed = sampleSpeed
		null