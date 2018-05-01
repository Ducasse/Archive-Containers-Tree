test accessing
testChildren
	"test a treeNode has children?" 
	"Answers an <OrderedCollection> of the child nodes or empty collection"
	
	| collection |
	self assert: newTreeNode hasNoChildren.
	newTreeNode addChildNode: sub1.
	newTreeNode addChildNode: sub2.
	collection := OrderedCollection new.	
	collection add: sub1; add: sub2.
	self assert: (newTreeNode children = collection).
	