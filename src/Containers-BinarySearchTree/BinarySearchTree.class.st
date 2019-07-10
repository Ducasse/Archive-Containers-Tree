Class {
	#name : #BinarySearchTree,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#category : #'Containers-BinarySearchTree'
}

{ #category : #examples }
BinarySearchTree class >> bsTree [
	<sampleInstance>
	| tree node1 node2 node3 node4 node5 node6 node7 node8 |
	tree := self new.
	node1 := BinaryNode new.
	node1 key: 8.
	node2 := BinaryNode new.
	node2 key: 3.
	node3 := BinaryNode new.
	node3 key: 10.
	node4 := BinaryNode new.
	node4 key: 1.
	node5 := BinaryNode new.
	node5 key: 6.
	node6 := BinaryNode new.
	node6 key: 4.
	node7 := BinaryNode new.
	node7 key: 7.
	node8 := BinaryNode new.
	node8 key: 14.
	tree root: node1.
	tree root leftChild: node2.
	tree root rightChild: node3.
	tree root leftChild leftChild: node4.
	tree root leftChild rightChild: node5.
	tree root leftChild rightChild leftChild: node6.
	tree root leftChild rightChild rightChild: node7.
	tree root rightChild rightChild: node8.
	^tree.
	
]

{ #category : #adding }
BinarySearchTree >> add:aKey [
	"Add a node with passed key to a binary search tree"
	self isEmpty
	ifTrue: [^(self root: (self add: aKey node: self root ))].
	 ^ self add: aKey node: self root

]

{ #category : #adding }
BinarySearchTree >> add: aKey node: aNode [
	"Add a node with passed key to a binary search tree"

	aNode isNil
		ifTrue: [ ^ (BinaryNode new key: aKey) ].
	aKey < (aNode key)
		ifTrue: [ ^(aNode leftChild: (self add: aKey node: aNode leftChild)) ].
	aKey > (aNode key)
		ifTrue: [ ^(aNode rightChild: (self add: aKey node: aNode rightChild))].
	aKey == (aNode key)
		ifTrue: [self error: 'key already exists'].
]

{ #category : #walking }
BinarySearchTree >> bfs: info [
	"Breadth fisrt search for an information. If there is no key containing given infomration returns nil. If the info is found returns a node containing it"
	| queue |
	self isEmpty 
		ifTrue: [ ^ nil ].
	queue := LinkedList new.
	queue addLast: self root.
	
	[ queue isNotEmpty ] whileTrue: [ 
		| node |
		node := queue removeFirst.
		node key == info  
			ifTrue: [ ^node ].
		node leftChild isNotNil 
			ifTrue: [ queue addLast: node leftChild ].
		node rightChild isNotNil
			ifTrue: [ queue addLast: node rightChild ].
		 ].
		^ nil.
	
	
	
]

{ #category : #accessing }
BinarySearchTree >> depth [
	"Depth of a binary tree is length of longest path from an arbirary node to a root. It the three is empty the depth is -1. If a three only has a root element its depth is 1 "
	
	self isEmpty 
		ifTrue: [ ^ -1 ].
	^ self depth: self root
	
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
	^ leftDepth > rightDepth 
		ifTrue: [ 1 + leftDepth ]
		ifFalse: [ 1 + rightDepth ]
]

{ #category : #walking }
BinarySearchTree >> dfs: info [
	"Depth fisrt search for an information. If there is no key containing given infomration returns nil. If the info is found returns a node containing it"
	
	self isEmpty 
		ifTrue: [ ^nil ].
	^ self dfs: info node: self root
	
]

{ #category : #walking }
BinarySearchTree >> dfs: info node: aNode [
	| node |
	aNode key == info
		ifTrue: [ ^ aNode ].
		
	aNode leftChild isNotNil
		ifFalse: [ ^ nil ].
	node := self dfs: info node: aNode leftChild.
	node isNotNil
		ifTrue: [ ^ node ].
		
	aNode rightChild isNotNil
		ifFalse: [ ^ nil ].
	node := self dfs: info node: aNode rightChild.
	node isNotNil
		ifTrue: [ ^ node ].
]

{ #category : #testing }
BinarySearchTree >> hasChildren [
	"Answer whether the receiver contains any elements."
	
	^ root isNil
]

{ #category : #testing }
BinarySearchTree >> isEmpty [
	"Returns true if root is nil, false otherwise"
	
	^ root isNil
]

{ #category : #accessing }
BinarySearchTree >> root [
	"Returns root element of a binary tree. If a tree is empty, returns nil"
	^root
]

{ #category : #accessing }
BinarySearchTree >> root: rootNode [

	root := rootNode
]

{ #category : #accessing }
BinarySearchTree >> size [
	"Returns size of a tree - number of nodes in a tree"

	self root isNil 
		ifTrue: [ ^ 0 ].
	^ self size: self root
	
]

{ #category : #accessing }
BinarySearchTree >> size: aNode [
	"Returns size of a tree starting from a given node"
	
	| leftSize rightSize |
	leftSize := 0.
	rightSize := 0.
	aNode leftChild isNotNil 
		ifTrue: [ leftSize := self size: aNode leftChild ].
	aNode rightChild isNotNil
		ifTrue: [ rightSize := self size: aNode rightChild ].
	^ 1 + leftSize + rightSize
	 
	
]
