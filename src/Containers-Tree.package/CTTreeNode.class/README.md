TreeNode is a recursive defintion for a node object in a tree.
As a root node, its parent is nil.
If a node has no children, children is nil or empty collection.
		
		
Instance Variables:
	parent	<TreeNode>  parent of this node in the tree.
	children	<OrderedCollection>   containing the children of this node.
	object	<Object>  an object which is at this node position in the tree.
		
Points to be discussed:
- iteration
- children should always be  a collection.
- when we add a collection as children the children: should do an iteration and set the parent. This is not the client responsibility to do it but an invariant of the class. 
- addChildren we should test that existing nodes are still there. 