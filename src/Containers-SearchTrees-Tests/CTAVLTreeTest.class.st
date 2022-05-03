Class {
	#name : #CTAVLTreeTest,
	#superclass : #TestCase,
	#category : #'Containers-SearchTrees-Tests'
}

{ #category : #'test operations' }
CTAVLTreeTest >> avlTreeClass [

	^ CTAVLTree
]

{ #category : #'test adding/removing' }
CTAVLTreeTest >> testAddNode [

	| aTree |
	aTree := self avlTreeClass with: 1.
	aTree addNode: (self avlTreeClass with: 2).

	aTree rightChild object.

	self assert: aTree rightChild object equals: 2
]

{ #category : #'test adding/removing' }
CTAVLTreeTest >> testAddNodeLeftRightRotate [

	| aTree |
	aTree := self avlTreeClass with: 3.
	aTree addNode: (self avlTreeClass with: 1).
	aTree := aTree addNode: (self avlTreeClass with: 2).


	self assert: aTree object equals: 2.
	self assert: aTree leftChild object equals: 1.
	self assert: aTree rightChild object equals: 3
]

{ #category : #'test adding/removing' }
CTAVLTreeTest >> testAddNodeLeftRotate [

	| aTree |
	aTree := self avlTreeClass with: 1.
	aTree addNode: (self avlTreeClass with: 2).
	aTree := aTree addNode: (self avlTreeClass with: 3).

	self assert: aTree object equals: 2.
	self assert: aTree leftChild object equals: 1.
	self assert: aTree rightChild object equals: 3
]

{ #category : #'test adding/removing' }
CTAVLTreeTest >> testAddNodeRightLeftRotate [

	| aTree |
	aTree := self avlTreeClass with: 1.
	aTree addNode: (self avlTreeClass with: 3).
	aTree := aTree addNode: (self avlTreeClass with: 2).

	self assert: aTree object equals: 2.
	self assert: aTree leftChild object equals: 1.
	self assert: aTree rightChild object equals: 3
]

{ #category : #'test adding/removing' }
CTAVLTreeTest >> testAddNodeRightRotate [

	| aTree |
	aTree := self avlTreeClass with: 3.
	aTree addNode: (self avlTreeClass with: 2).
	aTree := aTree addNode: (self avlTreeClass with: 1).

	self assert: aTree object equals: 2.
	self assert: aTree leftChild object equals: 1.
	self assert: aTree rightChild object equals: 3
]

{ #category : #'test operations' }
CTAVLTreeTest >> testBalanceFactor [

	| aTree |
	aTree := self avlTreeClass with: 3.
	aTree addNode: (self avlTreeClass with: 4).
	aTree addNode: (self avlTreeClass with: 1).
	aTree addNode: (self avlTreeClass with: 2).

	self assert: aTree leftChild balanceFactor equals: -1.
	self assert: aTree balanceFactor equals: 1
]

{ #category : #'test operations' }
CTAVLTreeTest >> testHeight [

	| aTree |
	aTree := self avlTreeClass with: 3.
	aTree addNode: (self avlTreeClass with: 4).
	aTree addNode: (self avlTreeClass with: 1).
	aTree addNode: (self avlTreeClass with: 2).

	self assert: aTree rightChild height equals: 0.
	self assert: aTree height equals: 2
]

{ #category : #'test operations' }
CTAVLTreeTest >> testHeightRoot [

	| aTree |
	aTree := self avlTreeClass with: 3.
	self assert: aTree height equals: 0
]

{ #category : #'test testing' }
CTAVLTreeTest >> testIsNodeBalanced [

	| aTree |
	aTree := self avlTreeClass with: 8.
	aTree addNode: (self avlTreeClass with: 3).
	aTree addNode: (self avlTreeClass with: 10).
	aTree addNode: (self avlTreeClass with: 6).
	self assert: aTree isNodeBalanced
]

{ #category : #'test rotating' }
CTAVLTreeTest >> testLeftRotate [

	| aTree node |
	aTree := self avlTreeClass with: 8.
	aTree add: 9.
	aTree add: 10.

	node := aTree leftRotate.

	self assert: node object equals: 9.
	self assert: node leftChild object equals: 8.
	self assert: node rightChild object equals: 10
]

{ #category : #'test adding/removing' }
CTAVLTreeTest >> testRemove [

	| aTree |
	aTree := self avlTreeClass with: 1.
	aTree addNode: (self avlTreeClass with: 2).
	aTree := aTree remove: 2.
	self assert: aTree size equals: 1.
	self assert: aTree object equals: 1
]

{ #category : #'test adding/removing' }
CTAVLTreeTest >> testRemoveLeftRightRotate [

	| aTree |
	aTree := self avlTreeClass with: 3.
	aTree addNode: (self avlTreeClass with: 4).
	aTree addNode: (self avlTreeClass with: 1).
	aTree addNode: (self avlTreeClass with: 2).

	aTree := aTree remove: 4.


	self assert: aTree object equals: 2.
	self assert: aTree leftChild object equals: 1.
	self assert: aTree rightChild object equals: 3
]

{ #category : #'test adding/removing' }
CTAVLTreeTest >> testRemoveLeftRotate [

	| aTree |
	aTree := self avlTreeClass with: 8.
	aTree addNode: (self avlTreeClass with: 7).
	aTree addNode: (self avlTreeClass with: 9).
	aTree addNode: (self avlTreeClass with: 10).

	aTree := aTree remove: 7.

	self assert: aTree object equals: 9.
	self assert: aTree leftChild object equals: 8.
	self assert: aTree rightChild object equals: 10
]

{ #category : #'test adding/removing' }
CTAVLTreeTest >> testRemoveRightLeftRotate [

	| aTree |
	aTree := self avlTreeClass with: 1.
	aTree addNode: (self avlTreeClass with: 0).
	aTree addNode: (self avlTreeClass with: 3).
	aTree := aTree addNode: (self avlTreeClass with: 2).

	aTree := aTree remove: 0.

	self assert: aTree object equals: 2.
	self assert: aTree leftChild object equals: 1.
	self assert: aTree rightChild object equals: 3
]

{ #category : #'test adding/removing' }
CTAVLTreeTest >> testRemoveRightRotate [

	| aTree |
	aTree := self avlTreeClass with: 6.
	aTree addNode: (self avlTreeClass with: 3).
	aTree addNode: (self avlTreeClass with: 7).
	aTree addNode: (self avlTreeClass with: 1).

	aTree := aTree remove: 7.

	self assert: aTree size equals: 3.
	self assert: aTree object equals: 3.
	self assert: aTree leftChild object equals: 1.
	self assert: aTree rightChild object equals: 6
]

{ #category : #'test rotating' }
CTAVLTreeTest >> testRightRotate [

	| aTree node |
	aTree := self avlTreeClass with: 3.
	aTree add: 2.
	aTree add: 1.

	node := aTree rightRotate.

	self assert: node object equals: 2.
	self assert: node leftChild object equals: 1.
	self assert: node rightChild object equals: 3
]
