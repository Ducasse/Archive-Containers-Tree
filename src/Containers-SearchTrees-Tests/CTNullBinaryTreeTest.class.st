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
