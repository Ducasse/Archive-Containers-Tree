Class {
	#name : #CTNaryTree,
	#superclass : #CTAbstractTreeNode,
	#instVars : [
		'parent',
		'children',
		'data'
	],
	#category : #'Containers-NewTrees'
}

{ #category : #examples }
CTNaryTree class >> ABCtree [
	<sampleInstance>
	| aTree |
	aTree := CTNaryTree with: 'A'.
	aTree addNode: (CTNaryTree with: 'B').
	aTree addNode: (CTNaryTree with: 'C').
	aTree addNode: (CTNaryTree with: 'D').
	(aTree children at: 2) addNode: (CTNaryTree with: 'E').
	(aTree children at: 2) addNode: (CTNaryTree with: 'F').
	(aTree children at: 3) addNode: (CTNaryTree with: 'G').
	^ aTree
]

{ #category : #'instance creation' }
CTNaryTree class >> with: anObject [
	"Return a new tree whose data is anObject and no children. 
	(a Tree is composed of an object and a set of children)."
	^ self new 
		data: anObject
]

{ #category : #'adding/removing' }
CTNaryTree >> addNode: aCTNaryTree [
	"Add a node in the receiver and return the added node. Set the parent of the added node to be the receiver."
	aCTNaryTree parent: self.
	^ children add: aCTNaryTree
	
]

{ #category : #accesing }
CTNaryTree >> children [
	"Returns the children of a node. Return an empty collection when no children."
	^ children
]

{ #category : #accesing }
CTNaryTree >> children: aCollection [
	"Set aCollection as a collection of children of the receiver."
	children := aCollection
]

{ #category : #accesing }
CTNaryTree >> data [
	^ data
]

{ #category : #accesing }
CTNaryTree >> data: anObject [ 
	data := anObject
]

{ #category : #operations }
CTNaryTree >> depth [
	
	| maxDepth |
	
	self isLeaf
		ifTrue: [ ^ 0 ].
	
	maxDepth := 0.
	
	1 to: (self children size) do: 
		[ :i | maxDepth := maxDepth  max: (children at: i) depth ].
	^ maxDepth + 1.
]

{ #category : #traversing }
CTNaryTree >> findBreadthFirst: aBlock [
	"Answer a node that matches condition from passed block. The lookup is done in level order manner"
	
	| queue found |	
	queue := OrderedCollection new.
	found := false.
	
	queue addLast: self.
	
	[ queue isNotEmpty ] whileTrue: [ 
		| node |
		node := queue removeFirst.
			
		(aBlock value: node )
			ifTrue: [ found := true. ^ node ].
		
		1 to: (node children size) do: 
			[ :i | queue addLast: (node children at: i) ]
	].
	found ifFalse: [ ^ nil ].
	

]

{ #category : #traversing }
CTNaryTree >> findDeepFirst: aBlock [
	"Answer a node that matches condition specified in a block. The lookup is done in depth first search manner."
	
	| stack found |	
	stack := OrderedCollection new.
	found := false.
	
	stack addFirst: self.
	
	[ stack isNotEmpty ] whileTrue: [ 
		| node |
		node := stack removeFirst.
			
		(aBlock value: node )
			ifTrue: [ found := true. ^ node ].
		
		1 to: (node children size) do: 
			[ :i | stack addFirst: (node children at: i) ]
	].
	found ifFalse: [ ^ nil ].

]

{ #category : #operations }
CTNaryTree >> findLeafNode: aCTTreeNode [

	self isLeaf 
		ifTrue: [ ^ self ].
	^ aCTTreeNode findLeafNode: (self children at: 1).
]

{ #category : #testing }
CTNaryTree >> hasChildren [
	^ children isEmpty not
]

{ #category : #traversing }
CTNaryTree >> inOrderDo: aBlock [
	"In-order traversing  executing a block on each node.For traversing in-order, since there are more than two children per node for m > 2, a notion of left and right subtrees is introduced. One common method to establish left/right subtrees is to divide the list of children nodes into two groups"

	| numberOfChildren leftChildren rightChildren |
	numberOfChildren := children size.
	leftChildren := 0.
	rightChildren := 0.
	
	numberOfChildren < 2
		ifTrue: [ leftChildren := numberOfChildren ].
		
	leftChildren := (numberOfChildren \\ 2 == 0)
		ifTrue: [ numberOfChildren / 2 ]
		ifFalse: [ numberOfChildren // 2 + 1 ].
		
	rightChildren := numberOfChildren - leftChildren.
	
	1 to: leftChildren do: [ :i | (children at: i) inOrderDo: aBlock ].
	aBlock value: self.
	1 to: rightChildren do: [ :i | (children at: (leftChildren + i)) inOrderDo: aBlock ].
]

{ #category : #initialize }
CTNaryTree >> initialize [
	super initialize.
	children := OrderedCollection new.
]

{ #category : #testing }
CTNaryTree >> isLeaf [
	^ children isEmpty
]

{ #category : #accesing }
CTNaryTree >> parent [
	^ parent
]

{ #category : #accesing }
CTNaryTree >> parent: aCTNaryTree [
	parent := aCTNaryTree 
]

{ #category : #traversing }
CTNaryTree >> postOrderDo: aBlock [
	"Post-order traversing  executing a block on each node"
	
	1 to: (children size) do: [ :i | (children at: i) postOrderDo: aBlock ].
	aBlock value: self.


	

]

{ #category : #traversing }
CTNaryTree >> preOrderDo: aBlock [
	"Pre-order traversing  executing a block on each node"
	
	aBlock value: self.
	1 to: (children size) do: [ :i | (children at: i) preOrderDo: aBlock ].

	

]

{ #category : #'adding/removing' }
CTNaryTree >> remove: aCTNaryTree [
	"should we return NullNode if we are deleting root? "

	| leafNode |
	self sizeOfTree == 1
		ifTrue: [ ^ self data: nil ].
	
	aCTNaryTree isLeaf
		ifTrue: [ aCTNaryTree parent children remove: aCTNaryTree.
					 aCTNaryTree parent: nil.
					^ aCTNaryTree ].
				
	aCTNaryTree hasChildren
		ifFalse: [ ^ self ].
		
	leafNode := self findLeafNode: self.
	aCTNaryTree data: leafNode data.

	^ self remove: leafNode
]

{ #category : #operations }
CTNaryTree >> sizeOfTree [
	
	| queue sum |	
	queue := OrderedCollection new.
	sum := 0.
	
	queue addLast: self.
	
	[ queue isNotEmpty ] whileTrue: [ 
		| node |
		sum := sum + 1.
		node := queue removeFirst.

		1 to: (node children size) do: 
			[ :i | queue addLast: (node children at: i) ]
	].
	^ sum
]
