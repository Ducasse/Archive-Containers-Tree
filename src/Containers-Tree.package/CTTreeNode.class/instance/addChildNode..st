adding/removing
addChildNode: aCTTreeNode 
	"Add a node in the receiver and return the added node. Set the parent of the added node to be the receiver."
	aCTTreeNode parent: self. 
	^ children add: aCTTreeNode 