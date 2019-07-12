Class {
	#name : #CTBasicBinaryTree,
	#superclass : #Object,
	#instVars : [
		'object',
		'parent',
		'leftChild',
		'rightChild'
	],
	#category : #'Containers-BinarySearchTree'
}

{ #category : #'instance creation' }
CTBasicBinaryTree class >> with: anObject [
	"Return a new tree with one node whose object is anObject and which does not have any children"

	^ self new 
		object: anObject
]

{ #category : #testing }
CTBasicBinaryTree >> hasLeftChild [

	^ leftChild isNotNil
]

{ #category : #testing }
CTBasicBinaryTree >> hasObject [
	^ object isNotNil
]

{ #category : #testing }
CTBasicBinaryTree >> hasParent [
	
	^ parent isNotNil 
]

{ #category : #testing }
CTBasicBinaryTree >> hasRightChild [

	^ rightChild isNotNil
]

{ #category : #initialize }
CTBasicBinaryTree >> initialize [

	super initialize.
]

{ #category : #accessing }
CTBasicBinaryTree >> leftChild [
	^ leftChild
]

{ #category : #accessing }
CTBasicBinaryTree >> leftChild: aTree [
	leftChild := aTree
]

{ #category : #accessing }
CTBasicBinaryTree >> object [
	^ object
]

{ #category : #accessing }
CTBasicBinaryTree >> object: anObject [
	object := anObject
]

{ #category : #accessing }
CTBasicBinaryTree >> parent [
	^ parent
]

{ #category : #accessing }
CTBasicBinaryTree >> parent: aParent [
	parent := aParent
]

{ #category : #accessing }
CTBasicBinaryTree >> rightChild [
	^ rightChild
]

{ #category : #accessing }
CTBasicBinaryTree >> rightChild: aTree [
	rightChild := aTree
]
