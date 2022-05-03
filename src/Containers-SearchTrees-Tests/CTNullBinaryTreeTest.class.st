Class {
	#name : #CTNullBinaryTreeTest,
	#superclass : #TestCase,
	#category : #'Containers-SearchTrees-Tests'
}

{ #category : #'test adding/removing' }
CTNullBinaryTreeTest >> testAdd [ 
	| aTree |
	aTree := CTNullBinarySearchNode new.
	aTree := aTree add: 4.
	
	self assert: aTree object equals: 4.
]

{ #category : #'test adding/removing' }
CTNullBinaryTreeTest >> testAddNode [ 
	| aTree |
	aTree := CTNullBinarySearchNode new.
	aTree := aTree addNode: (CTBinarySearchTree with: 4).
	self assert: aTree object equals: 4.
]

{ #category : #'test operations' }
CTNullBinaryTreeTest >> testDepth [

	| aTree |
	aTree := CTNullBinarySearchNode uniqueInstance.
	self assert: aTree depth equals: 0
]

{ #category : #'test - traversing' }
CTNullBinaryTreeTest >> testFindBreadthFirst [ 

	| aTree |
	aTree := CTNullBinarySearchNode uniqueInstance.
	self assert: (aTree findBreadthFirst: [ :n| n object == 6 ]) isNullNode
]

{ #category : #'test - traversing' }
CTNullBinaryTreeTest >> testFindDeepFirst [ 

	| aTree |
	aTree := CTNullBinarySearchNode uniqueInstance.
	self assert: (aTree findDeepFirst: [ :n| n object == 6 ]) isNullNode
]

{ #category : #'test lookup' }
CTNullBinaryTreeTest >> testFindNode [

	| aTree |
	aTree := CTNullBinarySearchNode uniqueInstance.
	self assert: (aTree findNode: 2) isNullNode.
]

{ #category : #'test operations' }
CTNullBinaryTreeTest >> testHeight [ 

	| aTree |
	aTree := CTNullBinarySearchNode uniqueInstance.
	self assert: aTree height equals: -1.
]

{ #category : #'test - traversing' }
CTNullBinaryTreeTest >> testInOrderDo [

	| aTree result |
	aTree :=  CTNullBinarySearchNode uniqueInstance.
	result:= OrderedCollection new.
	
	aTree inOrderDo: [:node | result add: node object].
	self assert: result isEmpty. 
]

{ #category : #'test testing' }
CTNullBinaryTreeTest >> testIsLeaf [ 

	| aTree |
	aTree := CTNullBinarySearchNode uniqueInstance.
	self deny: aTree isLeaf
]

{ #category : #'test testing' }
CTNullBinaryTreeTest >> testIsNullNode [

	| aTree |
	aTree := CTNullBinarySearchNode uniqueInstance.
	self assert: aTree isNullNode
]

{ #category : #'test accessing' }
CTNullBinaryTreeTest >> testLeftmostNode [ 

	| aTree |
	aTree := CTNullBinarySearchNode uniqueInstance.
	self assert: (aTree leftmostNode: aTree) isNullNode
]

{ #category : #'test operations' }
CTNullBinaryTreeTest >> testMaximumValue [

	| aTree |
	aTree := CTNullBinarySearchNode uniqueInstance.
	self assert: aTree maximumValue isNil
]

{ #category : #'test operations' }
CTNullBinaryTreeTest >> testMinimumValue [

	| aTree |
	aTree := CTNullBinarySearchNode uniqueInstance.
	self assert: aTree minimumValue isNil
]

{ #category : #'test - traversing' }
CTNullBinaryTreeTest >> testPostOrderDo [

	| aTree result |
	aTree :=  CTNullBinarySearchNode uniqueInstance.
	result:= OrderedCollection new.
	
	aTree postOrderDo: [:node | result add: node object].
	self assert: result isEmpty. 
]

{ #category : #'test - traversing' }
CTNullBinaryTreeTest >> testPreOrderDo [

	| aTree result |
	aTree :=  CTNullBinarySearchNode uniqueInstance.
	result:= OrderedCollection new.
	
	aTree preOrderDo: [:node | result add: node object].
	self assert: result isEmpty. 
]

{ #category : #'test adding/removing' }
CTNullBinaryTreeTest >> testRemove [
	| aTree |
	aTree := CTNullBinarySearchNode new.
	aTree := aTree remove: 4.
	
	self assert: aTree isNullNode
]

{ #category : #'test accessing' }
CTNullBinaryTreeTest >> testRightmostNode [ 

	| aTree |
	aTree := CTNullBinarySearchNode uniqueInstance.
	self assert: (aTree rightmostNode: aTree) isNullNode
]

{ #category : #'test operations' }
CTNullBinaryTreeTest >> testSizeOfTree [

	| aTree |
	aTree := CTNullBinarySearchNode uniqueInstance.
	self assert: aTree size equals: 0.
]
