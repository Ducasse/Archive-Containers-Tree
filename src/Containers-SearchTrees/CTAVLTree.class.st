"
I represent an AVL (Adelson-Velsky and Landis) tree.

I am a self-balancing binary search tree. Heights of the two child subtrees of any node differ by at most one, if at any time they differ by more than one, rebalancing is done to restore this property. Rebalancing is done by node rotations.

I collaborate with CTNullBinaryTree and use it as a null node. I'm a subclass of CTBinarySearchTree and can use methods defined there.

Public API and Key Messages

- addNode: aNode
- remove: aData
- isBalanced
- Instance creation: CTAVLTree with: 3 >>> 'a CTAVLTree'

```
   | aTree |
	aTree := CTAVLTree with: 1.
	aTree addNode: (CTAVLTree with: 2).
	aTree := aTree addNode: (CTAVLTree with: 3).
	aTree sizeOfTree == 3.
	aTree height == 1.
```

Implementation Points
Method add: aData from CTBinarySearch tree shouldn't be used, it doesn't return balanced tree.
"
Class {
	#name : #CTAVLTree,
	#superclass : #CTBinarySearchTree,
	#category : #'Containers-SearchTrees'
}

{ #category : #'adding/removing' }
CTAVLTree >> addNode: aNode [
	"Add a node to AVL tree and rebalance it if neccessary. Answer balanced AVL tree"
	
	| factor |
	data isNil
		ifTrue: [ data := aNode object ]. 
		
	aNode object < data
		ifTrue: [ leftChild := leftChild addNode: aNode ].
	aNode object > data
		ifTrue: [ rightChild := rightChild addNode: aNode ].
		
	factor := self balanceFactor.
	factor > 1
		ifTrue: [ aNode object < leftChild object
				ifFalse: [ leftChild := leftChild leftRotate ].
			^ self rightRotate ].
	factor < -1
		ifFalse: [ ^ self ].
	aNode object > rightChild object
		ifFalse: [ rightChild := rightChild rightRotate ].
	^ self leftRotate
]

{ #category : #operation }
CTAVLTree >> balanceFactor [
	"Answer balance factor (left subtree height – right subtree height) of the current node."
	
	^ leftChild height - rightChild height
]

{ #category : #operation }
CTAVLTree >> height [ 
	"Answer height of a node - number of edges on the longest path from the node to a leaf"
	
	^ (self leftChild height max: self rightChild height) + 1.
]

{ #category : #'testing ' }
CTAVLTree >> isNodeBalanced [
	"Answer if the node is balanced. In an AVL tree, node is balanced if the heights of the two child subtrees of any node differ by at most one"

	(leftChild height - rightChild height) abs < 2
		ifTrue: [ ^ true ]
		ifFalse: [ ^ false ].
]

{ #category : #rotating }
CTAVLTree >> leftRotate [
	"Left rotate subtree root wtih receiver. Answer rotated tree"
	
	| pivot |
	pivot := self rightChild.
	self rightChild: pivot leftChild.
	pivot leftChild: self.	
	^ pivot
	
	
	

]

{ #category : #'adding/removing' }
CTAVLTree >> remove: aData [
	"Remove a node containing aData from tree and rebalance it if neccessary. Answer balanced tree"
	
	| smallestNodeInRightSubtree factor temporary |
	aData < data
		ifTrue: [ leftChild := leftChild remove: aData ].
	aData > data
		ifTrue: [ rightChild := rightChild remove: aData ].

	temporary := self.	
		
	aData == data  
		ifTrue: [ 	self isLeaf
							ifTrue: [ temporary := CTNullBinaryTree uniqueInstance ].
						self hasOnlyLeftChild
							ifTrue: [ temporary := leftChild ].
						self hasOnlyLeftChild
							ifTrue: [ temporary := rightChild ].
						self hasBothChildren
							ifTrue: [ smallestNodeInRightSubtree := rightChild leftmostNode: self.
							data := smallestNodeInRightSubtree object.
							rightChild := rightChild remove: smallestNodeInRightSubtree object ]].
	
	factor := self balanceFactor.
	
	factor > 1
		ifTrue: [ leftChild balanceFactor  >= 0
				ifFalse: [ leftChild := leftChild leftRotate ].
							  ^ self rightRotate ].
	factor < -1
		ifTrue: [	rightChild balanceFactor  <= 0
					ifFalse: [ rightChild := rightChild rightRotate ].
					^ self leftRotate ].
		
	 ^ temporary
]

{ #category : #rotating }
CTAVLTree >> rightRotate [
	"Right rotate subtree rooted with receiver. Answer rotated tree"
	
	| pivot |
	pivot := self leftChild.
	self leftChild: pivot rightChild.
	pivot rightChild: self.
	^ pivot
	
	

]
