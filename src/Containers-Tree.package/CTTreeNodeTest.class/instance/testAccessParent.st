test - working on that one
testAccessParent
	"Verify that a treeNode parent access methods"

	sub1 parent: newTreeNode.
	newTreeNode children add: sub1.
	
	self assert: (newTreeNode hasNoParent).  "root's parent is nil"
	self assert: (sub1 parent = newTreeNode ).
	
	newTreeNode := CTTreeNode for: 'node'.
	newTreeNode addChildNode: sub1. 		"add child and auto assign me as its parent "
	
	self assert: (newTreeNode hasNoParent).
	self assert: (sub1 parent = newTreeNode ).