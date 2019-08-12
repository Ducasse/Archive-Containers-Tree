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
