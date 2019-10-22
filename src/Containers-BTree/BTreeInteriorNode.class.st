Class {
	#name : #BTreeInteriorNode,
	#superclass : #BTreeNode,
	#type : #variable,
	#category : #'Containers-BTree'
}

{ #category : #query }
BTreeInteriorNode >> childForKey: aMagnitude [
	| index |
	index := keys findIndexForKey: aMagnitude.
	index = 0 ifTrue:
		[keys at: 1 put: aMagnitude.
		^ self at: 1].
	^ self at: index
		

]

{ #category : #enumerating }
BTreeInteriorNode >> childrenDo: aBlock [
	self valuesDo: aBlock
]

{ #category : #enumerating }
BTreeInteriorNode >> commonKeysWith: aNode keysAndValuesDo: aBlock flip: aBoolean [
	| index |
	aNode firstKey < self firstKey ifTrue: [^ aNode commonKeysWith: self keysAndValuesDo: aBlock flip: aBoolean not].
	index := (keys findIndexForKey: aNode firstKey) max: 1.
	index to: self size do:
		[:i |
		(self at: i) ifNotNilDo: [:c | c commonKeysWith: aNode keysAndValuesDo: aBlock flip: aBoolean]]
]

{ #category : #accessing }
BTreeInteriorNode >> depth [
	^ 1 + self firstChild depth
]

{ #category : #query }
BTreeInteriorNode >> existingChildForKey: aMagnitude [
       "Unlike #childForKey:, this method looks for a child, but doesn't mess with the tree if it doesn't exist."
       | index |
       index := keys findIndexForKey: aMagnitude.
       index = 0
               ifTrue: [^ nil]
               ifFalse: [^ self at: index].
]

{ #category : #query }
BTreeInteriorNode >> existingLeafForKey: aMagnitude [
       "Unlike #leafForKey:, this method looks for a leaf but doesn't mess with the tree if it doesn't exist."
       | child |
       child := self existingChildForKey: aMagnitude.
       ^ child ifNotNil: [child existingLeafForKey: aMagnitude]
]

{ #category : #accessing }
BTreeInteriorNode >> first [
	self childrenDo: [ :node | ^ node first ].
	self error: 'this tree is empty'
]

{ #category : #accessing }
BTreeInteriorNode >> firstChild [
	self childrenDo: [:ea | ^ ea].
	self error: 'No children'.
]

{ #category : #private }
BTreeInteriorNode >> insertKey: aMagnitude value: anObject at: index [
	super insertKey: aMagnitude value: anObject at: index.
	anObject parent: self
]

{ #category : #testing }
BTreeInteriorNode >> isLeaf [
	^ false
]

{ #category : #accessing }
BTreeInteriorNode >> last [
	| child |
	child := nil.
	self childrenDo: [ :node | child := node ].
	child isNil ifTrue: [ self error: 'this tree is empty' ].
	^ child last
]

{ #category : #query }
BTreeInteriorNode >> leafForKey: aMagnitude [
	^ (self childForKey: aMagnitude) leafForKey: aMagnitude
]

{ #category : #enumerating }
BTreeInteriorNode >> leavesFrom: start to: end do: aBlock [
	| startIndex endIndex |
	startIndex := start ifNil: [1] ifNotNil: [(keys findIndexForKey: start) max: 1].
	endIndex := end ifNil: [keys lastIndex] ifNotNil: [keys findIndexForKey: end].
	startIndex to: endIndex do: [:i | (self at: i) leavesFrom: start to: end do: aBlock]
]

{ #category : #query }
BTreeInteriorNode >> nextSiblingForChild: aNode [
	| index |
	index := keys findIndexForKey: aNode firstKey.
	^ (index = self size or: [(keys at: index+1) isNil]) 
		ifTrue: [index = 1 ifFalse: [self at: index - 1] ifTrue: [nil]]
		ifFalse: [self at: index + 1]
]

{ #category : #'as yet unclassified' }
BTreeInteriorNode >> updateKey: oldMagnitude to: newMagnitude [
       keys withIndexDo:
               [:key :i |
               key = oldMagnitude ifTrue:
                       [(i = 1 and: [parent notNil]) ifTrue:
                               [parent updateKey: oldMagnitude to: newMagnitude].
                       ^ keys at: i put: newMagnitude]].
       self error: 'No such key'
]
