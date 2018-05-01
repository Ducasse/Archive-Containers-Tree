test adding
testCreateNewInstance
	"test - TreeNode for: anObject. Create a new TreeNode instance."
	| aTreeNode root |
	aTreeNode := CTSimpleTree for: 'node'.
	self assert: (aTreeNode object = 'node').
	self assert: (aTreeNode parent = nil).
	self assert: (aTreeNode hasNoChildren).
	self assert: (aTreeNode children isEmpty).
	
	root := CTSimpleTree new.
	root object: 'node'.
	self assert: (root object = aTreeNode object)
	


	

	
	