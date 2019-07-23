Class {
	#name : #CTBasicBinaryTreeTest,
	#superclass : #TestCase,
	#category : #'Containers-BinarySearchTree-Tests'
}

{ #category : #'test adding/removing' }
CTBasicBinaryTreeTest >> testAddNode [
	"comment stating purpose of message"

	| aTree |
	aTree := CTBasicBinaryTree with: 5.
	aTree addNode: (CTBasicBinaryTree with: 6).
	self assert: aTree leftChild object equals: 6.

]

{ #category : #'test adding/removing' }
CTBasicBinaryTreeTest >> testAddNodeWithObject [
	"comment stating purpose of message"

	| aTree |
	aTree := CTBasicBinaryTree with: 5.
	aTree addNodeWithObject: 7.
	self assert: aTree leftChild object equals: 7.
	
]

{ #category : #'test - traversing' }
CTBasicBinaryTreeTest >> testAtInOrderDo [
	"comment stating purpose of message"

	| aTree result testResult|
	aTree := CTBasicBinaryTree binaryTree.
	result:= OrderedCollection new.
	testResult := #(4 2 5 1 3) asOrderedCollection. 
	
	aTree at: aTree inOrderDo: [:node | result add: node object].
	
	1 to: 5 do:
		[:i | self assert: (testResult at:i) equals: (result at:i) ].

	

"	self assert: result size = aTree size."
]

{ #category : #'test - traversing' }
CTBasicBinaryTreeTest >> testAtPostOrderDo [
	"comment stating purpose of message"

	| aTree result testResult|
	aTree := CTBasicBinaryTree binaryTree.
	result:= OrderedCollection new.
	testResult := #(4 5 2 3 1) asOrderedCollection. 
	
	aTree at: aTree postOrderDo: [:node | result add: node object].
	
	1 to: 5 do:
		[:i | self assert: (testResult at:i) equals: (result at:i) ].

	

"	self assert: result size = aTree size."
]

{ #category : #'test - traversing' }
CTBasicBinaryTreeTest >> testAtPreOrderDo [
	"comment stating purpose of message"

	| aTree result testResult|
	aTree := CTBasicBinaryTree binaryTree.
	result:= OrderedCollection new.
	testResult := #(1 2 4 5 3) asOrderedCollection. 
	
	aTree at: aTree preOrderDo: [:node | result add: node object].
	
	1 to: 5 do:
		[:i | self assert: (testResult at:i) equals: (result at:i) ].

	

"	self assert: result size = aTree size."
]

{ #category : #'tests - testing' }
CTBasicBinaryTreeTest >> testCreationHasNoChildren [

	| aTree |
	aTree := CTBasicBinaryTree new.
	self assert: aTree hasLeftChild & aTree hasRightChild equals: false.
]

{ #category : #'tests - testing' }
CTBasicBinaryTreeTest >> testCreationHasNoLeftChild [

	| aTree |
	aTree := CTBasicBinaryTree new.
	self assert: aTree hasLeftChild equals: false.
]

{ #category : #'tests - testing' }
CTBasicBinaryTreeTest >> testCreationHasNoObject [

	| aTree |
	aTree := CTBasicBinaryTree new.
	self assert: aTree hasObject equals: false.
]

{ #category : #'tests - testing' }
CTBasicBinaryTreeTest >> testCreationHasNoParent [

	| aTree |
	aTree := CTBasicBinaryTree new.
	self assert: aTree hasParent equals: false.
]

{ #category : #'tests - testing' }
CTBasicBinaryTreeTest >> testCreationHasNoRightChild [

	| aTree |
	aTree := CTBasicBinaryTree new.
	self assert: aTree hasRightChild equals: false.
]

{ #category : #'test operations' }
CTBasicBinaryTreeTest >> testDepth [
	"comment stating purpose of message"
	
	| aTree |
	aTree := CTBasicBinaryTree  binaryTree. 
	
	self assert: aTree depth equals: 2.
]

{ #category : #'test operations' }
CTBasicBinaryTreeTest >> testDepthOnEmptyTree [
	"comment stating purpose of message"
	
	| aTree |
	aTree := CTBasicBinaryTree  binaryTreeEmpty. 
	
	self assert: aTree depth equals: 0.
]

{ #category : #'test operations' }
CTBasicBinaryTreeTest >> testDepthOnTreeWithOnlyLeftChild [
	"comment stating purpose of message"
	
	| aTree |

	aTree := CTBasicBinaryTree with: 1.
	aTree leftChild: (CTBasicBinaryTree with: 2).
	
	self assert: aTree depth equals: 1.
]

{ #category : #'test - traversing' }
CTBasicBinaryTreeTest >> testFindBreadthFirstOnEmptyTree [
	"comment stating purpose of message"
	
	| aTree node |
	aTree := CTBasicBinaryTree  binaryTreeEmpty. 
	
	node := aTree findBreadthFirst: 2 startingFromANode: aTree.
	self assert: node isNil.
]

{ #category : #'test - traversing' }
CTBasicBinaryTreeTest >> testFindBreadthFirstStartingFromANode [
	"comment stating purpose of message"
	
	| aTree node |
	aTree := CTBasicBinaryTree  binaryTree. 
	
	node := aTree findBreadthFirst: 2 startingFromANode: aTree.
	self assert: node object equals: 2.
]

{ #category : #'test - traversing' }
CTBasicBinaryTreeTest >> testFindDeepFirstOnEmptyTree [
	"comment stating purpose of message"
	
	| aTree node |
	aTree := CTBasicBinaryTree  binaryTreeEmpty. 
	
	node := aTree findDeepFirst: 4 startingFromANode: aTree.
	self assert: node isNil.
]

{ #category : #'test - traversing' }
CTBasicBinaryTreeTest >> testFindDeepFirstStartingFromANode [
	"comment stating purpose of message"
	
	| aTree node |
	aTree := CTBasicBinaryTree  binaryTree. 
	
	node := aTree findDeepFirst: 4 startingFromANode: aTree.
	self assert: node object equals: 4.
]

{ #category : #'test - traversing' }
CTBasicBinaryTreeTest >> testFindNodeBreadthFirstStartingFromANode [
	"comment stating purpose of message"

	| aTree leafNode |
	aTree := CTBasicBinaryTree  binaryTree. 
	
	leafNode := aTree findNodeBreadthFirst: [ :node | node isLeaf ] startingFromANode: aTree.
	self assert: leafNode object equals: 3.
]

{ #category : #'tests - testing' }
CTBasicBinaryTreeTest >> testHasLeftChild [

	| aTree |
	aTree := CTBasicBinaryTree with: 1.
	aTree leftChild: (CTBasicBinaryTree with: 2).
	self assert: aTree hasLeftChild equals: true.
]

{ #category : #'tests - testing' }
CTBasicBinaryTreeTest >> testHasObject [

	| aTree |
	aTree := CTBasicBinaryTree with: 'node'.
	self assert: aTree hasObject equals: true.
]

{ #category : #'tests - testing' }
CTBasicBinaryTreeTest >> testHasParent [

	| aTree |
	aTree := CTBasicBinaryTree with: 1.
	aTree leftChild: (CTBasicBinaryTree with: 2).
	aTree leftChild parent: aTree.
	self assert: aTree leftChild hasParent equals: true.
]

{ #category : #'tests - testing' }
CTBasicBinaryTreeTest >> testHasRightChild [
	"comment stating purpose of message"

	| aTree |
	aTree := CTBasicBinaryTree with: 1.
	aTree rightChild: (CTBasicBinaryTree with: 3).
	self assert: aTree hasRightChild equals: true.
]

{ #category : #'tests - instance creation' }
CTBasicBinaryTreeTest >> testInitialize [ 

	| aTree |
	aTree := CTBasicBinaryTree new.
	self assert: aTree parent isNil.
	self assert: aTree object isNil.
	self assert: aTree leftChild isNil.
	self assert: aTree rightChild isNil.
]

{ #category : #'tests - instance creation' }
CTBasicBinaryTreeTest >> testInstantiateWith [

	| aTree |
	aTree := CTBasicBinaryTree with: 5.
	self assert: aTree object equals: 5.

]

{ #category : #'tests - testing' }
CTBasicBinaryTreeTest >> testIsLeaf [
	"comment stating purpose of message"

	| aTree aNode |
	aTree := CTBasicBinaryTree binaryTree.
	aNode := aTree findDeepFirst: 5 startingFromANode: aTree.
	self assert: aNode isLeaf equals: true.
]

{ #category : #'tests - testing' }
CTBasicBinaryTreeTest >> testIsLeafHasOnlyLeftChild [
	"comment stating purpose of message"

	| aTree aNode |
	aTree := CTBasicBinaryTree with: 1.
	aTree leftChild: (CTBasicBinaryTree with: 2).
	aNode := aTree findDeepFirst: 1 startingFromANode: aTree.
	self assert: aNode isLeaf equals: false.
]

{ #category : #'test accessing' }
CTBasicBinaryTreeTest >> testLeftChild [ 

	| aTree |
	aTree := CTBasicBinaryTree with: 1.
	aTree leftChild: (CTBasicBinaryTree with: 2).
	self assert: aTree leftChild object equals: 2.
]

{ #category : #'test accessing' }
CTBasicBinaryTreeTest >> testObject [

	| aTree |
	aTree := CTBasicBinaryTree new.
	aTree object: 7.
	self assert: aTree object equals: 7.
]

{ #category : #'test accessing' }
CTBasicBinaryTreeTest >> testParent [

	| aTree |
	aTree := CTBasicBinaryTree with: 1.
	aTree rightChild: (CTBasicBinaryTree with: 3).
	aTree rightChild parent: aTree.
	self assert: aTree rightChild parent object equals: 1.
]

{ #category : #'test adding/removing' }
CTBasicBinaryTreeTest >> testRemoveNodeWithObjectIfAbsent [
	"comment stating purpose of message"

	| aTree isDeleted node |
	aTree := CTBasicBinaryTree binaryTree.
	isDeleted := aTree removeNodeWithObject: 2 ifAbsent: [ false ].
	self assert: isDeleted equals: true.
	self assert: aTree leftChild object equals: 5.
	node := aTree findBreadthFirst: 4 startingFromANode: aTree.
	self assert: node rightChild isNil.
	
]

{ #category : #'test adding/removing' }
CTBasicBinaryTreeTest >> testRemoveSingleNodeIfAbsent [
	"comment stating purpose of message"

	| aTree isDeleted node |
	aTree := CTBasicBinaryTree with: 1.
	aTree leftChild: (CTBasicBinaryTree with: 2).
	node := aTree findBreadthFirst: 2 startingFromANode: aTree.
	isDeleted := aTree removeSingleNode: node ifAbsent: [ false ].
	
	self assert: isDeleted equals: true.

	
]

{ #category : #'test accessing' }
CTBasicBinaryTreeTest >> testRightChild [ 

	| aTree |
	aTree := CTBasicBinaryTree with: 1.
	aTree rightChild: (CTBasicBinaryTree with: 3).
	self assert: aTree rightChild object equals: 3.
]

{ #category : #'test operations' }
CTBasicBinaryTreeTest >> testSizeOfTree [
	"comment stating purpose of message"
	
	| aTree |
	aTree := CTBasicBinaryTree  binaryTree. 
	
	self assert: aTree sizeOfTree equals: 5.
]

{ #category : #'test operations' }
CTBasicBinaryTreeTest >> testSizeOfTreeOnEmptyTree [
	"comment stating purpose of message"
	
	| aTree |
	aTree := CTBasicBinaryTree  binaryTreeEmpty. 
	
	self assert: aTree sizeOfTree equals: 1.
]

{ #category : #'test operations' }
CTBasicBinaryTreeTest >> testSizeOfTreeWithOnlyLeftChild [
	"comment stating purpose of message"
	
	| aTree |
	aTree := CTBasicBinaryTree with: 1.
	aTree leftChild: (CTBasicBinaryTree with: 2).
	
	self assert: aTree sizeOfTree equals: 2.
]
