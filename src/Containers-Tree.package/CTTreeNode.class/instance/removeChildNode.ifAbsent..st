adding/removing
removeChildNode: aCTTreeNode ifAbsent: aBlock
	"Remove a node in the receiver and return the added node. Unset the parent of the added node."
	
	aCTTreeNode noParent.
	^ children remove: aCTTreeNode ifAbsent: aBlock