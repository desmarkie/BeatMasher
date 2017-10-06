module.exports = (grunt) ->

	grunt.initConfig

		percolator:
			main:
				source: 'src/coffee'
				output: 'build/js/app.js'
				main: 'App.coffee'
				compile: false
				opts: '--bare'

	grunt.loadNpmTasks 'grunt-coffee-percolator-v2'

	grunt.registerTask 'percolate', =>
		grunt.task.run ['percolator:main']