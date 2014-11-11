# cdx

A simple streaming CDX file parser. Parses CDX files (in particular, those corresponding to WARC files) that correspond to the format as specified by the [Internet Archive](https://archive.org/web/researcher/cdx_file_format.php). All items in the CDX field legend are supported, plus the `S` field.

## Scope and development status

`cdx` currently only reads (compliant) CDX streams. In the future, it will likely be expanded to also be able to write CDX streams, but this is not currently supported. Error handling is currently nearly non-existent - you are expected to provide a compliant CDX stream.

## Installation

```
npm install --save cdx
```

## Usage

`cdx` is a streaming parser. It takes a CDX byte stream as input (regardless of the source), and outputs an object stream of CDXRecord objects with the named attributes set to the corresponding values from the CDX stream. Additionally, a plain object containing these attributes is available as the `data` attribute, for easy (JSON) serialization.

The signature is automatically parsed from the first line of the CDX data. Specifying a custom signature is not currently supported.

```javascript
var cdx = require("cdx"),
	fs = require("fs");

fs.createReadStream("sample.cdx")
	.pipe(cdx())
	.pipe(...);
```

An example that parses the sample CDX file, 'picks out' the serializable data, and then outputs it to `stdout` as serialized JSON, can be found in `sample.cdx` (you'll need to install devDependencies first to actually run that file, though).

## Fields

All fields are self-explanatory, hopefully. These are just adapted from [the legend provided by the Internet Archive](https://archive.org/web/researcher/cdx_legend.php), so I really have no idea what most of these do.

* `compressedRecordSize` (for `.warc.gz`, this is the gzipped size of the record)
* `compressedDATFileOffset`
* `compressedARCFileOffset` (for `.warc.gz`, this is the gzipped starting position of the record, combine with size to get the ending position)
* `uncompressedDATFileOffset`
* `uncompressedARCFileOffset`
* `ARCDocumentLength`
* `oldStyleChecksum`
* `newStyleChecksum`
* `canonicalizedUrl`
* `canonicalizedFrame`
* `canonicalizedHost`
* `canonicalizedImage`
* `canonicalizedJumpPoint`
* `canonicalizedLink`
* `canonicalizedPath`
* `canonicalizedRedirect`
* `canonicalizedHrefURL`
* `canonicalizedSrcURL`
* `canonicalizedScriptURL`
* `originalMimeType` (for `.warc.gz`, this is the original mimetype of the document as specified by the origin webserver)
* `originalURL` (for `.warc.gz`, this is the original URL that the document was retrieved from)
* `originalFrame`
* `originalHost`
* `originalImage`
* `originalJumpPoint`
* `originalLink`
* `originalPath`
* `originalRedirect`
* `originalHrefURL`
* `originalSrcURL`
* `originalScriptURL`
* `date` (for `.warc.gz`, this is the retrieval date of the record)
* `IP`
* `fileName` (for `.warc.gz`, this is the path to the WARC file that this record lives in - may not be useful, as it may refer to a path on a different filesystem)
* `port`
* `responseCode` (for `.warc.gz`, this is the HTTP status code encountered when retrieving the document)
* `title`
* `metaTags`
* `massagedURL`
* `languageString`
* `uniqueness`
* `newsGroup`
* `rulespaceCategory`
* `multiColumnLanguageDescription`
* `someWeirdFBISWhatsChangedKindaThing` (don't ask...)
* `comment`

## Contributing

Contributions welcome! Please file bugs [on GitHub](http://github.com/joepie91/node-cdx), and target pull requests at the `develop` branch. Thank you!
