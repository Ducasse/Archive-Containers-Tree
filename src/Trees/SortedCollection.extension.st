Extension { #name : #SortedCollection }

{ #category : #'*Trees' }
SortedCollection >> collectLW: aBlock [ 
	"Same as collect:, except returns SortedCollection rather than OrderedCollection 
	and preserves sort block. It is faster to add all the elements at once rather 
	than one at a time."

	| newCollection |
	newCollection := self species new: self size.	"Cannot use copyEmpty:, because that incorrectly uses class rather than species."
	newCollection sortBlock: sortBlock.
	newCollection addAll: (super collect: aBlock).
	^newCollection
]

{ #category : #'*Trees' }
SortedCollection >> reOrderLW [
	"Restore the elements of the receiver to their canonical order and return the 
	receiver."

	self reSort
]

{ #category : #'*Trees' }
SortedCollection >> safeAddLastLW: newObject [ 
	"This is a private method intended only for use by select:."

	^super addLast: newObject
]

{ #category : #'*Trees' }
SortedCollection >> select: aBlock [ 
	"Same as superclass but optimized under the assumption that since the 
	receiver and the resulting sorted collection use the same sort block, 
	elements that pass the selection can be added to the resulting collection 
	without sorting them. We will ignore pathological sort blocks such as 
	
	[:x :y | x <= y & self size odd & Time totalSeconds even] 
	
	which violate this assumption, since they appear to be useless.  The
	assumption is valid for sort blocks that depend only on x and y.

	Cannot name this selectLW: because we want client methods (senders)
	to just send select: regardless of the collection class of the receiver."

	| newCollection |
	newCollection := self species new: self size.	"Cannot use copyEmpty:, because that incorrectly uses class rather than species."
	newCollection sortBlock: sortBlock.
	self do: [:each | (aBlock value: each) ifTrue: [newCollection safeAddLastLW: each]].
	^newCollection
]
