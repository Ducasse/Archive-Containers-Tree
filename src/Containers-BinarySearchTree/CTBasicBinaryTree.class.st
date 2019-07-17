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
	| aTree  |
	aTree := CTBasicBinaryTree with: 1.
	aTree leftChild: (CTBasicBinaryTree with: 2).
	aTree rightChild: (CTBasicBinaryTree with: 3).
	aTree leftChild leftChild: (CTBasicBinaryTree with: 4).
	aTree leftChild rightChild: (CTBasicBinaryTree with: 5).
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

{ #category : #operations }
CTBasicBinaryTree >> depth [
	"comment stating purpose of message"
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
	""
	| queue foundNode |
	
	queue := OrderedCollection new.
	aNode isNotNil
	 ifTrue: [ queue addLast: aNode ].
	
	[ queue isNotEmpty ] whileTrue: [ 
		| node |
		node := queue removeFirst.
		node object == anObject 
			ifTrue: [ foundNode := node ].
			
		node leftChild isNotNil 
			ifTrue: [ queue addLast: node leftChild ].
		node rightChild isNotNil
			ifTrue: [ queue addLast: node rightChild ].
	  	 ].
	^ foundNode 
]

{ #category : #traversing }
CTBasicBinaryTree >> findDeepFirst: anObject startingFromANode: aNode [
	"comment stating purpose of message"
	| node |
	
	aNode object == anObject
		ifTrue: [ node := aNode ].
	
	aNode leftChild isNotNil & node isNil
		ifTrue: [node := self findDeepFirst: anObject startingFromANode: aNode leftChild].
		
	aNode rightChild isNotNil & node isNil
		ifTrue: [node := self findDeepFirst: anObject startingFromANode: aNode rightChild].
	
	^ node
	
	
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

{ #category : #initialize }
CTBasicBinaryTree >> initialize [

	super initialize.
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

{ #category : #accessing }
CTBasicBinaryTree >> rightChild [
	^ rightChild
]

{ #category : #accessing }
CTBasicBinaryTree >> rightChild: aTree [
	rightChild := aTree
]

{ #category : #operations }
CTBasicBinaryTree >> sizeOfTree [
	""
	| leftSize rightSize |
	leftSize := 0.
	rightSize := 0.
	
	self isLeaf
		ifTrue: [ ^ 1 ].
		
	self hasLeftChild 
		ifTrue: [ leftSize := leftChild sizeOfTree ].
	
	self hasRightChild
		ifTrue: [ rightSize := rightChild sizeOfTree ].
			

	
	^ 1 + leftSize + rightSize
]
