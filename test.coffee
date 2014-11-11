cdx = require "./"
fs = require "fs"
adhocStream = require "adhoc-stream"
JSONStream = require "JSONStream"

fs.createReadStream "./sample.cdx"
	.pipe cdx()
	.pipe adhocStream.transformSync objectMode: true, (chunk) ->
		@push chunk.data
	.pipe JSONStream.stringify(false)
	.pipe process.stdout
