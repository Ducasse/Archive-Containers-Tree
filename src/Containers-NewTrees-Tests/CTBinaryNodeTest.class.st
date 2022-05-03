Class {
	#name : #CTBinaryNodeTest,
	#superclass : #TestCase,
	#category : #'Containers-NewTrees-Tests'
}

{ #category : #'adding/removing' }
CTBinaryNodeTest >> sampleBinaryTree [

	^ CTBinaryNode sampleBinaryTree 
]

{ #category : #'adding/removing' }
CTBinaryNodeTest >> testAddNode [

	| aTree parent |
	aTree := self sampleBinaryTree.
	aTree addNode: 6.
	parent := aTree findBreadthFirst: [ :n | n data == 3 ].
	
	self assert: parent leftChild data equals: 6.
	self assert: aTree data equals: 1.
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
	aTree := self sampleBinaryTree.
	node := aTree deepestRightmostNode.
	self assert: node data equals: 5.
]

{ #category : #'test - operations' }
CTBinaryNodeTest >> testDepth [ 

	| tree |
	tree := self sampleBinaryTree.
	self assert: tree depth equals: 2.
]

{ #category : #'test - traversing' }
CTBinaryNodeTest >> testFindBreadthFirst [

	| aTree node |
	aTree := self sampleBinaryTree. 

	node := aTree findBreadthFirst: [ :n| n data == 3 ].
	self assert: node data equals: 3.
]

{ #category : #'test - traversing' }
CTBinaryNodeTest >> testFindDeepFirst [

	| aTree node |
	aTree := self sampleBinaryTree. 
	node := aTree findDeepFirst: [ :n| n data == 2 ].
	self assert: node data equals: 2.
]

{ #category : #'test - traversing' }
CTBinaryNodeTest >> testInOrderDo [

	| aTree result testResult|
	aTree := self sampleBinaryTree.
	result:= OrderedCollection new.
	testResult := #(4 2 5 1 3) asOrderedCollection. 
	aTree inOrderDo: [:node | result add: node data].
	1 to: 5 do:
		[:i | self 
						assert: (testResult at:i) 
						equals: (result at:i) ].
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
	aTree := self sampleBinaryTree. 
	self assert: aTree isNullNode equals: false.
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
	aTree := self sampleBinaryTree.
	result:= OrderedCollection new.
	testResult := #(4 5 2 3 1) asOrderedCollection. 
	aTree postOrderDo: [:node | result add: node data].
	
	1 to: 5 do:
		[:i | self 
						assert: (testResult at:i) 
						equals: (result at:i) ].
]

{ #category : #'test - traversing' }
CTBinaryNodeTest >> testPreOrderDo [

	| aTree result testResult|
	aTree := self sampleBinaryTree.
	result:= OrderedCollection new.
	testResult := #(1 2 4 5 3) asOrderedCollection. 
	aTree preOrderDo: [:node | result add: node data].
	1 to: 5 do:
		[:i | self assert: (testResult at:i) equals: (result at:i) ].
]

{ #category : #'adding/removing' }
CTBinaryNodeTest >> testRemove [

	| aTree |
	aTree := self sampleBinaryTree.
	aTree remove: 2.
	self assert: aTree leftChild data equals: 5.
	self assert: aTree leftChild rightChild isNullNode.
]

{ #category : #'adding/removing' }
CTBinaryNodeTest >> testRemoveDeepestRightmostNode [

	| aTree |
	aTree := self sampleBinaryTree.
	aTree removeDeepestRightmostNode.
	self assert: aTree leftChild rightChild isNullNode.
	
]

{ #category : #'adding/removing' }
CTBinaryNodeTest >> testRemoveLeafNode [

	| aTree node |
	aTree := self sampleBinaryTree.
	node := aTree findDeepFirst: [ :n | n data == 4 ].
	aTree removeLeafNode: node.
	self assert: aTree data equals: 1.
	self assert: aTree leftChild leftChild isNullNode.
	self deny: aTree leftChild rightChild isNullNode.
]

{ #category : #'adding/removing' }
CTBinaryNodeTest >> testRemoveNonExistingNode [

	| aTree |
	aTree := self sampleBinaryTree.
	aTree remove: (CTBinaryNode with: 7).
	self assert: aTree data equals: 1.
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
	tree := self sampleBinaryTree.
	self assert: tree size equals: 5.
]
