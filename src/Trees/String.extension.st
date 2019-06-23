Extension { #name : #String }

{ #category : #'*Trees' }
String >> crLW [
	"Answer a string containing a carriage return."

	^self with: Character cr
]

{ #category : #'*Trees' }
String class >> crLW [
	"Answer a string containing a carriage return."

	^self with: Character cr
]

{ #category : #'*Trees' }
String >> crsToSpacesLW [
	"Answer a new string that substitutes spaces for CRs."

	| cr space |
	cr := Character cr.
	space := Character space.
	^self collect: [:char | char = cr ifTrue: [space] ifFalse: [char]]
]

{ #category : #'*Trees' }
String >> prependWith: aChar maxLW: n [ 
	"Return a copy of the receiver with enough characters prepended to it to bring its 
	length up to n."

	"   '15' prependWith: $0 maxLW: 1"
	"   '15' prependWith: $0 maxLW: 2"
	"   '15' prependWith: $0 maxLW: 3"

	| nChars |
	nChars := n - self size max: 0.
	^(self species new: nChars withAll: aChar) ,, self
]

{ #category : #'*Trees' }
String >> printSimplyOnLW: aStream [ 
	"Append my characters to aStream without performing any special 
	handling for embedded quotes. Also, do not place quotes before or 
	after the string."

	aStream nextPutAll: self
]

{ #category : #'*Trees' }
String >> simplePrintStringLW [
	"Answer a copy of the receiver. Overrides superclass implementation for 
	performance."

	^self copy
]
