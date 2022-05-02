Class {
	#name : #CTGeneralTreeTest,
	#superclass : #TestCase,
	#category : #'Containers-NewTrees-Tests'
}

{ #category : #'test adding/removing' }
CTGeneralTreeTest >> testAddNode [

	| aTree |
	aTree := CTGeneralTree with: (CTBinaryNode with: 5).
	aTree addNode: 6.
	self assert: aTree root data equals: 5.
	self assert: aTree root leftChild data equals: 6.
	self assert: aTree root rightChild isNullNode.
]

{ #category : #'test adding/removing' }
CTGeneralTreeTest >> testAddNodeToBinaryTree [

	| aTree parent |
	aTree := CTGeneralTree binaryTree.
	aTree addNode: 6.
	parent := aTree findBreadthFirst: [ :n | n data == 3 ].
	
	self assert: parent leftChild data equals: 6.
	self assert: aTree root data equals: 1.
	

]

{ #category : #'test - operations' }
CTGeneralTreeTest >> testDepth [ 

	| tree |
	tree := CTGeneralTree binaryTree.
	self assert: tree depth equals: 2.
]

{ #category : #'test - traversing' }
CTGeneralTreeTest >> testFindBreadthFirst [
	
	| aTree node |
	aTree := CTGeneralTree  binaryTree. 
	
	node := aTree findBreadthFirst: [ :n| n data == 4].
	self assert: node data equals: 4.
]

{ #category : #'test - traversing' }
CTGeneralTreeTest >> testFindDeepFirst [
	
	| aTree node |
	aTree := CTGeneralTree  binaryTree. 
	
	node := aTree findDeepFirst: [ :n| n data == 4].
	self assert: node data equals: 4.
]

{ #category : #'test - traversing' }
CTGeneralTreeTest >> testInOrderDo [

	| aTree result testResult|
	aTree := CTGeneralTree binaryTree.
	result:= OrderedCollection new.
	testResult := #(4 2 5 1 3) asOrderedCollection. 
	
	aTree inOrderDo: [:node | result add: node data].
	
	1 to: 5 do:
		[:i | self assert: (testResult at:i) equals: (result at:i) ].
]

{ #category : #'test - instance creation' }
CTGeneralTreeTest >> testInitialize [ 

	| aTree |
	aTree := CTGeneralTree new.
	self assert: aTree root isNullNode.

]

{ #category : #'test - instance creation' }
CTGeneralTreeTest >> testInstantiateWith [

	| aTree |
	aTree := CTGeneralTree with: (CTBinaryNode with: 1).
	self assert: aTree root data equals: 1.
	self assert: aTree root leftChild isNullNode.
	self assert: aTree root rightChild isNullNode.

]

{ #category : #'test - traversing' }
CTGeneralTreeTest >> testPostOrderDo [

	| aTree result testResult|
	aTree := CTGeneralTree binaryTree.
	result:= OrderedCollection new.
	testResult := #(4 5 2 3 1) asOrderedCollection. 
	
	aTree postOrderDo: [:node | result add: node data].
	
	1 to: 5 do:
		[:i | self assert: (testResult at:i) equals: (result at:i) ].
]

{ #category : #'test - traversing' }
CTGeneralTreeTest >> testPreOrderDo [

	| aTree result testResult|
	aTree := CTGeneralTree binaryTree.
	result:= OrderedCollection new.
	testResult := #(1 2 4 5 3) asOrderedCollection. 
	
	aTree preOrderDo: [:node | result add: node data].
	
	1 to: 5 do:
		[:i | self assert: (testResult at:i) equals: (result at:i) ].
]

{ #category : #'test adding/removing' }
CTGeneralTreeTest >> testRemoveLeafNode [

	| aTree |
	aTree := CTGeneralTree binaryTree.
	aTree removeNode: 5.
	 aTree root leftChild leftChild isNullNode.
	self assert: aTree root data equals: 1.
	
	
	self assert: aTree root leftChild rightChild isNullNode.
	self deny: aTree root leftChild leftChild isNullNode.

	
]

{ #category : #'test adding/removing' }
CTGeneralTreeTest >> testRemoveLeftChildLeafNode [

	| aTree |
	aTree := CTGeneralTree binaryTree.
	aTree removeNode: 4.

	self assert: aTree root data equals: 1.
	
	self deny: aTree root leftChild rightChild isNullNode.
	self assert: aTree root leftChild leftChild isNullNode.

	
]

{ #category : #'test adding/removing' }
CTGeneralTreeTest >> testRemoveNode [

	| aTree |
	aTree := CTGeneralTree with: (CTBinaryNode with: 5).
	aTree root leftChild: (CTBinaryNode with: 6).
	aTree removeNode: 6.
	self assert: aTree root data equals: 5.
	self assert: aTree root leftChild isNullNode.

	
]

{ #category : #'test adding/removing' }
CTGeneralTreeTest >> testRemoveNonExistingNode [

	| aTree |
	aTree := CTGeneralTree binaryTree.
	aTree removeNode: 8.
	self assert: aTree root data equals: 1.

	
]

{ #category : #'test adding/removing' }
CTGeneralTreeTest >> testRemoveRightChildLeafNode [

	| aTree |
	aTree := CTGeneralTree binaryTree.
	aTree removeNode: 5.

	self assert: aTree root data equals: 1.
	
	
	self assert: aTree root leftChild rightChild isNullNode.
	self deny: aTree root leftChild leftChild isNullNode.

	
]

{ #category : #'test adding/removing' }
CTGeneralTreeTest >> testRemoveRoot [

	| aTree |
	aTree := CTGeneralTree with: (CTBinaryNode with: 1).
	aTree removeNode: 1.

	self assert: aTree root isNullNode.

	
]

{ #category : #'test - accessing' }
CTGeneralTreeTest >> testRoot [

	| aTree |
	aTree := CTGeneralTree new.
	aTree root: (CTBinaryNode with: 1).
	self assert: aTree root data equals: 1.
]

{ #category : #'test - operations' }
CTGeneralTreeTest >> testSizeOfTree [

	| tree |
	tree := CTGeneralTree binaryTree.
	self assert: tree size equals: 5.
]
