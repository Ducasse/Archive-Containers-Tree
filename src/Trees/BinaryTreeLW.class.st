"
A BinaryTreeLW is a concrete class defined for pedagogic purposes as a tree whose branch nodes have two subtrees and whose leaf nodes have none. It provides an example of how to define a TreeLW subclass that lacks a subTrees variable.

Another implementation technique would be to define a new collection class that holds the two nodes. However, that would take 20 bytes more per node for ST80 4.1 than the technique used here.
 
If one wished to use less memory than the current technique, one could define separate classes for branches and leaves. Leaves would not have 'left' or 'right' instance variables. However, that would make it harder to design subclasses of binary trees.

BinaryTreeLW is a subclass of VTreeLW. If one wanted to define a binary tree that maintained a superTree pointer, it would be a subclass of PVTreeLW. The superclass would maintain the pointer automatically and no extra code would be required in BinaryTreeLW. See the left:right: method for further comments.

A BTree or BalancedTree could be defined in a manner similar to BinaryTreeLW.

Instance Variables

(value)			<Object (not nil)>	(Inherited): The object stored at a node.
left				<TreeLW | nil>		The left subtree for a branch node; nil for a leaf node.
right			<TreeLW | nil>		The right subtree for a branch node; nil for a leaf node.
"
Class {
	#name : #BinaryTreeLW,
	#superclass : #VTreeLW,
	#instVars : [
		'left',
		'right'
	],
	#category : #'Trees-Main'
}

{ #category : #examples }
BinaryTreeLW class >> example [
	"Return a sample tree with five nodes."

	"self example"

	| t1 t2 t3 t4 t5 |
	t1 := self value: 1.
	t2 := self value: 2.
	t3 := self value: 3.
	t4 := self value: 4.
	t5 := self value: 5.
	t1 left: t2 right: t5.
	t2 left: t3 right: t4.
	^t1
]

{ #category : #'instance creation' }
BinaryTreeLW class >> left: tree1 right: tree2 [ 
	"Create and return a new instance with the specified subtrees. A leaf node is 
	created with BinaryTreeLW new."

	^self new left: tree1 right: tree2
]

{ #category : #'private accessing' }
BinaryTreeLW >> basicSubTrees [
	"Return an array containing the subtrees."

	^self isLeaf
		ifTrue: [Array new]
		ifFalse: [Array with: self left with: self right]
]

{ #category : #'private accessing' }
BinaryTreeLW >> basicSubTrees: seqColl [ 
	"Set the left and right nodes from seqColl, assuming it is a sequenceable 
	collection of zero or two trees. Return the receiver."

	seqColl isEmpty
		ifTrue: 
			[left := nil.
			right := nil]
		ifFalse: 
			[left := seqColl first.
			right := seqColl second]
]

{ #category : #'private initializing' }
BinaryTreeLW >> defaultSubTrees [
	"Return the default value for initializing the subTrees."

	^Array new
]

{ #category : #'testing misc' }
BinaryTreeLW >> isLeaf [
	"Return a boolean indicating whether the receiver is a leaf node. 
	
	Implementation note: we do not need to test the right node because either both 
	are trees or both are nil."

	^self left isNil
]

{ #category : #'accessing simple' }
BinaryTreeLW >> left [
	"Return the left node if the receiver is a branch or nil if it is a leaf."

	^left
]

{ #category : #'accessing simple' }
BinaryTreeLW >> left: tree1 right: tree2 [ 
	"Set the two nodes and return the receiver. To make the receiver a leaf node, 
	use subTrees: Array new. 
	
	Implementation note: this is based on the subTrees: method to take advantage 
	of that method's argument validation. If BinaryTreeLW had been defined as a 
	subclass of PVTreeLW, using subTrees: would also take advantage of its 
	automatic management of the superTree pointer."

	self subTrees: (Array with: tree1 with: tree2)
]

{ #category : #'accessing simple' }
BinaryTreeLW >> right [
	"Return the right node if the receiver is a branch or nil if it is a leaf."

	^right
]

{ #category : #'private printing' }
BinaryTreeLW >> validateSubTreesCollection: aCollection [ 
	"Raise an exception if aCollection is invalid. It must be empty or contain exactly 
	two compatible trees."

	| size |
	super validateSubTreesCollection: aCollection.
	((size := aCollection size) = 0 or: [size = 2])
		ifFalse: [self class badSubTreesSignal ]
]
