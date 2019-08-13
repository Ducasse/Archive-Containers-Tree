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

{ #category : #'test operations' }
CTNullBinaryTreeTest >> testDepth [ 

	| aTree |
	aTree := CTNullBinaryTree uniqueInstance.
	self assert: aTree depth equals: 0.
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

{ #category : #'test adding/removing' }
CTNullBinaryTreeTest >> testRemove [
	| aTree |
	aTree := CTNullBinaryTree new.
	aTree := aTree remove: 4.
	
	self assert: aTree isNullNode
]

{ #category : #'test operations' }
CTNullBinaryTreeTest >> testSizeOfTree [

	| aTree |
	aTree := CTNullBinaryTree uniqueInstance.
	self assert: aTree sizeOfTree equals: 0.
]
