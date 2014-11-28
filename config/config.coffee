module.exports.bootstrap = {}

module.exports.http = {}


module.exports.log =
	level: 'info'

module.exports.session =
	secret: '1a14fdc414026f29dc5b9d4ecd8c00af',
	cookie:
		maxAge: 24 * 60 * 60 * 1000

module.exports.views =
	engine: 'swig'

module.exports.views = {}