Class {
	#name : #BinaryNodeTest,
	#superclass : #TestCase,
	#category : #'Containers-BinarySearchTree-Tests'
}

{ #category : #initialization }
BinaryNodeTest >> testSetingKey [
	"check if setting a key value returns a correct key value"
	| aNode |
	aNode := BinaryNode new.
	aNode key: 5.
	self assert: aNode key equals: 5.
]
