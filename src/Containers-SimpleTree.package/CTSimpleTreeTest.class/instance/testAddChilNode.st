test accessing
testAddChilNode
	
	| collection  |
	self assert: newTreeNode hasNoChildren.
	newTreeNode addChildNode: sub1.
	newTreeNode addChildNode: sub2.
	collection := OrderedCollection new.	
	collection add: sub1; add: sub2.
	self assert: (newTreeNode children = collection).
	self assert: sub1 parent = newTreeNode.

