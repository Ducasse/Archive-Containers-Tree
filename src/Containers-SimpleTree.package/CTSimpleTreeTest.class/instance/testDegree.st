test accessing
testDegree
	"new method added"
	| sub3 |
	newTreeNode addChildNode: sub1.
	sub1 addChildNode: sub2.
	sub3 := sub2 addChildNode: (CTSimpleTree for: 'subnode3').
	self assert: newTreeNode degree equals: 0.
	self assert: sub1 degree equals: 1.
	self assert: sub2 degree equals: 2.
	self assert: sub3 degree equals: 3.
	