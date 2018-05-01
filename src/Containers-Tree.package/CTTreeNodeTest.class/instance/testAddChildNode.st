test adding
testAddChildNode
	"test - aTreeNode addChildNode: aNode"

	self assert: (newTreeNode object = 'node').
	self assert: (newTreeNode parent = nil).
	self assert: (newTreeNode children isEmpty).
	self flag: #incomplete.
	"this method does not test add child"
	
	



	

	
	