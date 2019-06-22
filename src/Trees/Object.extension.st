Extension { #name : #Object }

{ #category : #'*Trees' }
Object >> isTreeLW [
	"Return a boolean indicating whether the receiver is a tree."

	^false
]

{ #category : #'*Trees' }
Object >> printSimplyOnLW: aStream [ 
	"Print a simple representation of the receiver on aStream. This 
	method provides default behavior and is overridden by classes such 
	as String and Character whose printOn: methods append extra 
	characters such as quote or dollar sign."

	^self printOn: aStream
]

{ #category : #'*Trees' }
Object >> simplePrintStringLW [
	"Return a simplified print string of the receiver."

	| aStream |
	aStream := (String new: 16) writeStream.
	self printSimplyOnLW: aStream.
	^aStream contents
]
