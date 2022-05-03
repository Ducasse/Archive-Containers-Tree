Class {
	#name : #CTNaryTreeTest,
	#superclass : #TestCase,
	#category : #'Containers-NewTrees-Tests'
}

{ #category : #'test adding/removing' }
CTNaryTreeTest >> testAddNode [

	| aTree aNode |
	aTree := CTNaryTree with: 1.
	aNode := aTree addNode: (CTNaryTree with: 2).
	self assert: (aTree children at: 1) object equals: 2.
	self assert: aNode parent equals: aTree.
	
]

{ #category : #'test adding/removing' }
CTNaryTreeTest >> testAddSameNodeMultipleTImes [

	| aTree |
	aTree := CTNaryTree with: 1.
	aTree addNode: (CTNaryTree with: 2).
	aTree addNode: (CTNaryTree with: 2).
	aTree addNode: (CTNaryTree with: 2).
	self assert: aTree children size equals: 3.
	self assert: (aTree children at: 1) object equals: 2.
	self assert: (aTree children at: 2) object equals: 2.
	self assert: (aTree children at: 3) object equals: 2.
	
]

{ #category : #'test accessing' }
CTNaryTreeTest >> testChildren [
	"test a treeNode has children?" 
	"Answers an <OrderedCollection> of the child nodes or empty collection"
	
	| aTree |
	aTree := CTNaryTree with: 'a'.
	self assert: aTree isLeaf.
	aTree addNode: (CTNaryTree with: 'b').
	aTree addNode: (CTNaryTree with: 'c').
	self assert: (aTree children at: 1) object equals: 'b'.
	self assert: (aTree children at: 2) object equals: 'c'.
	
]

{ #category : #'test accessing' }
CTNaryTreeTest >> testData [

	| aTree |
	aTree := CTNaryTree with: 1.
	aTree object: 2.
	self assert: aTree object equals: 2.
]

{ #category : #'test operations' }
CTNaryTreeTest >> testDepth [

	| aTree |
	aTree := CTNaryTree ABCtree.
	
	self assert: aTree depth equals: 2
]

{ #category : #'test - traversing' }
CTNaryTreeTest >> testFindBreadthFirst [

	| aTree node |
	aTree := CTNaryTree ABCtree. 

	node := aTree findBreadthFirst: [ :n | n object = 'E' ].
	self assert: node object equals: 'E'.
]

{ #category : #'test - traversing' }
CTNaryTreeTest >> testFindBreadthFirstNonExistingValue [

	| aTree node |
	aTree := CTNaryTree ABCtree. 

	node := aTree findBreadthFirst: [ :n | n object = 'S' ].
	self assert: node isNil.
]

{ #category : #'test - traversing' }
CTNaryTreeTest >> testFindDeepFirst [

	| aTree node |
	aTree := CTNaryTree ABCtree. 

	node := aTree findDeepFirst: [ :n | n object = 'E' ].
	self assert: node object equals: 'E'.
]

{ #category : #'test - traversing' }
CTNaryTreeTest >> testFindDeepFirstNonExistingValue [

	| aTree node |
	aTree := CTNaryTree ABCtree. 

	node := aTree findDeepFirst: [ :n | n object = 'X' ].
	self assert: node isNil.
]

{ #category : #'test operations' }
CTNaryTreeTest >> testFindLeafNode [

	| aTree aNode |
	aTree := CTNaryTree with: 1.
	aTree addNode: (CTNaryTree with: 2).
	
	(aTree children at: 1) addNode: (CTNaryTree with: 3).
	((aTree children at: 1) children at: 1) addNode: (CTNaryTree with: 4).
	aNode := aTree findLeafNode: aTree.
	self assert: aNode isLeaf. 
	self assert: aNode object equals: 4.
]

{ #category : #'test testing' }
CTNaryTreeTest >> testHasChildren [

	| aTree |
	aTree := CTNaryTree with: 'a'.
	aTree children: (OrderedCollection with: 'b' with: 'c').
	self assert: aTree hasChildren
]

{ #category : #'test - traversing' }
CTNaryTreeTest >> testInOrderDo [

	| aTree result expectedResult|
	aTree := CTNaryTree ABCtree.
	result := OrderedCollection new.
	expectedResult := #('B' 'E' 'C' 'F' 'A' 'G' 'D') asOrderedCollection.
	
	aTree inOrderDo: [ :node | result add: node object ].
	result.
	
	1 to: 7 do: 
		[:i | self assert: (expectedResult at:i) equals: (result at:i) ].
]

{ #category : #'test - instance creation' }
CTNaryTreeTest >> testInitialize [ 

	| aTree |
	aTree := CTNaryTree new.
	self assert: aTree object isNil.
	self assert: aTree children isEmpty.
]

{ #category : #'test - instance creation' }
CTNaryTreeTest >> testInstantiateWith [

	| aTree |
	aTree := CTNaryTree with: 2.
	self assert: aTree object equals: 2.
]

{ #category : #'test accessing' }
CTNaryTreeTest >> testParent [

	| node1 node2 |
	node1 := CTNaryTree with: 1.
	node2 := CTNaryTree with: 2.
	node1 parent: node2.
	self assert: node1 parent equals: node2.
]

{ #category : #'test - traversing' }
CTNaryTreeTest >> testPostOrderDo [

	| aTree result expectedResult|
	aTree := CTNaryTree ABCtree.
	result := OrderedCollection new.
	expectedResult := #('B' 'E' 'F' 'C' 'G' 'D' 'A') asOrderedCollection.
	
	aTree postOrderDo: [ :node | result add: node object ].
	
	1 to: 7 do: 
		[:i | self assert: (expectedResult at:i) equals: (result at:i) ].
]

{ #category : #'test - traversing' }
CTNaryTreeTest >> testPreOrderDo [

	| aTree result expectedResult|
	aTree := CTNaryTree ABCtree.
	result := OrderedCollection new.
	expectedResult := #('A' 'B' 'C' 'E' 'F' 'D' 'G') asOrderedCollection.
	
	aTree preOrderDo: [ :node | result add: node object ].
	
	1 to: 7 do: 
		[:i | self assert: (expectedResult at:i) equals: (result at:i) ].
]

{ #category : #'test adding/removing' }
CTNaryTreeTest >> testRemove [

	| aTree aNode |
	aTree := CTNaryTree with: 1.
   aNode := CTNaryTree with: 2.
	aTree addNode: aNode.
	aTree addNode: (CTNaryTree with: 3).
	(aTree children at: 1) addNode: (CTNaryTree with: 4).
	(aTree children at: 1) addNode: (CTNaryTree with: 5).
	aTree remove: aNode.
	
	self assert: (aTree children at: 1) children size equals: 1.
	self assert: (aTree children at: 1) object equals: 4.
	


	
	
]

{ #category : #'test adding/removing' }
CTNaryTreeTest >> testRemoveLeaf [

	| aTree aNode |
	aTree := CTNaryTree with: 1.
	aTree addNode: (CTNaryTree with: 2).
	aNode := (CTNaryTree with: 3).
	aTree addNode: aNode.
	aTree remove: aNode.
	self assert: aTree object equals: 1.
	self assert: aTree children size equals: 1.
	self assert: (aTree children at: 1) object equals: 2.

	
	
]

{ #category : #'test adding/removing' }
CTNaryTreeTest >> testRemoveRoot [

	| aTree aNode |
	aNode := CTNaryTree with: 1.
	aTree := aNode.
	aTree addNode: (CTNaryTree with: 2).
	aTree addNode: (CTNaryTree with: 3).
	(aTree children at: 1) addNode: (CTNaryTree with: 4).
	(aTree children at: 1) addNode: (CTNaryTree with: 5).
	aTree remove: aNode.
	
	self assert: aTree object equals: 4.
	self assert: (aTree children at: 1) children size equals: 1.


	
	
]

{ #category : #'test adding/removing' }
CTNaryTreeTest >> testRemoveTreeWithOneNode [

	| aTree aNode |
	aNode := CTNaryTree with: 1.
	aTree := aNode.
	aTree remove: aNode.
	
	self assert: aTree object isNil.



	
	
]

{ #category : #'test operations' }
CTNaryTreeTest >> testSizeOfTree [

	| aTree |
	aTree := CTNaryTree ABCtree. 
	
	self assert: aTree size equals: 7
]

{ #category : #'test testing' }
CTNaryTreeTest >> testisLeaf [

	| aTree |
	aTree := CTNaryTree with: 'a'.
	self assert: aTree isLeaf
]
