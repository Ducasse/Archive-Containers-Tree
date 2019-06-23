Extension { #name : #OrderedCollection }

{ #category : #'*Trees' }
OrderedCollection >> filledNewLW: anInteger [ 
	"Return a new instance filled with anInteger nil elements. This is distinct from 
	new:, which returns an empty collection."

	^(super new: anInteger) setFilledIndicesLW
]

{ #category : #'*Trees' }
OrderedCollection >> isOrderedLW [
	"Is the receiver an OrderedCollection or one of its subclasses?"

	^true
]

{ #category : #'*Trees' }
OrderedCollection >> setFilledIndicesLW [
	"This is a private method supporting the class method filledNewLW:."

	firstIndex := 1.
	lastIndex := self basicSize
]
