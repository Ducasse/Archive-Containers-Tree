"
I represent binary search tree.

I keep my node data in sorted order. For each node data in left children is smaller  and data in right children is greater than the value in the given node. I implement API specified in CTAbstractBinarySearchTree: adding/removing nodes, traversing, finding nodes and doing basic opeartions upon nodes.

Public API and Key Messages

- add: aData
- remove: aData
- findNode: aData
- CTBinarySearchTree with: 3 >>> 'a CTBinarySearchTree' 

   | aTree |
	aTree := CTBinarySearchTree binarySearchTree.
	aTree minimumValue >>> '1'.
	aTree maximumValue >>> '10'.
	aTree add: 11.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	data:		<Object>
	leftChild:		<Object>
	rightChild:		<Object>

"
Class {
	#name : #CTBinarySearchTree,
	#superclass : #CTAbstractBinarySearchTree,
	#instVars : [
		'leftChild',
		'rightChild',
		'object'
	],
	#category : #'Containers-SearchTrees'
}

{ #category : #examples }
CTBinarySearchTree class >> sampleBinarySearchTree [
	<sampleInstance>
	
	| aTree |
	aTree := self with: 8.
	aTree add: 3.
	aTree add: 10.
	aTree add: 1.
	aTree add: 6.
	^ aTree
]

{ #category : #'instance creation' }
CTBinarySearchTree class >> with: anObject [

	^ self new
	  object: anObject
]

{ #category : #'adding/removing' }
CTBinarySearchTree >> add: aData [
	"add node with data to receiver"
	
	object isNil 
		ifTrue: [ object := aData ].
	aData < object  
		ifTrue: [  leftChild := leftChild add: aData ].
	aData > object
		ifTrue: [ rightChild := rightChild add: aData ].
]

{ #category : #'adding/removing' }
CTBinarySearchTree >> addNode: aNode [
	"Add aNode to receiver and return the receiver."
	
	object isNil 
		ifTrue: [ object := aNode object ].
	aNode object < object
		ifTrue: [ leftChild := leftChild addNode: aNode ].
	aNode object > object
		ifTrue: [ rightChild := rightChild addNode: aNode ].
	
]

{ #category : #operations }
CTBinarySearchTree >> depth [
	"Answer depth of a tree"

	^ (self leftChild depth max: self rightChild depth) + 1
]

{ #category : #traversing }
CTBinarySearchTree >> findBreadthFirst: aBlock [
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
CTBinarySearchTree >> findDeepFirst: aBlock [
	"Answer a node that matches condition specified in a block. The lookup is done in depth first search manner."
	
	| node |
	(aBlock value: self)
		ifTrue: [ ^ self ].
	node := self leftChild findDeepFirst: aBlock.
	node isNullNode
		ifTrue: [ node := self rightChild findDeepFirst: aBlock ].
		
	^ node

]

{ #category : #lookup }
CTBinarySearchTree >> findNode: aData [
	"Answer a node with aData if it exists"

	aData == object   
		ifTrue: [ ^ self ].
	aData < object  
		ifTrue: [ ^ leftChild findNode: aData ].
	aData > object   
		ifTrue: [ ^ rightChild findNode: aData ].

]

{ #category : #testing }
CTBinarySearchTree >> hasBothChildren [
	
	^ self isLeaf not
]

{ #category : #testing }
CTBinarySearchTree >> hasOnlyLeftChild [

	^ self rightChild isNullNode & self leftChild isNullNode not 
]

{ #category : #testing }
CTBinarySearchTree >> hasOnlyRightChild [

	^ leftChild isNullNode & rightChild isNullNode not
]

{ #category : #traversing }
CTBinarySearchTree >> inOrderDo: aBlock [
	"In-order traversing  executing a block on each node"

	self leftChild inOrderDo: aBlock.
	aBlock value: self.
	self rightChild inOrderDo: aBlock.
	
]

{ #category : #initialize }
CTBinarySearchTree >> initialize [

	super initialize.
	leftChild := CTNullBinarySearchNode uniqueInstance.
	rightChild := CTNullBinarySearchNode uniqueInstance.
]

{ #category : #testing }
CTBinarySearchTree >> isLeaf [

	^ leftChild isNullNode & rightChild isNullNode
]

{ #category : #testing }
CTBinarySearchTree >> isNullNode [

	^ false
]

{ #category : #accessing }
CTBinarySearchTree >> leftChild [

	^ leftChild
]

{ #category : #private }
CTBinarySearchTree >> leftChild: aNode [

	leftChild := aNode
]

{ #category : #accessing }
CTBinarySearchTree >> leftmostNode: aNode [
	"answer deepest left node"
	
	^ leftChild leftmostNode: self
]

{ #category : #operations }
CTBinarySearchTree >> maximumValue [
	"Answer biggest data value held in a tree"

	^ (self rightmostNode: self) object
]

{ #category : #operations }
CTBinarySearchTree >> minimumValue [
	"Answer smallest data value held in tree"

	^ (self leftmostNode: self) object
]

{ #category : #accessing }
CTBinarySearchTree >> object [
	^ object
]

{ #category : #accessing }
CTBinarySearchTree >> object: newData [
	object := newData 
]

{ #category : #traversing }
CTBinarySearchTree >> postOrderDo: aBlock [
	"Post-order traversing  executing a block on each node"

	self leftChild postOrderDo: aBlock.
	self rightChild postOrderDo: aBlock.
	aBlock value: self.
]

{ #category : #traversing }
CTBinarySearchTree >> preOrderDo: aBlock [
	"Pre-order traversing  executing a block on each node"

	aBlock value: self.
	self leftChild preOrderDo: aBlock.
	self rightChild preOrderDo: aBlock.
	
]

{ #category : #printing }
CTBinarySearchTree >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: '('.
	object ifNotNil: [ object printOn: aStream ].
	aStream nextPutAll: ')'.


]

{ #category : #'adding/removing' }
CTBinarySearchTree >> remove: aData [
	"remove a node with passed data from the reciever"
	
	| smallestNodeInRightSubtree |
	self flag: #looksStrange.
	aData < object
		ifTrue: [ leftChild := leftChild remove: aData ].
	aData > object
		ifTrue: [ rightChild := rightChild remove: aData ].
		
	aData == object
		ifFalse: [ ^ self ].
		
	self isLeaf
		ifTrue: [ ^ CTNullBinarySearchNode uniqueInstance ].
		
	self hasOnlyLeftChild 
		ifTrue: [ ^ leftChild ].
	self hasOnlyLeftChild
		ifTrue: [ ^ rightChild ].
		
	self hasBothChildren
		ifFalse: [ ^ self ].
		
	smallestNodeInRightSubtree := rightChild leftmostNode: self.
	object := smallestNodeInRightSubtree object.
	rightChild := rightChild remove: smallestNodeInRightSubtree object
]

{ #category : #accessing }
CTBinarySearchTree >> rightChild [

	^ rightChild
]

{ #category : #private }
CTBinarySearchTree >> rightChild: aNode [

	rightChild := aNode
]

{ #category : #accessing }
CTBinarySearchTree >> rightmostNode: aNode [
	"answer deepest right node"

	^ rightChild rightmostNode: self
]

{ #category : #operations }
CTBinarySearchTree >> size [
	"Answer number of nodes in a tree"

	^ 1 + leftChild size + rightChild size 
]
