Class {
	#name : #BinarySearchTreeTest,
	#superclass : #TestCase,
	#category : #'Containers-BinarySearchTree'
}

{ #category : #tests }
BinarySearchTreeTest >> testAddingRoot [
	"test that a node is added to root"

	| aTree aNode |
	aNode := BinaryNode new.
	aNode key: 7.
	aTree := BinarySearchTree new.
	aTree root: aNode.
	
	self assert: aTree root key equals: 7.
]

{ #category : #tests }
BinarySearchTreeTest >> testDepthEmptyTree [
	"test that depth for empty tree is -1"

	| tree |
	tree := BinarySearchTree new.
	self assert: tree depth equals: -1.
	
]

{ #category : #tests }
BinarySearchTreeTest >> testDepthRoot [
	"test that depth for tree with root node is 0"

	| tree node |
	tree := BinarySearchTree new.
	node := BinaryNode new.
	tree root: node.
	self assert: tree depth equals: 0.
	
]

{ #category : #tests }
BinarySearchTreeTest >> testDepthTree [
	"test that size for a tree with root and leftChild is 1"

	| tree node1 node2 |
	tree := BinarySearchTree new.
	node1 := BinaryNode new.
	node2 := BinaryNode new.
	tree root: node1.
	node1 leftChild: node2.
	self assert: tree depth equals: 1.
	
]

{ #category : #tests }
BinarySearchTreeTest >> testDfs [
	"look for info using dfs"

	| tree node |
   tree := BinarySearchTree  bsTree.
	node := tree dfs: 6. 
	
	self assert: node equals: (tree root leftChild rightChild).
	
]

{ #category : #tests }
BinarySearchTreeTest >> testDfsRoot [
	"look for info that is contained in root using dfs"

	| tree node |
	tree := BinarySearchTree  new. 
	node := BinaryNode new.
	node key: 8.
	tree root: node.
	self assert: tree root equals: (tree dfs: 8).
	
]

{ #category : #tests }
BinarySearchTreeTest >> testEmptyTreeRoot [
	"test that the root is nil in an empty binary tree"

	| tree |
	tree := BinarySearchTree new.
	self assert: tree root isNil
]

{ #category : #tests }
BinarySearchTreeTest >> testIsEmptyFalse [
	"test that isEmpty returns false when root is not nil"

	| tree node |
	tree := BinarySearchTree new.
	node := BinaryNode new.
	tree root: node.
	self deny: tree isEmpty.
	
]

{ #category : #tests }
BinarySearchTreeTest >> testIsEmptyTrue [
	"test that isEmpty returns true when root is nil"

	| tree |
	tree := BinarySearchTree new.
	self assert: tree isEmpty.
	
]

{ #category : #tests }
BinarySearchTreeTest >> testSizeEmptyTree [
	"test that size for empty tree is 0"

	| tree |
	tree := BinarySearchTree new.
	self assert: tree size equals: 0.
	
]

{ #category : #tests }
BinarySearchTreeTest >> testSizeRoot [
	"test that size for tree with root node is 1"

	| tree node |
	tree := BinarySearchTree new.
	node := BinaryNode new.
	tree root: node.
	self assert: tree size equals: 1.
	
]

{ #category : #tests }
BinarySearchTreeTest >> testSizeTree [
	"test that size for tree with three nodes is 3"

	| tree node1 node2 node3|
	tree := BinarySearchTree new.
	node1 := BinaryNode new.
	node2 := BinaryNode new.
	node3 := BinaryNode new.
	tree root: node1.
	node1 leftChild: node2.
	node1 rightChild: node3.
	self assert: tree size equals: 3.
	
]
