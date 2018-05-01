test - working on that one
testCreation
	"Verify that a treeNode parent access methods"
	| node |
	node := (CTTreeNode for: 'subnode1').
	self deny: (newTreeNode hasParent).  
	self assert: (newTreeNode hasNoParent).  
	self deny: (newTreeNode hasChildren).
	self assert: (newTreeNode hasNoChildren)