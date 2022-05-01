"
A simpleTree is a tree with a list of children, a parent link and a value.
The current implementation does not offer iteration over the structure.

SimpleTree is a recursive definition for a node object in a tree.
As a root node, its parent is nil.
If a node has no children, children is nil or empty collection.
		

Instance Variables:
	parent	<TreeNode>  parent of this node in the tree.
	children	<OrderedCollection>   containing the children of this node.
	object	<Object>  an object which is at this node position in the tree.
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

{ #category : #examples }
CTSimpleTree class >> example [
	<sampleInstance>
	
	| root subroots | 
	root := self for: 5.
	subroots := { (self for: 3) children: { self for: 1 . self for: 2 . self for: 4 } ; yourself . 
							(self for: 7) children: { self for: 6 . self for: 8 } ; yourself } .
	root children: subroots.
	^ root
]

{ #category : #'instance creation' }
CTSimpleTree class >> for: anObject [
	"Return a new tree whose object is anObject and no children."
	
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

{ #category : #traversal }
CTSimpleTree >> count [
	| res | 
	res := 0.
	self nodesDo: [ :each | res := res + 1 ].
	^ res
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

{ #category : #traversal }
CTSimpleTree >> nodesDo: aBlock [ 
	"Apply the argument to the root and its children recursively in a preorder way."
	
	aBlock value: self. 
	self children do: [ :each | each nodesDo: aBlock ]
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
