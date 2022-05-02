"
I'm a simple binary tree. I have one value held by `object`, two children `leftChild` and `rightChild`, and a reference to my parent. 

To be probably fully rewritten.
	addNode: is strange
	sizeOfTree too.
	

"
Class {
	#name : #CTBasicBinaryTree,
	#superclass : #Object,
	#instVars : [
		'object',
		'parent',
		'leftChild',
		'rightChild'
	],
	#category : #'Containers-BinarySearchTree'
}

{ #category : #examples }
CTBasicBinaryTree class >> binaryTree [
	<sampleInstance>
	
	| aTree |
	aTree := self with: 1.
	aTree leftChild: (self with: 2).
	aTree rightChild: (self with: 3).
	aTree leftChild leftChild: (self with: 4).
	aTree leftChild rightChild: (self with: 5).
	^ aTree
]

{ #category : #examples }
CTBasicBinaryTree class >> binaryTreeEmpty [
	<sampleInstance>
 	^ self new
]

{ #category : #'instance creation' }
CTBasicBinaryTree class >> with: anObject [
	"Return a new tree with one node whose object is anObject and which does not have any children"

	^ self new 
		object: anObject
]

{ #category : #'adding/removing' }
CTBasicBinaryTree >> addNode: aNode [
	"Answer added node"

	| aParent addedNode |
	aParent := self
		findNodeBreadthFirst: [ :x | x hasLeftChild not or: x hasRightChild not ]
		startingFromANode: self.
	aParent hasLeftChild
		ifFalse: [ aParent leftChild: aNode.
			addedNode := aParent leftChild ].
	aParent hasRightChild not & addedNode isNil
		ifTrue: [ aParent rightChild: aNode.
			addedNode := aParent rightChild ].
	^ addedNode
]

{ #category : #'adding/removing' }
CTBasicBinaryTree >> addNodeWithObject: anObject [
	"Answer added node with object initialized with anObject value"

	| aParent addedNode |
	aParent := self
		findNodeBreadthFirst: [ :x | x hasLeftChild not or: x hasRightChild not ]
		startingFromANode: self.
	aParent hasLeftChild
		ifFalse: [ aParent leftChild: (self class with: anObject).
			addedNode := aParent leftChild ].
	aParent hasRightChild not & addedNode isNil
		ifTrue: [ aParent rightChild: (self class with: anObject).
			addedNode := aParent rightChild ].
	^ addedNode
]

{ #category : #traversing }
CTBasicBinaryTree >> at: aNode inOrderDo: aBlock [
	"Start traversing in-order starting from aNode and executing a block on each node"

	aNode isNotNil
		ifFalse: [ ^ self ].
		
	self at: aNode leftChild inOrderDo: aBlock.
	aBlock value: aNode.
	self at: aNode rightChild inOrderDo: aBlock
	
	
]

{ #category : #traversing }
CTBasicBinaryTree >> at: aNode postOrderDo: aBlock [
	"Start traversing post-order starting from aNode and executing a block on each node"

	aNode isNotNil
		ifFalse: [ ^ self ].
		
	self at: aNode leftChild postOrderDo: aBlock.
	self at: aNode rightChild postOrderDo: aBlock.
	aBlock value: aNode.
	
]

{ #category : #traversing }
CTBasicBinaryTree >> at: aNode preOrderDo: aBlock [
	"Start traversing pre-order starting from aNode and executing a block on each node"

	aNode isNotNil
		ifFalse: [ ^ self ].
	aBlock value: aNode.
	self at: aNode leftChild preOrderDo: aBlock.
	self at: aNode rightChild preOrderDo: aBlock
	
]

{ #category : #operations }
CTBasicBinaryTree >> depth [
	"Answer depth of a tree"
	
	| leftDepth rightDepth |
	leftDepth := 0.
	rightDepth := 0.
	
	self isLeaf 
		ifTrue: [ ^ 0 ].
	
	self hasLeftChild 
	ifTrue: 
		[ leftDepth := leftChild depth + 1 ].	
	
	self hasRightChild 
	ifTrue: 
		[ 	rightDepth := rightChild depth + 1 ].

    ^ leftDepth max: rightDepth

	
]

{ #category : #traversing }
CTBasicBinaryTree >> findBreadthFirst: anObject startingFromANode: aNode [
	"Answer a node with object that is equal to anObject. The lookup is done in level order manner starting from a passed node"
	
	| queue foundNode |	
	queue := OrderedCollection new.
	
	aNode isNotNil
	 ifTrue: [ queue addLast: aNode ].
	
	[ queue isNotEmpty ] whileTrue: [ 
		| node |
		node := queue removeFirst.
		
		node object == anObject
			ifTrue: [ foundNode := node ].
			
		node hasLeftChild & foundNode isNil
			ifTrue: [ queue addLast: node leftChild ].
			
		node hasRightChild & foundNode isNil
			ifTrue: [ queue addLast: node rightChild ].
	  	 ].
	^ foundNode 
]

{ #category : #traversing }
CTBasicBinaryTree >> findDeepFirst: anObject startingFromANode: aNode [
		"Answer a node with object that is equal to anObject. The lookup is done in depth first search manner."
		
	| node |	
	aNode object == anObject
		ifTrue: [ node := aNode ].
	
	aNode hasLeftChild  & node isNil
		ifTrue: [node := self findDeepFirst: anObject startingFromANode: aNode leftChild].
		
	aNode hasRightChild & node isNil
		ifTrue: [node := self findDeepFirst: anObject startingFromANode: aNode rightChild].
	
	^ node
	
	
]

{ #category : #traversing }
CTBasicBinaryTree >> findNodeBreadthFirst: aBlock startingFromANode: aNode [
	"Answer a node that is specified in a block. Lookup is done in level order manner"
	
	| queue foundNode |	
	queue := OrderedCollection new.
	
	aNode isNotNil
	 ifTrue: [ queue addLast: aNode ].
	
	[ queue isNotEmpty ] whileTrue: [ 
		| node |
		node := queue removeFirst.
		
		(aBlock value: node )
			ifTrue: [ ^ foundNode := node ].
			
		node hasLeftChild & foundNode isNil
			ifTrue: [ queue addLast: node leftChild ].
			
		node hasRightChild & foundNode isNil
			ifTrue: [ queue addLast: node rightChild ].
	  	 ].
	^ foundNode 
]

{ #category : #testing }
CTBasicBinaryTree >> hasLeftChild [

	^ leftChild isNotNil
]

{ #category : #testing }
CTBasicBinaryTree >> hasObject [
	^ object isNotNil
]

{ #category : #testing }
CTBasicBinaryTree >> hasParent [
	
	^ parent isNotNil 
]

{ #category : #testing }
CTBasicBinaryTree >> hasRightChild [

	^ rightChild isNotNil
]

{ #category : #testing }
CTBasicBinaryTree >> isLeaf [

	^ self hasLeftChild not & self hasRightChild not
]

{ #category : #accessing }
CTBasicBinaryTree >> leftChild [
	^ leftChild
]

{ #category : #accessing }
CTBasicBinaryTree >> leftChild: aTree [
	leftChild := aTree
]

{ #category : #accessing }
CTBasicBinaryTree >> object [
	^ object
]

{ #category : #accessing }
CTBasicBinaryTree >> object: anObject [
	object := anObject
]

{ #category : #accessing }
CTBasicBinaryTree >> parent [
	^ parent
]

{ #category : #accessing }
CTBasicBinaryTree >> parent: aParent [
	parent := aParent
]

{ #category : #'adding/removing' }
CTBasicBinaryTree >> removeNodeObject: aNode ifAbsent: aBlock [
	"Answer true if object field of a node was successfull deleted and false otherwise"
	
	| nodeToBeDeleted isDeleted |
	nodeToBeDeleted := self findNodeBreadthFirst: [ :node | node == aNode ] startingFromANode: self.
	nodeToBeDeleted isNil 
		ifTrue: [ aBlock. 
					isDeleted := false ]
		ifFalse: [ nodeToBeDeleted object: nil.
					  isDeleted := true ].
	^ isDeleted
	

]

{ #category : #'adding/removing' }
CTBasicBinaryTree >> removeNodeWithObject: anObject ifAbsent: aBlock [
	"Answer boolean that indicates if removal was sucessful.
	 Removed node is replaced by bottom most and rightmost node so that tree shrinks from the bottom"

	| node deepestRightNode nodeToBeDeleted queue temporaryObject |
	queue := OrderedCollection new.
	queue addLast: self.
	
	[ queue isNotEmpty ]
		whileTrue: [ node := queue removeFirst.
			node object == anObject
				ifTrue: [ nodeToBeDeleted := node ].
			node hasLeftChild
				ifTrue: [ queue addLast: node leftChild ].
			node hasRightChild
				ifTrue: [ queue addLast: node rightChild ] ].
			
	deepestRightNode := node.
	nodeToBeDeleted isNotNil
		ifTrue: aBlock
		ifFalse: [ ^ self ].
		
	temporaryObject := deepestRightNode object.
	nodeToBeDeleted object: temporaryObject.
	^ self removeNodeObject: deepestRightNode ifAbsent: [ false ]
]

{ #category : #accessing }
CTBasicBinaryTree >> rightChild [
	^ rightChild
]

{ #category : #accessing }
CTBasicBinaryTree >> rightChild: aTree [
	rightChild := aTree
]

{ #category : #operations }
CTBasicBinaryTree >> size [
	"Answer number of nodes in a tree"
	
	| leftSize rightSize |
	leftSize := 0.
	rightSize := 0.
	
	self isLeaf
		ifTrue: [ ^ 1 ].
		
	self hasLeftChild 
		ifTrue: [ leftSize := leftChild size ].
	
	self hasRightChild
		ifTrue: [ rightSize := rightChild size ].
			
	^ 1 + leftSize + rightSize
]
