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
	^ aNode
]

{ #category : #operations }
CTNullBinaryTree >> sizeOfTree [

	^ 0
]
