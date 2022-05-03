"
I represent Null object pattern for binary search tree. 

I am singleton. My responsibilities are to provide default behavior for an empty binary search tree node. I usally respond with returning self, nil or 0.

I answer a CTBinarySearchTree when the `add:` method is called.


"
Class {
	#name : #CTNullBinarySearchNode,
	#superclass : #CTAbstractBinarySearchTree,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Containers-SearchTrees'
}

{ #category : #accessing }
CTNullBinarySearchNode class >> uniqueInstance [ 
	uniqueInstance ifNil: [ uniqueInstance := self new ].
	^ uniqueInstance 
]

{ #category : #'adding/removing' }
CTNullBinarySearchNode >> add: aData [
	"Answer a binary search tree with passed data"

	^ CTBinarySearchTree with: aData
]

{ #category : #'adding/removing' }
CTNullBinarySearchNode >> addNode: aNode [
	"Answer a binary search tree with passed data"

	^ aNode
]

{ #category : #operations }
CTNullBinarySearchNode >> depth [ 

	^ 0
]

{ #category : #traversing }
CTNullBinarySearchNode >> findBreadthFirst: aBlock [

	^ self
]

{ #category : #traversing }
CTNullBinarySearchNode >> findDeepFirst: aBlock [

	^ self
]

{ #category : #lookup }
CTNullBinarySearchNode >> findNode: aData [

	^ self
]

{ #category : #operations }
CTNullBinarySearchNode >> height [ 

	^ -1
]

{ #category : #traversing }
CTNullBinarySearchNode >> inOrderDo: aBlock [

	^ nil
]

{ #category : #testing }
CTNullBinarySearchNode >> isLeaf [

	^ false
]

{ #category : #testing }
CTNullBinarySearchNode >> isNullNode [

	^ true
]

{ #category : #accessing }
CTNullBinarySearchNode >> leftmostNode: aNode [
	"Answer passed node"
	^ aNode
]

{ #category : #operations }
CTNullBinarySearchNode >> maximumValue [

	^ nil
]

{ #category : #operations }
CTNullBinarySearchNode >> minimumValue [

	^ nil
]

{ #category : #traversing }
CTNullBinarySearchNode >> postOrderDo: aBlock [

	^ nil
]

{ #category : #traversing }
CTNullBinarySearchNode >> preOrderDo: aBlock [

	^ nil
]

{ #category : #'adding/removing' }
CTNullBinarySearchNode >> remove: aData [

	^ self
]

{ #category : #accessing }
CTNullBinarySearchNode >> rightmostNode: aNode [
	"Answer passed node"
	
	^ aNode
]

{ #category : #operations }
CTNullBinarySearchNode >> size [

	^ 0
]
