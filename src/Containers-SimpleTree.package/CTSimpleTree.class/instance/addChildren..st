adding/removing
addChildren: aCollectionOfNode 
	"Add the collection of nodes in the receiver and return the added node. Set the parent of each added node to be the receiver."
	aCollectionOfNode do: [ :each | self addChildNode: each ]