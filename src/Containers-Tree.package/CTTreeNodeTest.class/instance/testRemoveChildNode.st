test removing
testRemoveChildNode
	"test - aTreeNoe removeChildNode: aTreeNode "
	| sub1 sub2 sub3 |
	sub1 := newTreeNode addChildNode: (CTTreeNode for: 'subnode1').
	sub2 := newTreeNode addChildNode: (CTTreeNode for: 'subnode2').
	self assert: (newTreeNode children size = 2).
	sub3 := newTreeNode removeChildNode: sub1 ifAbsent: [].
	self assert: (sub3 = sub1).
	self assert: (newTreeNode children size = 1)


	




	

	
	