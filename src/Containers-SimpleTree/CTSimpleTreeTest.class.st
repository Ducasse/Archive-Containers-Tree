"
A TreeNodeTest is a test class for testing the behavior of TreeNode

	TreeNode is a recursive defintion for a node object in a tree.
	As a root node, it's parent is nil.
	If a node has no child, children is nil or empty collection.
		
Instance Variables:
	parent	<TreeNode>  parent of this node in the tree.
	children	<OrderedCollection>   containing the children of this node.
	object	<Object>  an object which is at this node position in the tree.
"
Class {
	#name : #CTSimpleTreeTest,
	#superclass : #TestCase,
	#instVars : [
		'newTreeNode',
		'sub1',
		'sub2'
	],
	#category : #'Containers-SimpleTree'
}

{ #category : #running }
CTSimpleTreeTest >> setUp [
	super setUp.
	newTreeNode := self treeClass for: 'node'.
	sub1 := self treeClass for: 'subnode1'.
	sub2 := self treeClass for: 'subnode2'
]

{ #category : #'test - accessing' }
CTSimpleTreeTest >> testAccessObject [
	"A tree is composed of an object (kind of node value) and children"
	
	self assert: newTreeNode object equals: 'node'
	
]

{ #category : #'test - children' }
CTSimpleTreeTest >> testAddChildNode [
	
	| collection  |
	self assert: newTreeNode hasNoChildren.
	newTreeNode addChildNode: sub1.
	newTreeNode addChildNode: sub2.
	collection := OrderedCollection new.	
	collection add: sub1; add: sub2.
	self assert: newTreeNode children equals: collection.
	self assert: sub1 parent equals: newTreeNode.


]

{ #category : #'test - adding' }
CTSimpleTreeTest >> testAddChildrenSet [
	"test addChildrenSet: aTreeNodeSet"
	
	| aSet |
	aSet := Set new.
	aSet add: sub1; add: sub2.
	newTreeNode addChildren: aSet.
	self assert: sub1 parent equals: newTreeNode.
	self assert: sub2 parent equals: newTreeNode.
	self assert: newTreeNode children size equals: 2



	

	
	
]

{ #category : #'test - basic node' }
CTSimpleTreeTest >> testAddingAChildSetTheParentLink [
	"Verify that a treeNode parent access methods"

	sub1 parent: newTreeNode.
	newTreeNode children add: sub1.
	
	self assert: newTreeNode hasNoParent.  "root's parent is nil"
	self assert: sub1 parent equals: newTreeNode.
	
	newTreeNode := self treeClass for: 'node'.
	newTreeNode addChildNode: sub1. 		"add child and auto assign me as its parent "
	
	self assert: newTreeNode hasNoParent.
	self assert: sub1 parent equals: newTreeNode
]

{ #category : #'test - basic node' }
CTSimpleTreeTest >> testBasicNodeDoesNotHaveParentOrChildren [
	"Verify that a single node does not have parent or children before being added to a tree."

	self assert: sub1 parent isNil.  
	self assert: sub1 hasNoChildren
]

{ #category : #'test - adding' }
CTSimpleTreeTest >> testBeChildless [

	self assert: newTreeNode children isEmpty.
	newTreeNode addChildNode: sub1.
	sub1 addChildNode: sub2.
	self assert: newTreeNode children size equals: 1.
	self assert: sub1 children size equals: 1.
	sub1 beChildless.
	self assert: sub1 children size isZero.
	self assert: newTreeNode children size equals: 1
	
]

{ #category : #'test - children' }
CTSimpleTreeTest >> testChildren [
	"test a treeNode has children?" 
	"Answers an <OrderedCollection> of the child nodes or empty collection"
	
	| collection |
	self assert: newTreeNode hasNoChildren.
	newTreeNode addChildNode: sub1.
	newTreeNode addChildNode: sub2.
	collection := OrderedCollection new.	
	collection add: sub1; add: sub2.
	self assert: newTreeNode children equals: collection
	
]

{ #category : #'test - traversal' }
CTSimpleTreeTest >> testCountNodes [

	self assert: CTSimpleTree example count equals: 8
	
]

{ #category : #'test - basic node' }
CTSimpleTreeTest >> testCreateNewInstance [
	"test - for: anObject. Create a new simple tree instance."

	| aTreeNode |
	aTreeNode := self treeClass for: 'node'.
	self assert: aTreeNode object equals: 'node'.
	self assert: aTreeNode parent isNil.
	self assert: aTreeNode hasNoChildren.
	self assert: aTreeNode children isEmpty.

]

{ #category : #'test - accessing' }
CTSimpleTreeTest >> testDegree [
	"new method added"

	| sub3 |
	newTreeNode addChildNode: sub1.
	sub1 addChildNode: sub2.
	sub3 := sub2 addChildNode: (self treeClass for: 'subnode3').
	self assert: newTreeNode degree equals: 0.
	self assert: sub1 degree equals: 1.
	self assert: sub2 degree equals: 2.
	self assert: sub3 degree equals: 3
]

{ #category : #'test - traversal' }
CTSimpleTreeTest >> testNodesDo [

	| res |
	res := 0. 
	CTSimpleTree example nodesDo: [ :each | res := res + 1 ].
	self assert: res equals: 8
	
]

{ #category : #'test - basic node' }
CTSimpleTreeTest >> testObjectEquality [
	"A tree is composed of an object (kind of node value) and children"

	self 
		assert: newTreeNode object 
		equals: newTreeNode object.
	self
		deny: (self treeClass new object: #node) 
		equals: (self treeClass for: #node)
	
]

{ #category : #'test - adding' }
CTSimpleTreeTest >> testRemoveChildNode [
	"test - aTreeNoe removeChildNode: aTreeNode "

	| tree1 tree3 |
	tree1 := newTreeNode addChildNode: (self treeClass for: 'subnode1').
	newTreeNode addChildNode: (self treeClass for: 'subnode2').
	self assert: newTreeNode children size equals: 2.
	tree3 := newTreeNode removeChildNode: tree1 ifAbsent: [  ].
	self assert: tree3 equals: tree1.
	self assert: newTreeNode children size equals: 1
]

{ #category : #'test - children' }
CTSimpleTreeTest >> testSetChildrenShouldSetParent [
	"test- treeNode children: anOrderedCollection"
	
	| collection|
	newTreeNode children: OrderedCollection new.
	self assert: newTreeNode hasNoChildren.
	collection := OrderedCollection new.
	collection add: sub1; add: sub2.
	newTreeNode children: collection.
	self assert: sub1 parent equals: newTreeNode.
	self assert: sub2 parent equals: newTreeNode.
	self assert: newTreeNode children equals: collection

]

{ #category : #running }
CTSimpleTreeTest >> treeClass [
	^ CTSimpleTree
]
