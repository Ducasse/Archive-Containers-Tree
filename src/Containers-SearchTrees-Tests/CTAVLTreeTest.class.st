Class {
	#name : #CTAVLTreeTest,
	#superclass : #TestCase,
	#category : #'Containers-SearchTrees-Tests'
}

{ #category : #'test adding/removing' }
CTAVLTreeTest >> testAddNode [ 

	| aTree |
	aTree := CTAVLTree with: 1.
	aTree addNode: (CTAVLTree with: 2).
	
	aTree rightChild data.
	
	self assert: aTree rightChild data equals: 2.
]

{ #category : #'test adding/removing' }
CTAVLTreeTest >> testAddNodeLeftRightRotate [ 

	| aTree |
	aTree := CTAVLTree with: 3.
	aTree addNode: (CTAVLTree with: 1).
	aTree := aTree addNode: (CTAVLTree with: 2).

	
	self assert: aTree data equals: 2.
	self assert: aTree leftChild data equals: 1.
	self assert: aTree rightChild data equals: 3.
	

]

{ #category : #'test adding/removing' }
CTAVLTreeTest >> testAddNodeLeftRotate [ 

	| aTree |
	aTree := CTAVLTree with: 1.
	aTree addNode: (CTAVLTree with: 2).
	aTree := aTree addNode: (CTAVLTree with: 3).
	
	self assert: aTree data equals: 2.
	self assert: aTree leftChild data equals: 1.
	self assert: aTree rightChild data equals: 3.

]

{ #category : #'test adding/removing' }
CTAVLTreeTest >> testAddNodeRightLeftRotate [ 

	| aTree  |
	aTree := CTAVLTree with: 1.
	aTree addNode: (CTAVLTree with: 3).
	aTree := aTree addNode: (CTAVLTree with: 2).
		
	self assert: aTree data equals: 2.
	self assert: aTree leftChild data equals: 1.
	self assert: aTree rightChild data equals: 3.

]

{ #category : #'test adding/removing' }
CTAVLTreeTest >> testAddNodeRightRotate [ 

	| aTree  |
	aTree := CTAVLTree with: 3.
	aTree addNode: (CTAVLTree with: 2).
	aTree := aTree addNode: (CTAVLTree with: 1).
		
	self assert: aTree data equals: 2.
	self assert: aTree leftChild data equals: 1.
	self assert: aTree rightChild data equals: 3.

]

{ #category : #'test operations' }
CTAVLTreeTest >> testBalanceFactor [

	| aTree |
	aTree := CTAVLTree with: 3.
	aTree addNode: (CTAVLTree with: 4).
	aTree addNode: (CTAVLTree with: 1).
	aTree addNode: (CTAVLTree with: 2).
	
	self assert: aTree leftChild balanceFactor equals: -1.
	self assert: aTree balanceFactor equals: 1.
	
]

{ #category : #'test operations' }
CTAVLTreeTest >> testHeight [

	| aTree |
	aTree := CTAVLTree with: 3.
	aTree addNode: (CTAVLTree with: 4).
	aTree addNode: (CTAVLTree with: 1).
	aTree addNode: (CTAVLTree with: 2).
		
	self assert: aTree rightChild height equals: 0.
	self assert: aTree height equals: 2.
	
]

{ #category : #'test operations' }
CTAVLTreeTest >> testHeightRoot [

	| aTree |
	aTree := CTAVLTree with: 3.
	
	self assert: aTree height equals: 0.
	
	
]

{ #category : #'test testing' }
CTAVLTreeTest >> testIsNodeBalanced [

	| aTree |
	aTree := CTAVLTree with: 8.
	aTree addNode: (CTAVLTree with: 3).
	aTree addNode: (CTAVLTree with: 10).
	aTree addNode: (CTAVLTree with: 6).
	self assert: aTree isNodeBalanced 
]

{ #category : #'test rotating' }
CTAVLTreeTest >> testLeftRotate [

	| aTree node |
	aTree :=  CTAVLTree with: 8.
	aTree add: 9.
	aTree add: 10.
	
	node := aTree leftRotate.
	
	self assert: node data equals: 9.
	self assert: node leftChild data equals: 8.
	self assert: node rightChild data equals: 10.


]

{ #category : #'test adding/removing' }
CTAVLTreeTest >> testRemove [ 

	| aTree |
	aTree := CTAVLTree with: 1.
	aTree addNode: (CTAVLTree with: 2).
	aTree := aTree remove: 2.
	self assert: aTree size equals: 1.
	self assert: aTree data equals: 1.
]

{ #category : #'test adding/removing' }
CTAVLTreeTest >> testRemoveLeftRightRotate [ 

	| aTree |
	aTree := CTAVLTree with: 3.
	aTree addNode: (CTAVLTree with: 4).
	aTree addNode: (CTAVLTree with: 1).
	aTree addNode: (CTAVLTree with: 2).
	
	aTree := aTree remove: 4.

	
	self assert: aTree data equals: 2.
	self assert: aTree leftChild data equals: 1.
	self assert: aTree rightChild data equals: 3.
	

]

{ #category : #'test adding/removing' }
CTAVLTreeTest >> testRemoveLeftRotate [

	| aTree |
	aTree :=  CTAVLTree with: 8.
	aTree addNode: (CTAVLTree with: 7).
	aTree addNode: (CTAVLTree with: 9).
	aTree addNode: (CTAVLTree with: 10).
		
	aTree := aTree remove: 7.
	
	self assert: aTree data equals: 9.
	self assert: aTree leftChild data equals: 8.
	self assert: aTree rightChild data equals: 10.


]

{ #category : #'test adding/removing' }
CTAVLTreeTest >> testRemoveRightLeftRotate [ 

	| aTree  |
	aTree := CTAVLTree with: 1.
	aTree addNode: (CTAVLTree with: 0).
	aTree addNode: (CTAVLTree with: 3).
	aTree := aTree addNode: (CTAVLTree with: 2).
	
	aTree := aTree remove: 0.
		
	self assert: aTree data equals: 2.
	self assert: aTree leftChild data equals: 1.
	self assert: aTree rightChild data equals: 3.

]

{ #category : #'test adding/removing' }
CTAVLTreeTest >> testRemoveRightRotate [ 

	| aTree |
	aTree := CTAVLTree with: 6.
	aTree addNode: (CTAVLTree with: 3).
	aTree addNode: (CTAVLTree with: 7).
	aTree addNode: (CTAVLTree with: 1).
	
	aTree := aTree remove: 7.
	
	self assert: aTree size equals: 3.
	self assert: aTree data equals: 3.
	self assert: aTree leftChild data equals: 1.
	self assert: aTree rightChild data equals: 6.
]

{ #category : #'test rotating' }
CTAVLTreeTest >> testRightRotate [

	| aTree node |
	aTree :=  CTAVLTree with: 3.
	aTree add: 2.
	aTree add: 1.
	
	node := aTree rightRotate.
	
	self assert: node data equals: 2.
	self assert: node leftChild data equals: 1.
	self assert: node rightChild data equals: 3.


]
