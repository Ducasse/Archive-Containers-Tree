Class {
	#name : #CTNullNodeTest,
	#superclass : #TestCase,
	#instVars : [
		'aTree'
	],
	#category : #'Containers-NewTrees-Tests'
}

{ #category : #examples }
CTNullNodeTest >> nullTree [

	^ CTNullNode uniqueInstance
]

{ #category : #examples }
CTNullNodeTest >> sampleEmptyBinaryTree [

	^ CTBinaryTree sampleEmptyBinaryTree
]

{ #category : #'test - traversing' }
CTNullNodeTest >> setUp [ 

	 aTree := self nullTree
]

{ #category : #'test adding/removing' }
CTNullNodeTest >> testAddNode [

	| node |
	node := aTree addNode: 6.
	self assert: node data equals: 6.
]

{ #category : #'test - operations' }
CTNullNodeTest >> testDepth [

	self assert: aTree depth equals: 0.
]

{ #category : #'test - traversing' }
CTNullNodeTest >> testFindBreadthFirst [

	| node | 
	node := aTree findBreadthFirst: [ :n| n data == 6 ].
	self assert: node isNullNode.
]

{ #category : #'test - traversing' }
CTNullNodeTest >> testFindDeepFirst [
	
	| node | 
	node := aTree findDeepFirst: [ :n| n data == 6].
	self assert: node isNullNode.
]

{ #category : #'test - traversing' }
CTNullNodeTest >> testInOrderDo [

	| result |
	result:= OrderedCollection new.
	aTree inOrderDo: [:node | result add: node data].
	self assert: result isEmpty. 
]

{ #category : #'test accessing' }
CTNullNodeTest >> testIsLeaf [

	self assert: aTree isLeaf equals: false.

]

{ #category : #'test accessing' }
CTNullNodeTest >> testIsNullNode [

	self assert: aTree isNullNode

]

{ #category : #'test - traversing' }
CTNullNodeTest >> testPostOrderDo [

	| result |
	result:= OrderedCollection new.	
	aTree postOrderDo: [:node | result add: node data].
	self assert: result isEmpty. 

]

{ #category : #'test - traversing' }
CTNullNodeTest >> testPreOrderDo [

	| result |
	result:= OrderedCollection new.
	aTree preOrderDo: [:node | result add: node data].
	self assert: result isEmpty. 
]

{ #category : #'test adding/removing' }
CTNullNodeTest >> testRemove [ 

	aTree remove: aTree.
	self assert: aTree isNullNode
]

{ #category : #'test - operations' }
CTNullNodeTest >> testSizeOfTree [

	self assert: aTree size equals: 0.
]
