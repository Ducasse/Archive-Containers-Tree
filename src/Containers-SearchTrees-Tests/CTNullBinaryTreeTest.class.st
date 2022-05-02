Class {
	#name : #CTNullBinaryTreeTest,
	#superclass : #TestCase,
	#category : #'Containers-SearchTrees-Tests'
}

{ #category : #'test adding/removing' }
CTNullBinaryTreeTest >> testAdd [ 
	| aTree |
	aTree := CTNullBinaryTree new.
	aTree := aTree add: 4.
	
	self assert: aTree data equals: 4.
]

{ #category : #'test adding/removing' }
CTNullBinaryTreeTest >> testAddNode [ 
	| aTree |
	aTree := CTNullBinaryTree new.
	aTree := aTree addNode: (CTBinarySearchTree with: 4).
	self assert: aTree data equals: 4.
]

{ #category : #'test operations' }
CTNullBinaryTreeTest >> testDepth [ 

	| aTree |
	aTree := CTNullBinaryTree uniqueInstance.
	self assert: aTree depth equals: 0.
]

{ #category : #'test - traversing' }
CTNullBinaryTreeTest >> testFindBreadthFirst [ 

	| aTree |
	aTree := CTNullBinaryTree uniqueInstance.
	self assert: (aTree findBreadthFirst: [ :n| n data == 6 ]) isNullNode
]

{ #category : #'test - traversing' }
CTNullBinaryTreeTest >> testFindDeepFirst [ 

	| aTree |
	aTree := CTNullBinaryTree uniqueInstance.
	self assert: (aTree findDeepFirst: [ :n| n data == 6 ]) isNullNode
]

{ #category : #'test lookup' }
CTNullBinaryTreeTest >> testFindNode [

	| aTree |
	aTree := CTNullBinaryTree uniqueInstance.
	self assert: (aTree findNode: 2) isNullNode.
]

{ #category : #'test operations' }
CTNullBinaryTreeTest >> testHeight [ 

	| aTree |
	aTree := CTNullBinaryTree uniqueInstance.
	self assert: aTree height equals: -1.
]

{ #category : #'test - traversing' }
CTNullBinaryTreeTest >> testInOrderDo [

	| aTree result |
	aTree :=  CTNullBinaryTree uniqueInstance.
	result:= OrderedCollection new.
	
	aTree inOrderDo: [:node | result add: node data].
	self assert: result isEmpty. 
]

{ #category : #'test testing' }
CTNullBinaryTreeTest >> testIsLeaf [ 

	| aTree |
	aTree := CTNullBinaryTree uniqueInstance.
	self deny: aTree isLeaf
]

{ #category : #'test testing' }
CTNullBinaryTreeTest >> testIsNullNode [

	| aTree |
	aTree := CTNullBinaryTree uniqueInstance.
	self assert: aTree isNullNode
]

{ #category : #'test accessing' }
CTNullBinaryTreeTest >> testLeftmostNode [ 

	| aTree |
	aTree := CTNullBinaryTree uniqueInstance.
	self assert: (aTree leftmostNode: aTree) isNullNode
]

{ #category : #'test operations' }
CTNullBinaryTreeTest >> testMaximumValue [

	| aTree |
	aTree := CTNullBinaryTree uniqueInstance.
	self assert: aTree maximumValue isNil
]

{ #category : #'test operations' }
CTNullBinaryTreeTest >> testMinimumValue [

	| aTree |
	aTree := CTNullBinaryTree uniqueInstance.
	self assert: aTree minimumValue isNil
]

{ #category : #'test - traversing' }
CTNullBinaryTreeTest >> testPostOrderDo [

	| aTree result |
	aTree :=  CTNullBinaryTree uniqueInstance.
	result:= OrderedCollection new.
	
	aTree postOrderDo: [:node | result add: node data].
	self assert: result isEmpty. 
]

{ #category : #'test - traversing' }
CTNullBinaryTreeTest >> testPreOrderDo [

	| aTree result |
	aTree :=  CTNullBinaryTree uniqueInstance.
	result:= OrderedCollection new.
	
	aTree preOrderDo: [:node | result add: node data].
	self assert: result isEmpty. 
]

{ #category : #'test adding/removing' }
CTNullBinaryTreeTest >> testRemove [
	| aTree |
	aTree := CTNullBinaryTree new.
	aTree := aTree remove: 4.
	
	self assert: aTree isNullNode
]

{ #category : #'test accessing' }
CTNullBinaryTreeTest >> testRightmostNode [ 

	| aTree |
	aTree := CTNullBinaryTree uniqueInstance.
	self assert: (aTree rightmostNode: aTree) isNullNode
]

{ #category : #'test operations' }
CTNullBinaryTreeTest >> testSizeOfTree [

	| aTree |
	aTree := CTNullBinaryTree uniqueInstance.
	self assert: aTree size equals: 0.
]
