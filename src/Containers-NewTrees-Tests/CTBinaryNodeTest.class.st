Class {
	#name : #CTBinaryNodeTest,
	#superclass : #TestCase,
	#category : #'Containers-NewTrees-Tests'
}

{ #category : #'adding/removing' }
CTBinaryNodeTest >> testAddNode [

	| aTree parent |
	aTree := CTGeneralTree binaryTree.
	aTree root addNode: 6.
	parent := aTree findBreadthFirst: [ :n | n data == 3 ].
	
	self assert: parent leftChild data equals: 6.
	self assert: aTree root data equals: 1.
]

{ #category : #'test accessing' }
CTBinaryNodeTest >> testData [ 

	| aTree |
	aTree := CTGeneralTree with: (CTBinaryNode with: 1).
	aTree root data: 2.
	self assert: aTree root data equals: 2.
]

{ #category : #'test accessing' }
CTBinaryNodeTest >> testDeepestRightmostNode [

	| aTree node |
	aTree := CTGeneralTree binaryTree.
	node := aTree root deepestRightmostNode.
	self assert: node data equals: 5.
]

{ #category : #'test - operations' }
CTBinaryNodeTest >> testDepth [ 

	| tree |
	tree := CTGeneralTree binaryTree.
	self assert: tree root depth equals: 2.
]

{ #category : #'test - traversing' }
CTBinaryNodeTest >> testFindBreadthFirst [

	| aTree node |
	aTree := CTGeneralTree binaryTree. 

	node := aTree root findBreadthFirst: [ :n| n data == 3 ].
	self assert: node data equals: 3.
]

{ #category : #'test - traversing' }
CTBinaryNodeTest >> testFindDeepFirst [

	| aTree node |
	aTree := CTGeneralTree binaryTree. 

	node := aTree root findDeepFirst: [ :n| n data == 2 ].
	node data.
	self assert: node data equals: 2.
]

{ #category : #'test - traversing' }
CTBinaryNodeTest >> testInOrderDo [

	| aTree result testResult|
	aTree := CTGeneralTree binaryTree.
	result:= OrderedCollection new.
	testResult := #(4 2 5 1 3) asOrderedCollection. 
	
	aTree root inOrderDo: [:node | result add: node data].
	
	1 to: 5 do:
		[:i | self assert: (testResult at:i) equals: (result at:i) ].
]

{ #category : #'test - instance creation' }
CTBinaryNodeTest >> testInitialize [ 

	| aNode |
	aNode := CTBinaryNode new.
	self assert: aNode data isNil.
	self assert: aNode leftChild isNullNode.
	self assert: aNode rightChild isNullNode.
]

{ #category : #'test - instance creation' }
CTBinaryNodeTest >> testInstantiateWith [

	| aNode |
	aNode := CTBinaryNode with: 2.
	self assert: aNode data equals: 2.
]

{ #category : #'test accessing' }
CTBinaryNodeTest >> testIsLeaf [

	| aTree |
	aTree := CTGeneralTree with: (CTBinaryNode with: 1). 
	self assert: aTree root isLeaf.
]

{ #category : #'test accessing' }
CTBinaryNodeTest >> testIsNotLeaf [

	| aTree |
	aTree := CTGeneralTree with: (CTBinaryNode with: 1). 
	aTree root leftChild: (CTBinaryNode with: 2).
	self deny: aTree root isLeaf.
]

{ #category : #'test accessing' }
CTBinaryNodeTest >> testIsNullNode [

	| aTree |
	aTree := CTGeneralTree binaryTree. 
	self assert: aTree root isNullNode equals: false.
]

{ #category : #'test accessing' }
CTBinaryNodeTest >> testLeftChild [ 

	| aTree |
	aTree := CTGeneralTree with: (CTBinaryNode with: 1).
	aTree root leftChild: (CTBinaryNode with: 2).
	self assert: aTree root leftChild data equals: 2.
]

{ #category : #'test - traversing' }
CTBinaryNodeTest >> testPostOrderDo [

	| aTree result testResult|
	aTree := CTGeneralTree binaryTree.
	result:= OrderedCollection new.
	testResult := #(4 5 2 3 1) asOrderedCollection. 
	
	aTree root postOrderDo: [:node | result add: node data].
	
	1 to: 5 do:
		[:i | self assert: (testResult at:i) equals: (result at:i) ].
]

{ #category : #'test - traversing' }
CTBinaryNodeTest >> testPreOrderDo [

	| aTree result testResult|
	aTree := CTGeneralTree binaryTree.
	result:= OrderedCollection new.
	testResult := #(1 2 4 5 3) asOrderedCollection. 
	
	aTree root preOrderDo: [:node | result add: node data].
	
	1 to: 5 do:
		[:i | self assert: (testResult at:i) equals: (result at:i) ].
]

{ #category : #'adding/removing' }
CTBinaryNodeTest >> testRemove [

	| aTree |
	aTree := CTGeneralTree binaryTree.
	aTree root remove: 2.
		
	self assert: aTree root leftChild data equals: 5.
	self assert: aTree root leftChild rightChild isNullNode.
]

{ #category : #'adding/removing' }
CTBinaryNodeTest >> testRemoveDeepestRightmostNode [

	| aTree |
	aTree := CTGeneralTree binaryTree.
	
	aTree root removeDeepestRightmostNode.
	self assert: aTree root leftChild rightChild isNullNode.
	
]

{ #category : #'adding/removing' }
CTBinaryNodeTest >> testRemoveLeafNode [

	| aTree node |
	aTree := CTGeneralTree binaryTree.
	node := aTree root findDeepFirst: [ :n | n data == 4 ].
	
	aTree root removeLeafNode: node.
	
	self assert: aTree root data equals: 1.
	
	self assert: aTree root leftChild leftChild isNullNode.
	self deny: aTree root leftChild rightChild isNullNode.
]

{ #category : #'adding/removing' }
CTBinaryNodeTest >> testRemoveNonExistingNode [

	| aTree |
	aTree := CTGeneralTree binaryTree.
	aTree root remove: (CTBinaryNode with: 7).

	
	self assert: aTree root data equals: 1.
]

{ #category : #'test accessing' }
CTBinaryNodeTest >> testRightChild [ 

	| aTree |
	aTree := CTGeneralTree with: (CTBinaryNode with: 1).
	aTree root rightChild: (CTBinaryNode with: 2).
	self assert: aTree root rightChild data equals: 2.
]

{ #category : #'test - operations' }
CTBinaryNodeTest >> testSizeOfTree [

	| tree |
	tree := CTGeneralTree binaryTree.
	self assert: tree root sizeOfTree equals: 5.
]
