Class {
	#name : #CTBinarySearchTree,
	#superclass : #CTAbstractBinarySearchTree,
	#instVars : [
		'leftChild',
		'rightChild',
		'data'
	],
	#category : #'Containers-SearchTrees'
}

{ #category : #examples }
CTBinarySearchTree class >> binarySearchTree [
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
CTBinarySearchTree class >> with: anObject [

	^ self new
	  data: anObject
]

{ #category : #'adding/removing' }
CTBinarySearchTree >> add: aData [

	data isNil 
		ifTrue: [ data := aData ].

	aData < data  
		ifTrue: [  leftChild := leftChild add: aData ].
	aData > data
		ifTrue: [ rightChild := rightChild add: aData ].
]

{ #category : #accessing }
CTBinarySearchTree >> data [
	^ data
]

{ #category : #accessing }
CTBinarySearchTree >> data: newData [
	data := newData 
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
]

{ #category : #initialize }
CTBinarySearchTree >> initialize [

	super initialize.
	leftChild := CTNullBinaryTree uniqueInstance.
	rightChild := CTNullBinaryTree uniqueInstance.
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

{ #category : #accessing }
CTBinarySearchTree >> leftmostNode: aNode [
	^ leftChild leftmostNode: self
]

{ #category : #'adding/removing' }
CTBinarySearchTree >> remove: aData [
	| smallestNodeInRightSubtree |
	
	aData < data
		ifTrue: [ leftChild := leftChild remove: aData ].
	aData > data
		ifTrue: [ rightChild := rightChild remove: aData ].
		
	aData == data
		ifFalse: [ ^ self ].
		
	self isLeaf
		ifTrue: [ ^ CTNullBinaryTree uniqueInstance ].
		
	 "leftChild isNullNode not & rightChild isNullNode"
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
CTBinarySearchTree >> rightChild [

	^rightChild
]
