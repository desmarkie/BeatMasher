class KeyboardListener

	constructor: ->

		@signals = null
		@shiftPressed = false

	enable: =>
		window.onkeydown = @handleKeyDown
		window.onkeyup = @handleKeyUp
		null

	handleKeyUp: (e) =>
		@shiftPressed = e.shiftKey
		null

	handleKeyDown: (e) =>
		@shiftPressed = e.shiftKey

		sliceKey = ''
		if e.keyCode == 49 then sliceKey = '0'
		else if e.keyCode == 50 then sliceKey = '1'
		else if e.keyCode == 51 then sliceKey = '2'
		else if e.keyCode == 52 then sliceKey = '3'
		else if e.keyCode == 81 then sliceKey = '4'
		else if e.keyCode == 87 then sliceKey = '5'
		else if e.keyCode == 69 then sliceKey = '6'
		else if e.keyCode == 82 then sliceKey = '7'
		else if e.keyCode == 65 then sliceKey = '8'
		else if e.keyCode == 83 then sliceKey = '9'
		else if e.keyCode == 68 then sliceKey = '10'
		else if e.keyCode == 70 then sliceKey = '11'
		else if e.keyCode == 90 then sliceKey = '12'
		else if e.keyCode == 88 then sliceKey = '13'
		else if e.keyCode == 67 then sliceKey = '14'
		else if e.keyCode == 86 then sliceKey = '15'

		if @signals != null and sliceKey != ''
			@signals.dispatch sliceKey
		null