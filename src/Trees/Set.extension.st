Extension { #name : #Set }

{ #category : #'*Trees' }
Set >> elementMatching: anObject ifAbsentLW: aBlock [ 
	"Return the element in the receiver matching anObject, or the result of 
	evaluating aBlock if none is found. An element is said to match an object
	if the following conditions are satisfied: 
	
	anElement = anObject 
	anElement hash = anObject hash 
	
	This method uses hashing to speed up the superclass implementation."

	| index |
	index := self find: anObject ifAbsent: [^aBlock value].
	^self basicAt: index
]

{ #category : #'*Trees' }
Set >> find: anObject ifAbsent: aBlock [

	| index |
	index := self findElementOrNil: anObject.
	(self basicAt: index) == nil
		ifTrue: [^aBlock value]
		ifFalse: [^index]
]

{ #category : #'*Trees' }
Set >> reOrderLW [
	"Restore the elements of the receiver to their canonical order and return the 
	receiver."

	self rehash
]
