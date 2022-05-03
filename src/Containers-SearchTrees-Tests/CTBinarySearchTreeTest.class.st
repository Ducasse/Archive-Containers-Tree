Class {
	#name : #CTBinarySearchTreeTest,
	#superclass : #TestCase,
	#category : #'Containers-SearchTrees-Tests'
}

{ #category : #'test adding/removing' }
CTBinarySearchTreeTest >> binarySearchTreeClass [

	^ CTBinarySearchTree
]

{ #category : #'test adding/removing' }
CTBinarySearchTreeTest >> testAdd [

	| aTree |
	aTree := self binarySearchTreeClass with: 8.
	aTree add: 3.
	aTree add: 10.
	aTree add: 6.

	self assert: aTree leftChild object equals: 3.
	self assert: aTree rightChild object equals: 10.
	self assert: aTree leftChild rightChild object equals: 6
]

{ #category : #'test adding/removing' }
CTBinarySearchTreeTest >> testAddDuplicates [

	| aTree |
	aTree := self binarySearchTreeClass new.
	aTree add: 3.
	aTree add: 3.

	self assert: aTree object equals: 3.
	self assert: aTree leftChild isNullNode.
	self assert: aTree rightChild isNullNode
]

{ #category : #'test adding/removing' }
CTBinarySearchTreeTest >> testAddNode [

	| aTree |
	aTree := self binarySearchTreeClass with: 8.
	aTree addNode: (self binarySearchTreeClass with: 3).
	aTree addNode: (self binarySearchTreeClass with: 10).
	aTree addNode: (self binarySearchTreeClass with: 6).

	self assert: aTree leftChild object equals: 3.
	self assert: aTree rightChild object equals: 10.
	self assert: aTree leftChild rightChild object equals: 6
]

{ #category : #'test adding/removing' }
CTBinarySearchTreeTest >> testAddToEmptyTree [

	| aTree |
	aTree := self binarySearchTreeClass new.
	aTree add: 3.

	self assert: aTree object equals: 3
]

{ #category : #'test - accessing' }
CTBinarySearchTreeTest >> testData [

	| aTree |
	aTree := self binarySearchTreeClass new.
	aTree object: 1.
	self assert: aTree object equals: 1
]

{ #category : #'test - operations' }
CTBinarySearchTreeTest >> testDepth [

	| aTree |
	aTree := self binarySearchTreeClass sampleBinarySearchTree.
	self assert: aTree depth equals: 2
]

{ #category : #'test - traversing' }
CTBinarySearchTreeTest >> testFindBreadthFirst [

	| aTree node |
	aTree := self binarySearchTreeClass sampleBinarySearchTree.

	node := aTree findBreadthFirst: [ :n | n object == 10 ].
	self assert: node object equals: 10
]

{ #category : #'test - traversing' }
CTBinarySearchTreeTest >> testFindDeepFirst [

	| aTree node |
	aTree := self binarySearchTreeClass sampleBinarySearchTree.

	node := aTree findDeepFirst: [ :n | n object == 6 ].
	self assert: node object equals: 6
]

{ #category : #'test lookup' }
CTBinarySearchTreeTest >> testFindNode [

	| aTree |
	aTree := self binarySearchTreeClass sampleBinarySearchTree.
	self assert: (aTree findNode: 6) object equals: 6
]

{ #category : #'test lookup' }
CTBinarySearchTreeTest >> testFindNonExistingNode [

	| aTree |
	aTree := self binarySearchTreeClass sampleBinarySearchTree.
	self assert: (aTree findNode: 7) isNullNode
]

{ #category : #'test lookup' }
CTBinarySearchTreeTest >> testFindRoot [

	| aTree |
	aTree := self binarySearchTreeClass with: 1.
	self assert: (aTree findNode: 1) object equals: 1
]

{ #category : #'test testing' }
CTBinarySearchTreeTest >> testHasBothChildren [

	| aTree |
	aTree := self binarySearchTreeClass with: 5.
	aTree add: 7.
	aTree add: 2.
	self assert: aTree hasBothChildren
]

{ #category : #'test testing' }
CTBinarySearchTreeTest >> testHasOnlyLeftChild [

	| aTree |
	aTree := self binarySearchTreeClass with: 5.
	aTree add: 2.
	self assert: aTree hasOnlyLeftChild
]

{ #category : #'test testing' }
CTBinarySearchTreeTest >> testHasOnlyRightChild [

	| aTree |
	aTree := self binarySearchTreeClass with: 5.
	aTree add: 7.
	self assert: aTree hasOnlyRightChild
]

{ #category : #'test - traversing' }
CTBinarySearchTreeTest >> testInOrderDo [

	| aTree result testResult |
	aTree := self binarySearchTreeClass sampleBinarySearchTree.
	result := OrderedCollection new.
	testResult := #( 1 3 6 8 10 ) asOrderedCollection.

	aTree inOrderDo: [ :node | result add: node object ].

	1 to: 5 do: [ :i | 
	self assert: (testResult at: i) equals: (result at: i) ]
]

{ #category : #'test testing' }
CTBinarySearchTreeTest >> testIsLeaf [

	| aTree |
	aTree := self binarySearchTreeClass with: 1.
	self assert: aTree isLeaf
]

{ #category : #'test testing' }
CTBinarySearchTreeTest >> testIsNotLeaf [

	| aTree |
	aTree := self binarySearchTreeClass with: 1.
	aTree add: 2.
	self deny: aTree isLeaf
]

{ #category : #'test testing' }
CTBinarySearchTreeTest >> testIsNullNode [

	| aTree |
	aTree := self binarySearchTreeClass with: 1.
	self deny: aTree isNullNode
]

{ #category : #'test - accessing' }
CTBinarySearchTreeTest >> testLeftChild [

	| aTree |
	aTree := self binarySearchTreeClass with: 5.
	aTree add: 3.
	self assert: aTree leftChild object equals: 3
]

{ #category : #'test - accessing' }
CTBinarySearchTreeTest >> testLeftmostNode [

	| aTree |
	aTree := self binarySearchTreeClass sampleBinarySearchTree.
	self assert: (aTree leftmostNode: aTree) object equals: 1
]

{ #category : #'test - operations' }
CTBinarySearchTreeTest >> testMaximumValue [

	| aTree |
	aTree := self binarySearchTreeClass sampleBinarySearchTree.
	self assert: aTree maximumValue equals: 10
]

{ #category : #'test - operations' }
CTBinarySearchTreeTest >> testMinimumValue [

	| aTree |
	aTree := self binarySearchTreeClass sampleBinarySearchTree.
	self assert: aTree minimumValue equals: 1
]

{ #category : #'test - traversing' }
CTBinarySearchTreeTest >> testPostOrderDo [

	| aTree result testResult |
	aTree := self binarySearchTreeClass sampleBinarySearchTree.
	result := OrderedCollection new.
	testResult := #( 1 6 3 10 8 ) asOrderedCollection.

	aTree postOrderDo: [ :node | result add: node object ].

	1 to: 5 do: [ :i | 
	self assert: (testResult at: i) equals: (result at: i) ]
]

{ #category : #'test - traversing' }
CTBinarySearchTreeTest >> testPreOrderDo [

	| aTree result testResult |
	aTree := self binarySearchTreeClass sampleBinarySearchTree.
	result := OrderedCollection new.
	testResult := #( 8 3 1 6 10 ) asOrderedCollection.

	aTree preOrderDo: [ :node | result add: node object ].

	1 to: 5 do: [ :i | 
	self assert: (testResult at: i) equals: (result at: i) ]
]

{ #category : #'test adding/removing' }
CTBinarySearchTreeTest >> testRemove [

	| aTree |
	aTree := self binarySearchTreeClass sampleBinarySearchTree.
	aTree remove: 3.

	self assert: aTree leftChild object equals: 6.
	self assert: aTree leftChild rightChild isNullNode
]

{ #category : #'test adding/removing' }
CTBinarySearchTreeTest >> testRemoveHasOnlyLeftChild [

	| aTree |
	aTree := self binarySearchTreeClass with: 3.
	aTree add: 1.

	aTree := aTree remove: 3.

	self assert: aTree object equals: 1
]

{ #category : #'test adding/removing' }
CTBinarySearchTreeTest >> testRemoveHasOnlyRightChild [

	| aTree |
	aTree := self binarySearchTreeClass with: 3.
	aTree add: 5.

	aTree := aTree remove: 3.

	self assert: aTree object equals: 5
]

{ #category : #'test adding/removing' }
CTBinarySearchTreeTest >> testRemoveLeafNode [

	| aTree |
	aTree := self binarySearchTreeClass with: 3.
	aTree add: 5.

	aTree := aTree remove: 5.

	self assert: aTree object equals: 3
]

{ #category : #'test adding/removing' }
CTBinarySearchTreeTest >> testRemoveRoot [

	| aTree |
	aTree := self binarySearchTreeClass with: 3.
	aTree := aTree remove: 3.

	self assert: aTree isNullNode
]

{ #category : #'test - accessing' }
CTBinarySearchTreeTest >> testRightChild [

	| aTree |
	aTree := self binarySearchTreeClass with: 5.
	aTree add: 7.
	self assert: aTree rightChild object equals: 7
]

{ #category : #'test - accessing' }
CTBinarySearchTreeTest >> testRightmostNode [

	| aTree |
	aTree := self binarySearchTreeClass sampleBinarySearchTree.
	self assert: (aTree rightmostNode: aTree) object equals: 10
]

{ #category : #'test - operations' }
CTBinarySearchTreeTest >> testSizeOfTree [

	| aTree |
	aTree := self binarySearchTreeClass sampleBinarySearchTree.
	self assert: aTree size equals: 5
]
