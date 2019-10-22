Class {
	#name : #CTBinarySearchTree2,
	#superclass : #CTAbstractBinarySearchTree,
	#instVars : [
		'leftChild',
		'rightChild',
		'data'
	],
	#category : #'Containers-SearchTrees'
}

{ #category : #examples }
CTBinarySearchTree2 class >> binarySearchTree [
	<sampleInstance>
	| aTree |
	aTree := CTBinarySearchTree with: 8.
	aTree add: 3.
	aTree add: 10.
	aTree add: 1.
	aTree add: 6.
	^ aTree
]

{ #category : #'instance creation' }
CTBinarySearchTree2 class >> with: anObject [

	^ self new
	  data: anObject
]

{ #category : #'adding/removing' }
CTBinarySearchTree2 >> add: aData [
	"add node with data to receiver"
	data isNil 
		ifTrue: [ data := aData ].

	aData < data  
		ifTrue: [  leftChild := leftChild add: aData ].
	aData > data
		ifTrue: [ rightChild := rightChild add: aData ].
]

{ #category : #'adding/removing' }
CTBinarySearchTree2 >> addNode: aNode [
	"Add node to receiver"
	
	data isNil 
		ifTrue: [ data := aNode data ].
		
	aNode data < data
		ifTrue: [ leftChild := leftChild addNode: aNode ].
	aNode data > data
		ifTrue: [ rightChild := rightChild addNode: aNode ].
]

{ #category : #accessing }
CTBinarySearchTree2 >> data [
	^ data
]

{ #category : #accessing }
CTBinarySearchTree2 >> data: newData [
	data := newData 
]

{ #category : #operations }
CTBinarySearchTree2 >> depth [
	"Answer depth of a tree"

	^ self leftChild depth max: self rightChild  depth + 1
]

{ #category : #traversing }
CTBinarySearchTree2 >> findBreadthFirst: aBlock [
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
CTBinarySearchTree2 >> findDeepFirst: aBlock [
	"Answer a node that matches condition specified in a block. The lookup is done in depth first search manner."
	
	| node |
	(aBlock value: self)
		ifTrue: [ ^ self ].

	node := self leftChild findDeepFirst: aBlock.

	(node isNullNode)
		ifTrue: [ node := self rightChild findDeepFirst: aBlock ].
		
	^ node

]

{ #category : #lookup }
CTBinarySearchTree2 >> findNode: aData [
	"Answer a node with aData if it exists"

	aData == data   
		ifTrue: [ ^ self ].
	aData < data  
		ifTrue: [ ^ (leftChild findNode: aData) ].
	aData > data   
		ifTrue: [ ^ (rightChild findNode: aData) ].

]

{ #category : #testing }
CTBinarySearchTree2 >> hasBothChildren [
	
	^ self isLeaf not
]

{ #category : #testing }
CTBinarySearchTree2 >> hasOnlyLeftChild [

	^ self rightChild isNullNode & self leftChild isNullNode not 
]

{ #category : #testing }
CTBinarySearchTree2 >> hasOnlyRightChild [

	^ leftChild isNullNode & rightChild isNullNode not
]

{ #category : #traversing }
CTBinarySearchTree2 >> inOrderDo: aBlock [
	"In-order traversing  executing a block on each node"

	self leftChild inOrderDo: aBlock.
	aBlock value: self.
	self rightChild inOrderDo: aBlock.
	
]

{ #category : #initialize }
CTBinarySearchTree2 >> initialize [

	super initialize.
	leftChild := CTNullBinaryTree uniqueInstance.
	rightChild := CTNullBinaryTree uniqueInstance.
]

{ #category : #testing }
CTBinarySearchTree2 >> isLeaf [

	^ leftChild isNullNode & rightChild isNullNode
]

{ #category : #testing }
CTBinarySearchTree2 >> isNullNode [

	^ false
]

{ #category : #accessing }
CTBinarySearchTree2 >> leftChild [

	^ leftChild
]

{ #category : #private }
CTBinarySearchTree2 >> leftChild: aNode [

	leftChild := aNode
]

{ #category : #accessing }
CTBinarySearchTree2 >> leftmostNode: aNode [
	"answer deepest left node"
	
	^ leftChild leftmostNode: self
]

{ #category : #operations }
CTBinarySearchTree2 >> maximumValue [
	"Answer biggest data value held in a tree"

	^ (self rightmostNode: self) data
]

{ #category : #operations }
CTBinarySearchTree2 >> minimumValue [
	"Answer smallest data value held in tree"

	^ (self leftmostNode: self) data
]

{ #category : #traversing }
CTBinarySearchTree2 >> postOrderDo: aBlock [
	"Post-order traversing  executing a block on each node"

	self leftChild postOrderDo: aBlock.
	self rightChild postOrderDo: aBlock.
	aBlock value: self.
]

{ #category : #traversing }
CTBinarySearchTree2 >> preOrderDo: aBlock [
	"Pre-order traversing  executing a block on each node"

	aBlock value: self.
	self leftChild preOrderDo: aBlock.
	self rightChild preOrderDo: aBlock.
	
]

{ #category : #'adding/removing' }
CTBinarySearchTree2 >> remove: aData [
	"remove a node with passed data from the reciever"
	
	| smallestNodeInRightSubtree |
	aData < data
		ifTrue: [ leftChild := leftChild remove: aData ].
	aData > data
		ifTrue: [ rightChild := rightChild remove: aData ].
		
	aData == data
		ifFalse: [ ^ self ].
		
	self isLeaf
		ifTrue: [ ^ CTNullBinaryTree uniqueInstance ].
		
	self hasOnlyLeftChild 
		ifTrue: [ ^ leftChild ].
	self hasOnlyLeftChild
		ifTrue: [ ^ rightChild ].
		
	self hasBothChildren
		ifFalse: [ ^ self ].
		
	smallestNodeInRightSubtree := rightChild leftmostNode: self.
	data := smallestNodeInRightSubtree data.
	rightChild := rightChild remove: smallestNodeInRightSubtree data
]

{ #category : #accessing }
CTBinarySearchTree2 >> rightChild [

	^ rightChild
]

{ #category : #private }
CTBinarySearchTree2 >> rightChild: aNode [

	rightChild := aNode
]

{ #category : #accessing }
CTBinarySearchTree2 >> rightmostNode: aNode [
	"answer deepest right node"

	^ rightChild rightmostNode: self
]

{ #category : #operations }
CTBinarySearchTree2 >> sizeOfTree [
	"Answer number of nodes in a tree"

	^ 1 + leftChild sizeOfTree + rightChild sizeOfTree 
]
