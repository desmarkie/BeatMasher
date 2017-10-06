class SampleLoader

	@loadSample: ( src, callback ) ->

		# @mode = 'drop'
		# @contextButtons.hit()

		@reader = new FileReader()
		@reader.onload = =>
			callback @reader.result
			# # called when a dropped sound has finished loading
			# id = 'drop'+@controller.dropCount
			# @audioManager.loadSamples 	
			# # console.log 'Dropped Sample Loaded'
			# @dropUrl = @reader.result
			null

		@reader.readAsDataURL src

		null
