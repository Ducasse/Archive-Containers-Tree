test - working on that one
testBasicCreation
	"Verify that a treeNode parent access methods"

	self assert: (sub1 parent isNil).  
	self assert: (sub1 hasNoChildren)