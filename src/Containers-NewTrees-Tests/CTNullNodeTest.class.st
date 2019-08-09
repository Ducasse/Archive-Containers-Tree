Class {
	#name : #CTNullNodeTest,
	#superclass : #TestCase,
	#category : #'Containers-NewTrees-Tests'
}

{ #category : #'test adding/removing' }
CTNullNodeTest >> testAddNode [

	| aTree node |
	aTree := CTGeneralTree emptyTree.
	node := aTree addNode: 6.
	self assert: aTree root data equals: 6.
]

{ #category : #'test - operations' }
CTNullNodeTest >> testDepth [

	| tree |
	tree := CTGeneralTree new.
	self assert: tree depth equals: 0.
]

{ #category : #'test - traversing' }
CTNullNodeTest >> testFindBreadthFirst [

	| aTree node |
	aTree := CTGeneralTree binaryTree. 
	
	node := aTree root findBreadthFirst: [ :n| n data == 6 ].
	self assert: node isNullNode.
]

{ #category : #'test - traversing' }
CTNullNodeTest >> testFindDeepFirst [
	
	| aTree node |
	aTree := CTGeneralTree  binaryTree. 
	
	node := aTree findDeepFirst: [ :n| n data == 6].
	self assert: node isNullNode.
]

{ #category : #'test - traversing' }
CTNullNodeTest >> testInOrderDo [

	| aTree result |
	aTree :=  CTGeneralTree emptyTree.
	result:= OrderedCollection new.
	
	aTree root inOrderDo: [:node | result add: node data].
	self assert: result isEmpty. 

]

{ #category : #'test accessing' }
CTNullNodeTest >> testIsLeaf [

	| aTree |
	aTree := CTGeneralTree emptyTree.
	self assert: aTree root isLeaf equals: false.

]

{ #category : #'test accessing' }
CTNullNodeTest >> testIsNullNode [

	| aTree |
	aTree := CTGeneralTree emptyTree.
	self assert: aTree root isNullNode

]

{ #category : #'test - traversing' }
CTNullNodeTest >> testPostOrderDo [

	| aTree result |
	aTree :=  CTGeneralTree emptyTree.
	result:= OrderedCollection new.
	
	aTree root postOrderDo: [:node | result add: node data].
	self assert: result isEmpty. 

]

{ #category : #'test - traversing' }
CTNullNodeTest >> testPreOrderDo [

	| aTree result |
	aTree :=  CTGeneralTree emptyTree.
	result:= OrderedCollection new.
	
	aTree root preOrderDo: [:node | result add: node data].
	self assert: result isEmpty. 

]

{ #category : #'test adding/removing' }
CTNullNodeTest >> testRemove [ 

	| aTree |
	aTree := CTGeneralTree emptyTree.
	aTree root remove: aTree root.
	self assert: aTree root isNullNode
]

{ #category : #'test - operations' }
CTNullNodeTest >> testSizeOfTree [

	| tree |
	tree := CTGeneralTree emptyTree.
	self assert: tree root sizeOfTree equals: 0.
]
