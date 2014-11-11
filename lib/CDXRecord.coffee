moment = require "moment"

module.exports = class CDXRecord
	data: {} # For JSON output purposes etc.

	constructor: (@delimiter, @signature) ->

	getData: ->
		return @data

	generateRecord: ->

	parseRecord: (data) ->
		if not data?
			return

		fields = data.split(@delimiter)

		for i, fieldName of @signature
			if fields[i]? and fields[i] != "-"
				switch fieldName
					when "date"
						value = moment fields[i], "YYYYMMDDHHmmss"
					when "compressedDATFileOffset", "compressedARCFileOffset", "uncompressedDATFileOffset", "uncompressedARCFileOffset", "responseCode", "ARCDocumentLength", "port", "compressedRecordSize"
						value = parseInt(fields[i])
					else
						value = fields[i]

				this[fieldName] = value
				@data[fieldName] = value
