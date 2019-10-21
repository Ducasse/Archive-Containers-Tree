"
I represent a binary tree. I composed of CTBinaryNode and CTNullNode nodes.

I can be created using addNode: methods and be balanced or I could be created by adding nodes to root using leftChild: and rightChild: methods to have an arbitarty structure. There are no restrictions on if elements can appear multiple times. I provide methods for a node lookup and traversing.

My main responsibility is for my root variable to represent state of a tree. That state can be empty or non-empty and can be changed with methods addNode and remove.

Public API and Key Messages 
- CTGeneralTree binaryTree root >>> 'a CTBinaryNode'
- CTGeneralTree emptyTree root >>> 'a CTNullNode'
- CTGeneralTree with: (CTBinaryNode with: 3) >>> 'a CTGenerlaTree'
- CTGeneralTree binaryTree sizeOfTree >>> '5'
- CTGeneralTree binaryTree findDeepFirst: [ :n| n data == 4] 

 
Internal Representation and Key Implementation Points.

    Instance Variables
	root:		<Object>


Note from Stephane Ducasse: 
This design with a root looks super strange. 
Why a tree would have a pointer to the root?

root
	""root represents state of a Tree,it can be either CTNullNode for empty tree or CTBinaryNode for non-empty tree. Value of root can be changed by addNode and remove methods""
	
	^ root


"
Class {
	#name : #CTGeneralTree,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#category : #'Containers-NewTrees'
}

{ #category : #examples }
CTGeneralTree class >> binaryTree [
	<sampleInstance>
	| aTree |
	aTree := CTGeneralTree with: (CTBinaryNode with: 1).
	aTree root leftChild: (CTBinaryNode with: 2).
	aTree root rightChild: (CTBinaryNode with: 3).
	aTree root leftChild leftChild: (CTBinaryNode with: 4).
	aTree root leftChild rightChild: (CTBinaryNode with: 5).
	^ aTree
]

{ #category : #examples }
CTGeneralTree class >> emptyTree [
	<sampleInstance>
	| aTree |
	aTree := CTGeneralTree new.
	^ aTree
]

{ #category : #'instance creation' }
CTGeneralTree class >> with: aNode [
	
	^ self new 
	  root: aNode
]

{ #category : #'adding/removing' }
CTGeneralTree >> addNode: aData [
	"Add node to a tree and set root to binary node if it was null node before"

	root := self root addNode: aData
]

{ #category : #operations }
CTGeneralTree >> depth [
	"Answer depth of a tree"
	
	^ root depth

	
]

{ #category : #traversing }
CTGeneralTree >> findBreadthFirst: aBlock [
	"Answer a node specified in a block. Lookup is done in level order "
	
	^ self root findBreadthFirst: aBlock 
]

{ #category : #traversing }
CTGeneralTree >> findDeepFirst: aBlock [
	"Answer a node specified in a block. Lookup is done in depth first search manner"
	
	^ self root findDeepFirst: aBlock
]

{ #category : #traversing }
CTGeneralTree >> inOrderDo: aBlock [
	"Post-order traversing starting from root and executing a block on each node"
	
	^ self root inOrderDo: aBlock
		

]

{ #category : #initialize }
CTGeneralTree >> initialize [ 

	super initialize.
	self root: CTNullNode uniqueInstance.
]

{ #category : #traversing }
CTGeneralTree >> postOrderDo: aBlock [
	"Post-order traversing starting from a root and executing a block on each node"
	
	^ self root postOrderDo: aBlock
		

]

{ #category : #traversing }
CTGeneralTree >> preOrderDo: aBlock [
	"Pre-order traversing starting from a root and executing a block on each node"
	
	^ self root preOrderDo: aBlock
		

]

{ #category : #'adding/removing' }
CTGeneralTree >> removeNode: aData [
	"Remove a node with specified data and change root of tree from binary node to null node if there is only one node in a tree"

	root := self root remove: aData
]

{ #category : #accessing }
CTGeneralTree >> root [
	"root represents state of a Tree,it can be either CTNullNode for empty tree or CTBinaryNode for non-empty tree. Value of root can be changed by addNode and remove methods"
	
	^ root
]

{ #category : #accessing }
CTGeneralTree >> root: aNode [
	
	root := aNode
]

{ #category : #operations }
CTGeneralTree >> sizeOfTree [
	"Ansert number of nodes in a tree"
	
	^ self root sizeOfTree
]
