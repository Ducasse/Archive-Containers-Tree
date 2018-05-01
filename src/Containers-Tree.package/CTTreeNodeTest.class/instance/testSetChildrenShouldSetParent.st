test accessing
testSetChildrenShouldSetParent
	"test- treeNode children: anOrderedCollection"
	| collection|
	newTreeNode children: OrderedCollection new.
	self assert: newTreeNode hasNoChildren.
	collection := OrderedCollection new.
	collection add: sub1; add: sub2.
	newTreeNode children: collection.
	self assert: (sub1 parent = newTreeNode).
	self assert: (sub2 parent = newTreeNode).
	self assert: (newTreeNode children = collection)
