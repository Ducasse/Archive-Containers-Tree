Extension { #name : #WriteStream }

{ #category : #'*Trees' }
WriteStream >> last [
	"Return the final element in the receiver"

	^ collection at: position
]
