"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

I represent Null object pattern for binary search tree. 

I am singleton. My responsibilities are to provide default behavior for an empty binary search tree node. I usally respond with returning self, nil or 0.

I answer a CTBinarySearchTree when add method is called.


"
Class {
	#name : #CTNullBinaryTree,
	#superclass : #CTAbstractBinarySearchTree,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Containers-SearchTrees'
}

{ #category : #accessing }
CTNullBinaryTree class >> uniqueInstance [ 
	uniqueInstance ifNil: [ uniqueInstance := self new ].
	^ uniqueInstance 
]

{ #category : #'adding/removing' }
CTNullBinaryTree >> add: aData [
	"Answer a binary search tree with passed data"

	^ CTBinarySearchTree with: aData
]

{ #category : #operations }
CTNullBinaryTree >> depth [ 

	^ 0
]

{ #category : #traversing }
CTNullBinaryTree >> findBreadthFirst: aBlock [

	^ self
]

{ #category : #traversing }
CTNullBinaryTree >> findDeepFirst: aBlock [

	^ self
]

{ #category : #lookup }
CTNullBinaryTree >> findNode: aData [

	^ self
]

{ #category : #traversing }
CTNullBinaryTree >> inOrderDo: aBlock [

	^ nil
]

{ #category : #testing }
CTNullBinaryTree >> isLeaf [

	^ false
]

{ #category : #testing }
CTNullBinaryTree >> isNullNode [

	^ true
]

{ #category : #accessing }
CTNullBinaryTree >> leftmostNode: aNode [
	"Answer passed node"
	^ aNode
]

{ #category : #operations }
CTNullBinaryTree >> maximumValue [

	^ nil
]

{ #category : #operations }
CTNullBinaryTree >> minimumValue [

	^ nil
]

{ #category : #traversing }
CTNullBinaryTree >> postOrderDo: aBlock [

	^ nil
]

{ #category : #traversing }
CTNullBinaryTree >> preOrderDo: aBlock [

	^ nil
]

{ #category : #'adding/removing' }
CTNullBinaryTree >> remove: aData [

	^ self
]

{ #category : #accessing }
CTNullBinaryTree >> rightmostNode: aNode [
	"Answer passed node"
	
	^ aNode
]

{ #category : #operations }
CTNullBinaryTree >> sizeOfTree [

	^ 0
]
