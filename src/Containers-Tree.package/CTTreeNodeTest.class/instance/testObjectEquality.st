test - working on that one
testObjectEquality
	"A tree is composed of an object (kind of node value) and children"
	
	self assert: (newTreeNode object = newTreeNode object). 
	self deny:  ((CTTreeNode new object: #node) = (CTTreeNode for: #node) ). 
	"this is normal since was not overloaded."