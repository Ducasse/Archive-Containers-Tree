"
A TreeNodeTest is a test class for testing the behavior of TreeNode

	TreeNode is a recursive definition for a node object in a tree.
	As a root node, its parent is nil.
	If a node has no child, children is nil or empty collection.
		
Instance Variables:
	parent	<TreeNode>  parent of this node in the tree.
	children	<OrderedCollection>   containing the children of this node.
	object	<Object>  an object which is at this node position in the tree.
		
Why this class is a simple duplicate of SimpleTree?


"
Class {
	#name : #CTTreeNodeTest,
	#superclass : #TestCase,
	#instVars : [
		'newTreeNode',
		'sub1',
		'sub2'
	],
	#category : #'Containers-Tree'
}

{ #category : #running }
CTTreeNodeTest >> setUp [
	super setUp.
	newTreeNode :=  CTTreeNode for: 'node'.
	sub1 := CTTreeNode for: 'subnode1'.
	sub2 := CTTreeNode for: 'subnode2'.
]

{ #category : #'test - working on that one' }
CTTreeNodeTest >> testAccessObject [
	"A tree is composed of an object (kind of node value) and children"
	
	self assert: newTreeNode object equals: 'node'.
	
]

{ #category : #'test - working on that one' }
CTTreeNodeTest >> testAccessParent [
	"Verify that a treeNode parent access methods"

	sub1 parent: newTreeNode.
	newTreeNode children add: sub1.
	
	self assert: newTreeNode hasNoParent.
	self assert: sub1 parent equals: newTreeNode.
	
	newTreeNode := CTTreeNode for: 'node'.
	newTreeNode addChildNode: sub1. 		"add child and auto assign me as its parent "
	
	self assert: newTreeNode hasNoParent.
	self assert: sub1 parent equals: newTreeNode.
]

{ #category : #'test accessing' }
CTTreeNodeTest >> testAddChilNode [
	
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
CTTreeNodeTest >> testAddChildNode [
	"test - aTreeNode addChildNode: aNode"

	self assert: newTreeNode object equals: 'node'.
	self assert: newTreeNode parent isNil.
	self assert: newTreeNode children isEmpty.	
	newTreeNode addChildren: { sub1 . sub2 }.
	self assert: newTreeNode children size equals: 2.
	
	
	



	

	
	
]

{ #category : #'test adding' }
CTTreeNodeTest >> testAddChildrenSet [
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
CTTreeNodeTest >> testBasicCreation [
	"Verify that a treeNode parent access methods"

	self assert: sub1 parent isNil.  
	self assert: sub1 hasNoChildren
]

{ #category : #'test removing' }
CTTreeNodeTest >> testBeChildless [
	"test - aTreeNode beChildless"
	
	self assert: (newTreeNode children isEmpty).
	newTreeNode addChildNode: sub1.
	sub1 addChildNode: sub2.
	self assert: newTreeNode children size equals: 1.
	self assert: sub1 children size equals: 1.
	sub1 beChildless.
	self assert: sub1 children size equals: 0.
	self assert: newTreeNode children size equals: 1.

]

{ #category : #'test accessing' }
CTTreeNodeTest >> testChildren [
	"test a treeNode has children?" 
	"Answers an <OrderedCollection> of the child nodes or empty collection"
	
	| collection |
	self assert: newTreeNode hasNoChildren.
	newTreeNode addChildNode: sub1.
	newTreeNode addChildNode: sub2.
	collection := OrderedCollection new.	
	collection add: sub1; add: sub2.
	self assert: newTreeNode children equals: collection.
	
]

{ #category : #'test adding' }
CTTreeNodeTest >> testCreateNewInstance [
	"test - TreeNode for: anObject. Create a new TreeNode instance."
	
	| aTreeNode root |
	aTreeNode := CTTreeNode for: 'node'.
	self assert: aTreeNode object equals: 'node'.
	self assert: aTreeNode parent isNil.
	self assert: aTreeNode hasNoChildren.
	self assert: aTreeNode children isEmpty.
	
	root := CTTreeNode new.
	root object: 'node'.
	self assert: root object equals: aTreeNode object
	


	

	
	
]

{ #category : #'test - working on that one' }
CTTreeNodeTest >> testCreation [
	"Verify that a treeNode parent access methods"
	
	| node |
	node := CTTreeNode for: 'subnode1'.
	self deny: newTreeNode hasParent.  
	self assert: newTreeNode hasNoParent.  
	self deny: newTreeNode hasChildren.
	self assert: newTreeNode hasNoChildren
]

{ #category : #'test accessing' }
CTTreeNodeTest >> testDegree [
	"new method added"
	| sub3 |
	newTreeNode addChildNode: sub1.
	sub1 addChildNode: sub2.
	sub3 := sub2 addChildNode: (CTTreeNode for: 'subnode3').
	self assert: newTreeNode degree equals: 0.
	self assert: sub1 degree equals: 1.
	self assert: sub2 degree equals: 2.
	self assert: sub3 degree equals: 3.
	
]

{ #category : #'test - working on that one' }
CTTreeNodeTest >> testObjectEquality [
	"A tree is composed of an object (kind of node value) and children"
	
	self assert: newTreeNode object equals: newTreeNode object. 
	self deny:  (CTTreeNode new object: #node) equals: (CTTreeNode for: #node). 

]

{ #category : #'test removing' }
CTTreeNodeTest >> testRemoveChildNode [
	"test - aTreeNoe removeChildNode: aTreeNode "
	
	| sub3 |
	sub1 := newTreeNode addChildNode: (CTTreeNode for: 'subnode1').
	sub2 := newTreeNode addChildNode: (CTTreeNode for: 'subnode2').
	self assert: newTreeNode children size equals: 2.
	sub3 := newTreeNode removeChildNode: sub1 ifAbsent: [].
	self assert: sub3 equals: sub1.
	self assert: newTreeNode children size equals: 1


	




	

	
	
]

{ #category : #'test accessing' }
CTTreeNodeTest >> testSetChildrenShouldSetParent [
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
