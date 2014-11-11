CDXRecordCollection = require "./lib/CDXRecordCollection"

spawnFunc = ->
	return new CDXRecordCollection();

spawnFunc.CDXRecordCollection = CDXRecordCollection
spawnFunc.CDXRecord = require "./lib/CDXRecord"

module.exports = spawnFunc
