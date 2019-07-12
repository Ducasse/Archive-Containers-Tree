Class {
	#name : #CTBasicBinaryTreeTest,
	#superclass : #TestCase,
	#category : #'Containers-BinarySearchTree-Tests'
}

{ #category : #'tests - testing' }
CTBasicBinaryTreeTest >> testCreationHasNoChildren [

	| aTree |
	aTree := CTBasicBinaryTree new.
	self assert: aTree hasLeftChild & aTree hasRightChild equals: false.
]

{ #category : #'tests - testing' }
CTBasicBinaryTreeTest >> testCreationHasNoLeftChild [

	| aTree |
	aTree := CTBasicBinaryTree new.
	self assert: aTree hasLeftChild equals: false.
]

{ #category : #'tests - testing' }
CTBasicBinaryTreeTest >> testCreationHasNoObject [

	| aTree |
	aTree := CTBasicBinaryTree new.
	self assert: aTree hasObject equals: false.
]

{ #category : #'tests - testing' }
CTBasicBinaryTreeTest >> testCreationHasNoParent [

	| aTree |
	aTree := CTBasicBinaryTree new.
	self assert: aTree hasParent equals: false.
]

{ #category : #'tests - testing' }
CTBasicBinaryTreeTest >> testCreationHasNoRightChild [

	| aTree |
	aTree := CTBasicBinaryTree new.
	self assert: aTree hasRightChild equals: false.
]

{ #category : #'tests - testing' }
CTBasicBinaryTreeTest >> testHasLeftChild [

	| aTree |
	aTree := CTBasicBinaryTree with: 1.
	aTree leftChild: (CTBasicBinaryTree with: 2).
	self assert: aTree hasLeftChild equals: true.
]

{ #category : #'tests - testing' }
CTBasicBinaryTreeTest >> testHasObject [

	| aTree |
	aTree := CTBasicBinaryTree with: 'node'.
	self assert: aTree hasObject equals: true.
]

{ #category : #'tests - testing' }
CTBasicBinaryTreeTest >> testHasParent [

	| aTree |
	aTree := CTBasicBinaryTree with: 1.
	aTree leftChild: (CTBasicBinaryTree with: 2).
	aTree leftChild parent: aTree.
	self assert: aTree leftChild hasParent equals: true.
]

{ #category : #'tests - testing' }
CTBasicBinaryTreeTest >> testHasRightChild [
	"comment stating purpose of message"

	| aTree |
	aTree := CTBasicBinaryTree with: 1.
	aTree rightChild: (CTBasicBinaryTree with: 3).
	self assert: aTree hasRightChild equals: true.
]

{ #category : #'tests - instance creation' }
CTBasicBinaryTreeTest >> testInitialize [ 

	| aTree |
	aTree := CTBasicBinaryTree new.
	self assert: aTree parent isNil.
	self assert: aTree object isNil.
	self assert: aTree leftChild isNil.
	self assert: aTree rightChild isNil.
]