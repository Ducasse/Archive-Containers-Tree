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

	^ CTBinarySearchTree with: aData
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
	^ aNode
]

{ #category : #'adding/removing' }
CTNullBinaryTree >> remove: aData [

	^ self
]
