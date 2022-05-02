"
I represent a binary tree. 

I am implemented as a composite design pattern consisting of binary nodes. I provide behavior for nodes that are not empty like: traversing, finding, adding and removing.

I collaborate with CTGeneralTree and provide one of the states for the root.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	data:		<Object>
	leftChild:		<Object>
	rightChild:		<Object>


"
Class {
	#name : #CTBinaryNode,
	#superclass : #CTAbstractTreeNode,
	#instVars : [
		'leftChild',
		'rightChild',
		'data'
	],
	#category : #'Containers-NewTrees'
}

{ #category : #'instance creation' }
CTBinaryNode class >> with: anObject [

	^ self new
	  data: anObject
]

{ #category : #'adding/removing' }
CTBinaryNode >> addNode: aData [
	"Add node in level order making a tree balanced. Modify receiver to contain entire tree with a node added."

	| aParent added |
	added := false.
	aParent := self findBreadthFirst: [ :n | n leftChild isNullNode | n rightChild isNullNode ].
	aParent leftChild isNullNode
		ifTrue: [  aParent leftChild: (CTBinaryNode with: aData). added := true ].
	aParent rightChild isNullNode & added not
		ifTrue: [  aParent rightChild: (CTBinaryNode with: aData) ].
	
	 
	
	
	
]

{ #category : #accessing }
CTBinaryNode >> data [ 

	^ data
]

{ #category : #accessing }
CTBinaryNode >> data: anObject [

	data := anObject
]

{ #category : #accessing }
CTBinaryNode >> deepestRightmostNode [
	"Answer node that is deepest right child node"

	| queue node |
	
	queue := OrderedCollection new.
	queue addLast: self.

	[ queue isNotEmpty ]
		whileTrue: [ node := queue removeFirst.
			 node leftChild isNullNode
				ifFalse: [ queue addLast: node leftChild ].
			 node rightChild isNullNode
				ifFalse: [  queue addLast: node rightChild ]].
	^ node
]

{ #category : #operations }
CTBinaryNode >> depth [
	"Answer depth of a tree"

	^ self leftChild depth max: self rightChild  depth + 1
]

{ #category : #traversing }
CTBinaryNode >> findBreadthFirst: aBlock [
	"Answer a node that matches condition from passed block. The lookup is done in level order manner"
	
	| queue |	
	queue := OrderedCollection new.
	
	queue addLast: self.
	
	[ queue isNotEmpty ] whileTrue: [ 
		| node |
		node := queue removeFirst.
		
		node isNullNode
			ifTrue: [ ^ node ].
			
		(aBlock value: node )
			ifTrue: [^ node ].
			
		queue addLast: node leftChild.
		queue addLast: node rightChild ].
	

]

{ #category : #traversing }
CTBinaryNode >> findDeepFirst: aBlock [
	"Answer a node that matches condition specified in a block. The lookup is done in depth first search manner."
	
	| node |
	(aBlock value: self)
		ifTrue: [ ^ self ].

	node := self leftChild findDeepFirst: aBlock.

	(node isNullNode)
		ifTrue: [ node := self rightChild findDeepFirst: aBlock ].
		
	^ node

]

{ #category : #traversing }
CTBinaryNode >> inOrderDo: aBlock [
	"In-order traversing  executing a block on each node"

	self leftChild inOrderDo: aBlock.
	aBlock value: self.
	self rightChild inOrderDo: aBlock.
	
]

{ #category : #initialize }
CTBinaryNode >> initialize [

	super initialize.
	leftChild := CTNullNode uniqueInstance.
	rightChild := CTNullNode uniqueInstance.

	
]

{ #category : #testing }
CTBinaryNode >> isLeaf [

	^ self leftChild isNullNode & self rightChild isNullNode
]

{ #category : #testing }
CTBinaryNode >> isNullNode [
	
	^ false
]

{ #category : #accessing }
CTBinaryNode >> leftChild [
	
	^ leftChild
]

{ #category : #accessing }
CTBinaryNode >> leftChild: aNode [
	"comment stating purpose of message"

	leftChild := aNode
]

{ #category : #traversing }
CTBinaryNode >> postOrderDo: aBlock [
	"Post-order traversing  executing a block on each node"

	self leftChild postOrderDo: aBlock.
	self rightChild postOrderDo: aBlock.
	aBlock value: self.
]

{ #category : #traversing }
CTBinaryNode >> preOrderDo: aBlock [
	"Pre-order traversing  executing a block on each node"

	aBlock value: self.
	self leftChild preOrderDo: aBlock.
	self rightChild preOrderDo: aBlock.
	
]

{ #category : #'adding/removing' }
CTBinaryNode >> remove: aData [
	"Remove a node with passed data. If there are more nodes with same data, only the first such node found using level order traversing will be deleted "
	| node |
	
	self size == 1
		ifTrue: [ ^ CTNullNode uniqueInstance ].
		
	node := self findBreadthFirst: [ :n | n data == aData ].
	node isNullNode
		ifTrue: [ ^ self ].

	node isLeaf
		ifTrue: [ ^ self removeLeafNode: node ].
		
	node data: self deepestRightmostNode data.
	self removeDeepestRightmostNode
]

{ #category : #'adding/removing' }
CTBinaryNode >> removeDeepestRightmostNode [

	| node |
	
	node:= self findBreadthFirst: [ :n | n rightChild == self deepestRightmostNode].
	node rightChild: CTNullNode uniqueInstance.

	
]

{ #category : #'adding/removing' }
CTBinaryNode >> removeLeafNode: aNode [

	| parent |

	parent := self findBreadthFirst: [ :n | n leftChild == aNode or: n rightChild == aNode ].
		
	parent leftChild == aNode
		ifTrue: [ parent leftChild: CTNullNode uniqueInstance ]
		ifFalse: [ parent rightChild: CTNullNode uniqueInstance ].
			
]

{ #category : #accessing }
CTBinaryNode >> rightChild [
	
	^ rightChild
]

{ #category : #accessing }
CTBinaryNode >> rightChild: aNode [
	
	rightChild := aNode
]

{ #category : #operations }
CTBinaryNode >> size [
	"Answer number of nodes in a tree"

	^ 1 + leftChild size + rightChild size 
	
]
