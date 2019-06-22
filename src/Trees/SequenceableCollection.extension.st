Extension { #name : #SequenceableCollection }

{ #category : #'*Trees' }
SequenceableCollection >> ,, aSequenceableCollection [ 
	"Answer a copy of the receiver concatenated with the argument, 
	a SequencableCollection. 
	ToDo 07/06/2007: Profile this message against single comma"

	"'' ,, ''"
	"'hello' ,, ''"
	"'' ,, ' world'"
	"'hello' ,, ' world'"

	| newColl mySize otherSize |
	newColl := self species filledNewLW: (mySize := self size) + (otherSize := aSequenceableCollection size).
	self
		replaceFrom: 1
		to: mySize
		with: newColl
		startingAt: 1.
	aSequenceableCollection
		replaceFrom: mySize + 1
		to: mySize + otherSize
		with: newColl
		startingAt: 1.
	^newColl
]

{ #category : #'*Trees' }
SequenceableCollection class >> filledNewLW: size [ 
	"Return a new instance of the specified size filled with default elements. The 
	new: method does the same except for OrderedCollection and its 
	subclasses, for which it returns an empty collection."

	^self new: size
]

{ #category : #'*Trees' }
SequenceableCollection >> replaceAnyIn: sourceElementCollection withLW: destElement [ 
	"Replace all occurrences of any element in sourceElementCollection with 
	destElement within the receiver."

	"   '\usr:dict/words' replaceAnyIn: '\:/' withLW: $\   "

	1 to: self size do: [:i | (sourceElementCollection includes: (self at: i))
			ifTrue: [self at: i put: destElement]]
]
