fs = require "fs"
CDXRecordCollection = require "./lib/CDXRecordCollection"
JSONStream = require "JSONStream"
stream = require "stream"
adhocStream = require "adhoc-stream"

methods =
	parseFile: (file) ->
		collection = new CDXRecordCollection()

		fs.createReadStream file
			.pipe collection.stream
			.pipe adhocStream.transformSync objectMode: true, (obj) ->
				@push obj.data
			.pipe JSONStream.stringify(false)
			.pipe process.stdout

methods.parseFile "./sample.cdx"
