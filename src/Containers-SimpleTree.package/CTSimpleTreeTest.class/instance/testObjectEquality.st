test - working on that one
testObjectEquality
	"A tree is composed of an object (kind of node value) and children"
	
	self assert: (newTreeNode object = newTreeNode object). 
	self deny:  ((CTSimpleTree new object: #node) = (CTSimpleTree for: #node) ). 
	"this is normal since was not overloaded."