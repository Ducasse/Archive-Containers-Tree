Extension { #name : #Collection }

{ #category : #'*Trees' }
Collection >> addLW: newObject [
	"Add newObject to the receiver and return newObject. 
	Subclass(es) redefining it explain its usage."

	^self add: newObject
]

{ #category : #'*Trees' }
Collection >> anyIncludedInLW: aCollectionEtc [
	"Answer whether any of my elements is included in aCollectionEtc.
	NOTE: aCollectionEtc can be any object, such as a collection,
	that responds to the message <includes:>."

	self do: [:each | (aCollectionEtc includes: each) ifTrue: [^true]].
	^false
]

{ #category : #'*Trees' }
Collection >> collectLW: aBlock [ 
	"Same as collect:. Redefined by subclasses that need to correct 
	deficiencies in the ParcPlace implementation."

	^self collect: aBlock
]

{ #category : #'*Trees' }
Collection >> detectLW: aBlock [ 
	"Evaluate aBlock with each of the elements of the receiver as the argument.
	Answer the first element for which aBlock evaluates to true.  If none is found,
	answer nil.  Same as detect:, except returns nil rather than an error."

	^self detect: aBlock ifNone: [nil]
]

{ #category : #'*Trees' }
Collection >> elementMatching: anObject ifAbsentLW: aBlock [ 
	"Return the first element in the receiver matching anObject, or the result of 
	evaluating aBlock if none is found. An element is said to match an object if 
	anElement = anObject."

	^self detect: [:anElement | anElement = anObject] ifNone: aBlock
]

{ #category : #'*Trees' }
Collection >> isOrderedLW [
	"Is the receiver an OrderedCollection or one of its subclasses?"

	^false
]

{ #category : #'*Trees' }
Collection >> reOrderLW [
	"Restore the elements of the receiver to their canonical order and return the 
	receiver. This method is redefined by classes that need to rebuild themselves 
	after their elements have been modified. For examples, Sets must rehash and 
	SortedCollections must reSort."
]

{ #category : #'*Trees' }
Collection >> remove: oldObject ifAbsentLW: anExceptionBlock [ 
	"Remove the first instance of oldObject from the receiver and return oldObject. 
	If not found, return the result of evaluating anExceptionBlock. Subclass(es) 
	redefining it explain its usage."

	^self remove: oldObject ifAbsent: anExceptionBlock
]

{ #category : #'*Trees' }
Collection >> removeLW: oldObject [ 
	"Remove the first instance of oldObject from the receiver and return oldObject. 
	If not found, raise an error exception."

	^self remove: oldObject ifAbsentLW: [self errorNotFound: oldObject ]
]
