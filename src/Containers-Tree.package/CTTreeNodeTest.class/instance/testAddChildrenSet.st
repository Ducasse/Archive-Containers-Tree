test adding
testAddChildrenSet
	"test addChildrenSet: aaTreeNodeSet"
	| aSet |
	aSet := Set new.
	aSet add: sub1; add: sub2.
	newTreeNode addChildren: aSet.
	self assert: (sub1 parent = newTreeNode ).
	self assert: (sub2 parent = newTreeNode ).
	self assert: (newTreeNode children size = 2)



	

	
	