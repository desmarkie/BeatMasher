# import Model
# import View
# import Controller
class App

	constructor: ->

		@mousePos = 
			x: 0
			y: 0

		@model = new Model()

		#model needed yet?
		@view = new View @model

		@controller = new Controller @view, @model

		# @test = new PIXI.Graphics()
		# @test.beginFill 0xFF0000
		# @test.drawRect -5, -5, 10, 10
		# @test.endFill()

		# @view.stage.addChild @test

		# @controller.signals.tick.add @update

	# update: =>
	# 	# console.log 'App.UPDATE'
	# 	@test.position.x = @model.mousePos.x
	# 	@test.position.y = @model.mousePos.y
	# 	null

	