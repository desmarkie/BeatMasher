var dest = 'build';
var src = 'src';

module.exports = {
	html: {
		src: src + '/html/**',
		dest: dest
	},
	scripts: {
		coffee: {
			src: src + '/coffee/**/*.coffee',
			dest: dest + '/js',
			outputName: 'app.js',
			opts: {
				bare: true
			}
		}
	},
	images: {
		src: src + '/assets/img/**/*',
		dest: dest + '/img'
	},
	connect: {
		root: dest,
		livereload: true,
		port: 9000,
		host: ''
	}
}