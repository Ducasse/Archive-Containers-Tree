Class {
	#name : #CTBinarySearchTreeTest,
	#superclass : #TestCase,
	#category : #'Containers-SearchTrees-Tests'
}

{ #category : #'test adding/removing' }
CTBinarySearchTreeTest >> testAdd [

	| aTree |
	aTree := CTBinarySearchTree with: 8.
	aTree add: 3.
	aTree add: 10.
	aTree add: 6.

	self assert: aTree leftChild data equals: 3.
	self assert: aTree rightChild data equals: 10.
	self assert: aTree leftChild rightChild data equals: 6.
]

{ #category : #'test adding/removing' }
CTBinarySearchTreeTest >> testAddDuplicates [

	| aTree |
	aTree := CTBinarySearchTree new.
	aTree add: 3.
	aTree add: 3. 

	self assert: aTree data equals: 3.
	self assert: aTree leftChild isNullNode.
	self assert: aTree rightChild isNullNode.

]

{ #category : #'test adding/removing' }
CTBinarySearchTreeTest >> testAddToEmptyTree [

	| aTree |
	aTree := CTBinarySearchTree new.
	aTree add: 3.

	self assert: aTree data equals: 3.

]

{ #category : #'test - accessing' }
CTBinarySearchTreeTest >> testData [ 

	| aTree |
	aTree := CTBinarySearchTree new.
	aTree data: 1.
	self assert: aTree data equals: 1.
]

{ #category : #'test - operations' }
CTBinarySearchTreeTest >> testDepth [

	| aTree |
	aTree := CTBinarySearchTree binarySearchTree.
	self assert: aTree depth equals: 2.
]

{ #category : #'test - traversing' }
CTBinarySearchTreeTest >> testFindBreadthFirst [

	| aTree node |
	aTree := CTBinarySearchTree binarySearchTree.

	node := aTree findBreadthFirst: [ :n| n data == 10 ].
	self assert: node data equals: 10.
]

{ #category : #'test - traversing' }
CTBinarySearchTreeTest >> testFindDeepFirst [

	| aTree node |
	aTree := CTBinarySearchTree binarySearchTree.

	node := aTree findDeepFirst: [ :n| n data == 6 ].
	self assert: node data equals: 6.
]

{ #category : #'test lookup' }
CTBinarySearchTreeTest >> testFindNode [

	| aTree |
	aTree := CTBinarySearchTree binarySearchTree.
	self assert: (aTree findNode: 6) data equals: 6.
]

{ #category : #'test lookup' }
CTBinarySearchTreeTest >> testFindNonExistingNode [

	| aTree |
	aTree := CTBinarySearchTree binarySearchTree.
	self assert: (aTree findNode: 7) isNullNode
]

{ #category : #'test lookup' }
CTBinarySearchTreeTest >> testFindRoot [

	| aTree |
	aTree := CTBinarySearchTree with: 1.
	self assert: (aTree findNode: 1) data equals: 1.
]

{ #category : #'test testing' }
CTBinarySearchTreeTest >> testHasBothChildren [

	| aTree |
	aTree := CTBinarySearchTree with: 5.
	aTree add: 7.
	aTree add: 2.
	self assert: aTree hasBothChildren 
]

{ #category : #'test testing' }
CTBinarySearchTreeTest >> testHasOnlyLeftChild [

	| aTree |
	aTree := CTBinarySearchTree with: 5.
	aTree add: 2.
	self assert: aTree hasOnlyLeftChild 
]

{ #category : #'test testing' }
CTBinarySearchTreeTest >> testHasOnlyRightChild [

	| aTree |
	aTree := CTBinarySearchTree with: 5.
	aTree add: 7.
	self assert: aTree hasOnlyRightChild 
]

{ #category : #'test - traversing' }
CTBinarySearchTreeTest >> testInOrderDo [

	| aTree result testResult|
	aTree := CTBinarySearchTree binarySearchTree.
	result:= OrderedCollection new.
	testResult := #(1 3 6 8 10) asOrderedCollection. 
	
	aTree inOrderDo: [:node | result add: node data].
	
	1 to: 5 do:
		[:i | self assert: (testResult at:i) equals: (result at:i) ].
]

{ #category : #'test testing' }
CTBinarySearchTreeTest >> testIsLeaf [
	
	| aTree |
	aTree := CTBinarySearchTree with: 1.
	self assert: aTree isLeaf.
]

{ #category : #'test testing' }
CTBinarySearchTreeTest >> testIsNotLeaf [
	
	| aTree |
	aTree := CTBinarySearchTree with: 1.
	aTree add: 2.
	self deny: aTree isLeaf.
]

{ #category : #'test testing' }
CTBinarySearchTreeTest >> testIsNullNode [
	
	| aTree |
	aTree := CTBinarySearchTree with: 1.
	self deny: aTree isNullNode.
]

{ #category : #'test - accessing' }
CTBinarySearchTreeTest >> testLeftChild [
	
	| aTree |
	aTree := CTBinarySearchTree with: 5.
	aTree add: 3.
	self assert: aTree leftChild data equals: 3.
]

{ #category : #'test - accessing' }
CTBinarySearchTreeTest >> testLeftmostNode [

	| aTree |
	aTree := CTBinarySearchTree binarySearchTree.
	self assert: (aTree leftmostNode: aTree) data equals: 1.
]

{ #category : #'test - operations' }
CTBinarySearchTreeTest >> testMaximumValue [

	| aTree |
	aTree := CTBinarySearchTree binarySearchTree.
	self assert: aTree maximumValue equals: 10.
	
]

{ #category : #'test - operations' }
CTBinarySearchTreeTest >> testMinimumValue [

	| aTree |
	aTree := CTBinarySearchTree binarySearchTree.
	self assert: aTree minimumValue equals: 1.
	
]

{ #category : #'test - traversing' }
CTBinarySearchTreeTest >> testPostOrderDo [

	| aTree result testResult|
	aTree := CTBinarySearchTree binarySearchTree.
	result:= OrderedCollection new.
	testResult := #(1 6 3 10 8) asOrderedCollection. 
	
	aTree postOrderDo: [:node | result add: node data].
	
	1 to: 5 do:
		[:i | self assert: (testResult at:i) equals: (result at:i) ].
]

{ #category : #'test - traversing' }
CTBinarySearchTreeTest >> testPreOrderDo [

	| aTree result testResult|
	aTree := CTBinarySearchTree binarySearchTree.
	result:= OrderedCollection new.
	testResult := #(8 3 1 6 10) asOrderedCollection. 
	
	aTree preOrderDo: [:node | result add: node data].
	
	1 to: 5 do:
		[:i | self assert: (testResult at:i) equals: (result at:i) ].
]

{ #category : #'test adding/removing' }
CTBinarySearchTreeTest >> testRemove [

	| aTree |
	aTree := CTBinarySearchTree binarySearchTree.
	aTree remove: 3.
	
	self assert: aTree leftChild data equals: 6.
	self assert: aTree leftChild rightChild isNullNode.
]

{ #category : #'test adding/removing' }
CTBinarySearchTreeTest >> testRemoveHasOnlyLeftChild [

	| aTree |
	aTree := CTBinarySearchTree with: 3.
	aTree add: 1.
	
	aTree := aTree remove: 3.
		
	self assert: aTree data equals: 1.
]

{ #category : #'test adding/removing' }
CTBinarySearchTreeTest >> testRemoveHasOnlyRightChild [

	| aTree |
	aTree := CTBinarySearchTree with: 3.
	aTree add: 5.
	
	aTree := aTree remove: 3.
		
	self assert: aTree data equals: 5.
]

{ #category : #'test adding/removing' }
CTBinarySearchTreeTest >> testRemoveLeafNode [

	| aTree |
	aTree := CTBinarySearchTree with: 3.
	aTree add: 5.
	
	aTree := aTree remove: 5.
		
	self assert: aTree data equals: 3.
]

{ #category : #'test adding/removing' }
CTBinarySearchTreeTest >> testRemoveRoot [

	| aTree |
	aTree := CTBinarySearchTree with: 3.
	aTree := aTree remove: 3.
		
	self assert: aTree isNullNode
]

{ #category : #'test - accessing' }
CTBinarySearchTreeTest >> testRightChild [
	
	| aTree |
	aTree := CTBinarySearchTree with: 5.
	aTree add: 7.
	self assert: aTree rightChild data equals: 7.
]

{ #category : #'test - accessing' }
CTBinarySearchTreeTest >> testRightmostNode [

	| aTree |
	aTree := CTBinarySearchTree binarySearchTree.
	self assert: (aTree rightmostNode: aTree) data equals: 10.
]

{ #category : #'test - operations' }
CTBinarySearchTreeTest >> testSizeOfTree [

	| aTree |
	aTree := CTBinarySearchTree binarySearchTree.
	self assert: aTree sizeOfTree equals: 5.
]
