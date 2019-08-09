"
I represent Null object pattern for binary node. I'm a singleton. 

My responsibilities are to provide default behavior for a an empty binary node. I usually respond with returning self, nil or 0.

I ansert a binary node if the addNode method is called.

For the Collaborators Part: 
I colaborate with CTGeneralTree and I am one of the possible states for the root node.


"
Class {
	#name : #CTNullNode,
	#superclass : #CTAbstractTreeNode,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Containers-NewTrees'
}

{ #category : #accessing }
CTNullNode class >> uniqueInstance [ 
	uniqueInstance ifNil: [ uniqueInstance := self new ].
	^ uniqueInstance 
]

{ #category : #'adding/removing' }
CTNullNode >> addNode: aData [ 
	"Answer a tree with binary node"

	^ CTBinaryNode with: aData

]

{ #category : #operations }
CTNullNode >> depth [ 

	^ 0
]

{ #category : #traversing }
CTNullNode >> findBreadthFirst: aBlock [

	^ self
]

{ #category : #traversing }
CTNullNode >> findDeepFirst: aBlock [

	^ self
]

{ #category : #traversing }
CTNullNode >> inOrderDo: aBlock [

	^ nil
]

{ #category : #testing }
CTNullNode >> isLeaf [

	^ false
]

{ #category : #testing }
CTNullNode >> isNullNode [

	^ true
]

{ #category : #traversing }
CTNullNode >> postOrderDo: aBlock [

	^ nil
]

{ #category : #traversing }
CTNullNode >> preOrderDo: aBlock [

	^ nil
]

{ #category : #'adding/removing' }
CTNullNode >> remove: aNode [ 

	^ self
]

{ #category : #operations }
CTNullNode >> sizeOfTree [

	^ 0
]
