_ = require "lodash"
CDXRecord = require "./CDXRecord"
stream = require "stream"

module.exports = class CDXRecordCollection extends stream.Transform
	constructor: (@signature = []) ->
		super
		@_writableState.objectMode = false
		@_readableState.objectMode = true
		@_headerFound = false
		@_buffer = ""

		@reverseSignatureMap = _.invert @signatureMap

	records: []
	signature: null
	delimiter: null
	signatureMap:
		compressedRecordSize: "S"
		compressedDATFileOffset: "D"
		compressedARCFileOffset: "V"
		uncompressedDATFileOffset: "d"
		uncompressedARCFileOffset: "v"
		ARCDocumentLength: "n"
		oldStyleChecksum: "c"
		newStyleChecksum: "k"
		canonicalizedUrl: "A"
		canonicalizedFrame: "F"
		canonicalizedHost: "H"
		canonicalizedImage: "I"
		canonicalizedJumpPoint: "J"
		canonicalizedLink: "L"
		canonicalizedPath: "P"
		canonicalizedRedirect: "R"
		canonicalizedHrefURL: "X"
		canonicalizedSrcURL: "Y"
		canonicalizedScriptURL: "Z"
		originalMimeType: "m"
		originalURL: "a"
		originalFrame: "f"
		originalHost: "h"
		originalImage: "i"
		originalJumpPoint: "j"
		originalLink: "l"
		originalPath: "p"
		originalRedirect: "r"
		originalHrefURL: "x"
		originalSrcURL: "y"
		originalScriptURL: "z"
		date: "b"
		IP: "e"
		fileName: "g"
		port: "o"
		responseCode: "s"
		title: "t"
		metaTags: "M"
		massagedURL: "N"
		languageString: "Q"
		uniqueness: "U"
		newsGroup: "B"
		rulespaceCategory: "C"
		multiColumnLanguageDescription: "G"
		someWeirdFBISWhatsChangedKindaThing: "K" # Yeah well, what did you expect me to do with that? :|
		comment: "#"

	_parseSignature: (signatureData) ->
		@delimiter = signatureData[...1]
		signatureMarkers = signatureData[5...].split(" ")
		@signature = (@reverseSignatureMap[marker] for marker in signatureMarkers)

	_transform: (chunk, encoding, done) ->
		@_buffer += chunk
		lines = @_buffer.split(/\r?\n/)
		@_buffer = lines.pop()

		for line in lines
			if not @_headerFound
				# The first line is the header.
				@_parseSignature line
				@_headerFound = true
			else
				try
					record = @createRecord(line)
					this.push record
				catch err
					this.emit "error", err
					return

		done()

	createRecord: (data) ->
		record = new CDXRecord(@delimiter, @signature)
		record.parseRecord data
		@records.push record
		return record
