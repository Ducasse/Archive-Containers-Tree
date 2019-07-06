Class {
	#name : #BinarySearchTree,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#category : #'Containers-BinarySearchTree'
}

{ #category : #accessing }
BinarySearchTree >> depth [
	"Depth of a binary tree is length of longest path from an arbirary node to a root. It the three is empty the depth is -1. If a three only has a root element its depth is 1 "
	self isEmpty 
	ifTrue: [ ^-1 ].
	^self depth: self root.
	
]

{ #category : #accessing }
BinarySearchTree >> depth:aNode [
	"Returns depth of a tree starting from the given node"
	| leftDepth rightDepth |
	leftDepth := -1.
	aNode leftChild isNotNil 
	ifTrue: [ leftDepth := self depth: aNode leftChild ].
	rightDepth := -1.
	aNode rightChild isNotNil 
	ifTrue: [ rightDepth := self depth: aNode rightChild ].
	
	( leftDepth > rightDepth )
	ifTrue: [ ^ (1 + leftDepth) ]
	ifFalse: [^ (1 + rightDepth ) ].
]

{ #category : #testing }
BinarySearchTree >> isEmpty [
	"Returns true if root is nil, false otherwise"
	^root isNil
]

{ #category : #accessing }
BinarySearchTree >> root [
	"Returns root element of a binary tree. If a tree is empty, returns nil"
	^root
]

{ #category : #accessing }
BinarySearchTree >> root: rootNode [
	"Set a root node"
	root := rootNode
]

{ #category : #accessing }
BinarySearchTree >> size [
	"Returns size of a tree - number of nodes in a tree"
	self root isNil 
	ifTrue: [ ^0 ].
	^self size: self root.
	
]

{ #category : #accessing }
BinarySearchTree >> size:aNode [
	"returns size of a tree starting from a given node"
	| leftSize rightSize |
	leftSize := 0.
	rightSize := 0.
	aNode leftChild isNotNil 
	ifTrue: [ leftSize := (self size: (aNode leftChild)) ].
	aNode rightChild isNotNil
	ifTrue: [ rightSize := (self size: (aNode rightChild ) )].
	^ 1 + leftSize + rightSize.
	 
	
]
