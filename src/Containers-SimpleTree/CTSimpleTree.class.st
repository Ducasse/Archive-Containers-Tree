"
A simpleTree is a tree with a list of children and a value.
The current implementation does not offer iteration over the structure.
"
Class {
	#name : #CTSimpleTree,
	#superclass : #Object,
	#instVars : [
		'label',
		'parent',
		'children',
		'object'
	],
	#category : #'Containers-SimpleTree'
}

{ #category : #'instance creation' }
CTSimpleTree class >> for: anObject [
	"Return a new tree whose object is anObject and no children. 
	(a Tree is composed of an object and a set of children)."
	^ self new 
		object: anObject;
		yourself
]

{ #category : #'adding/removing' }
CTSimpleTree >> addChildNode: aTreeNode [ 
	"Add a node in the receiver and return the added node. Set the parent of the added node to be the receiver."
	aTreeNode parent: self. 
	^ children add: aTreeNode 
]

{ #category : #'adding/removing' }
CTSimpleTree >> addChildren: aCollectionOfNode [ 
	"Add the collection of nodes in the receiver and return the added node. Set the parent of each added node to be the receiver."
	aCollectionOfNode do: [ :each | self addChildNode: each ]
]

{ #category : #'adding/removing' }
CTSimpleTree >> beChildless [
	"Reset the parent link to children and reset the children link from the receiver"
	
	self children do: [ :each | each noParent ].
	self initializeChildren

]

{ #category : #accessing }
CTSimpleTree >> children [
	"Returns the children of a node. Return an empty collection when no children."
	^ children
]

{ #category : #accessing }
CTSimpleTree >> children: aCollection [
	"Set aCollection as a collection of children of the receiver. Each child parent is the receiver."
	aCollection do: [ :child | child parent: self ].
	children := aCollection
]

{ #category : #accessing }
CTSimpleTree >> degree [
	^ self hasNoParent
		ifTrue: [ 0 ]
		ifFalse: [ 1 + self parent degree ]
]

{ #category : #testing }
CTSimpleTree >> hasChildren [
	^ children isEmpty not
]

{ #category : #testing }
CTSimpleTree >> hasNoChildren [
	^ children isEmpty
]

{ #category : #testing }
CTSimpleTree >> hasNoParent [
	^ parent isNil 
]

{ #category : #testing }
CTSimpleTree >> hasParent [
	^ parent isNil not
]

{ #category : #initialize }
CTSimpleTree >> initialize [
	super initialize.
	self initializeChildren

]

{ #category : #initialize }
CTSimpleTree >> initializeChildren [
	children := OrderedCollection new.

]

{ #category : #operation }
CTSimpleTree >> noParent [

	parent := nil
]

{ #category : #accessing }
CTSimpleTree >> object [
	^ object
]

{ #category : #accessing }
CTSimpleTree >> object: anObject [ 
	object := anObject
]

{ #category : #accessing }
CTSimpleTree >> parent [
	^ parent
]

{ #category : #accessing }
CTSimpleTree >> parent: aCTTreeNode [ 
	parent := aCTTreeNode
]

{ #category : #'adding/removing' }
CTSimpleTree >> removeChildNode: aCTTreeNode ifAbsent: aBlock [
	"Remove a node in the receiver and return the added node. Unset the parent of the added node."
	
	aCTTreeNode noParent.
	^ children remove: aCTTreeNode ifAbsent: aBlock
]
