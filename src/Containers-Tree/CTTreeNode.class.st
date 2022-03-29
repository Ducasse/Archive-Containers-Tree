"
TreeNode is a recursive definition for a node object in a tree.
As a root node, its parent is nil.
If a node has no children, children is nil or empty collection.
		
		
Instance Variables:
	parent	<TreeNode>  parent of this node in the tree.
	children	<OrderedCollection>   containing the children of this node.
	object	<Object>  an object which is at this node position in the tree.
		
Points to be discussed:
- iteration
- children should always be  a collection.
- when we add a collection as children the children: should do an iteration and set the parent. This is not the client responsibility to do it but an invariant of the class. 
- addChildren we should test that existing nodes are still there. 
"
Class {
	#name : #CTTreeNode,
	#superclass : #Object,
	#instVars : [
		'label',
		'parent',
		'children',
		'object'
	],
	#category : #'Containers-Tree'
}

{ #category : #'instance creation' }
CTTreeNode class >> for: anObject [
	"Return a new tree whose object is anObject and no children. 
	(a Tree is composed of an object and a set of children)."
	^ self new 
		object: anObject;
		yourself
]

{ #category : #'adding/removing' }
CTTreeNode >> addChildNode: aCTTreeNode [ 
	"Add a node in the receiver and return the added node. Set the parent of the added node to be the receiver."
	
	aCTTreeNode parent: self. 
	^ children add: aCTTreeNode 
]

{ #category : #'adding/removing' }
CTTreeNode >> addChildren: aCollectionOfNode [ 
	"Add the collection of nodes in the receiver and return the added node. Set the parent of each added node to be the receiver."
	
	aCollectionOfNode do: [ :each | self addChildNode: each ]
]

{ #category : #'adding/removing' }
CTTreeNode >> beChildless [

	self children do: [ :each | each noParent ].
	self initializeChildren

]

{ #category : #accessing }
CTTreeNode >> children [
	"Returns the children of a node. Return an empty collection when no children."
	
	^ children
]

{ #category : #accessing }
CTTreeNode >> children: aCollection [
	"Set aCollection as a collection of children of the receiver. Each child parent is the receiver."
	
	aCollection do: [ :child | child parent: self ].
	children := aCollection
]

{ #category : #accessing }
CTTreeNode >> degree [

	^ self hasNoParent
		ifTrue: [ 0 ]
		ifFalse: [ 1 + self parent degree ]
]

{ #category : #testing }
CTTreeNode >> hasChildren [

	^ children isEmpty not
]

{ #category : #testing }
CTTreeNode >> hasNoChildren [

	^ children isEmpty
]

{ #category : #testing }
CTTreeNode >> hasNoParent [

	^ parent isNil 
]

{ #category : #testing }
CTTreeNode >> hasParent [

	^ parent isNil not
]

{ #category : #initialize }
CTTreeNode >> initialize [

	super initialize.
	self initializeChildren.

]

{ #category : #initialize }
CTTreeNode >> initializeChildren [

	children := OrderedCollection new.

]

{ #category : #operation }
CTTreeNode >> noParent [

	parent := nil.
]

{ #category : #accessing }
CTTreeNode >> object [
	^ object
]

{ #category : #accessing }
CTTreeNode >> object: anObject [ 
	object := anObject
]

{ #category : #accessing }
CTTreeNode >> parent [
	^ parent
]

{ #category : #accessing }
CTTreeNode >> parent: aCTTreeNode [ 
	parent := aCTTreeNode
]

{ #category : #'adding/removing' }
CTTreeNode >> removeChildNode: aCTTreeNode ifAbsent: aBlock [
	"Remove a node in the receiver and return the added node. Unset the parent of the added node."
	
	aCTTreeNode noParent.
	^ children remove: aCTTreeNode ifAbsent: aBlock
]
