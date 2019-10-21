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

{ #category : #'test - working on that one' }
CTSimpleTreeTest >> testAccessObject [
	"A tree is composed of an object (kind of node value) and children"
	
	self assert: newTreeNode object equals: 'node'
	
]

{ #category : #'test - working on that one' }
CTSimpleTreeTest >> testAccessParent [
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

{ #category : #'test accessing' }
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

{ #category : #'test adding' }
CTSimpleTreeTest >> testAddChildrenSet [
	"test addChildrenSet: aaTreeNodeSet"
	| aSet |
	aSet := Set new.
	aSet add: sub1; add: sub2.
	newTreeNode addChildren: aSet.
	self assert: sub1 parent equals: newTreeNode.
	self assert: sub2 parent equals: newTreeNode.
	self assert: newTreeNode children size equals: 2



	

	
	
]

{ #category : #'test - working on that one' }
CTSimpleTreeTest >> testBasicCreation [
	"Verify that a treeNode parent access methods"

	self assert: sub1 parent isNil.  
	self assert: sub1 hasNoChildren
]

{ #category : #'test removing' }
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

{ #category : #'test accessing' }
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

{ #category : #'test adding' }
CTSimpleTreeTest >> testCreateNewInstance [
	"test - TreeNode for: anObject. Create a new TreeNode instance."

	| aTreeNode root |
	aTreeNode := self treeClass for: 'node'.
	self assert: aTreeNode object equals: 'node'.
	self assert: aTreeNode parent isNil.
	self assert: aTreeNode hasNoChildren.
	self assert: aTreeNode children isEmpty.
	root := self treeClass new.
	root object: 'node'.
	self assert: root object equals: aTreeNode object
]

{ #category : #'test - working on that one' }
CTSimpleTreeTest >> testCreation [
	"Verify that a treeNode parent access methods"

	self treeClass for: 'subnode1'.
	self deny: newTreeNode hasParent.
	self assert: newTreeNode hasNoParent.
	self deny: newTreeNode hasChildren.
	self assert: newTreeNode hasNoChildren
]

{ #category : #'test accessing' }
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

{ #category : #'test - working on that one' }
CTSimpleTreeTest >> testObjectEquality [
	"A tree is composed of an object (kind of node value) and children"

	self assert: newTreeNode object equals: newTreeNode object.
	self
		deny: (self treeClass new object: #node) equals: (self treeClass for: #node)
	"this is normal since was not overloaded."
]

{ #category : #'test removing' }
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

{ #category : #'test accessing' }
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
