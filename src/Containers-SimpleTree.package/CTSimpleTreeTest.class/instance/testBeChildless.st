test removing
testBeChildless
	"test - aTreeNode beChildless"

	self assert: (newTreeNode children isEmpty).
	newTreeNode addChildNode: sub1.
	sub1 addChildNode: sub2.
	self assert: (newTreeNode children size = 1).
	self assert: (sub1 children size = 1).
	sub1 beChildless.
	self assert: (sub1 children size = 0).
	self assert: (newTreeNode children size = 1).
	