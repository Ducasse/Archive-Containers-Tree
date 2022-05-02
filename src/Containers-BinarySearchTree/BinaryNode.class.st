"
Probably to be fully thrown and rewritten too. 
"
Class {
	#name : #BinaryNode,
	#superclass : #Object,
	#instVars : [
		'key',
		'leftChild',
		'rightChild'
	],
	#category : #'Containers-BinarySearchTree'
}

{ #category : #accessing }
BinaryNode >> key [
	"return node's key value"
	^key
]

{ #category : #accessing }
BinaryNode >> key: keyValue [
	"set key value for a key in a node"
	key := keyValue
]

{ #category : #accessing }
BinaryNode >> leftChild [
	"return left child"
	^leftChild
]

{ #category : #accessing }
BinaryNode >> leftChild: aNode [
	"set left child"
	leftChild := aNode
]

{ #category : #accessing }
BinaryNode >> rightChild [
	"return right child"
	^rightChild
]

{ #category : #accessing }
BinaryNode >> rightChild: aNode [
	"set right child"
	rightChild := aNode
]
