Class {
	#name : #TreeLWTest,
	#superclass : #TreesTestCase,
	#category : #'Trees-Tests'
}

{ #category : #converting }
TreeLWTest >> testAs [

	self
		should: [CTKeyedValuedTree new as: Array]
		raise: TreeLWNotATree
		description: 'The class you convert to must be a tree class.'.		
	self
		should: [CTSubtreedtKeyedTree new as: CTKeyedParentedTree]
		raise: TreeLWIncompatibleTree
		description: 'Both trees must either define a superTree pointer or not define one.'.		
	self
		comment: [ 'This transformation is legal. Notice how the ''value'' variable gets discarded.' ]
		test: 
			[| t u |
			t := CTUnparentedValuedTree key: 1 value: 2.
			u := t as: CTSubtreedtKeyedTree.
			Array with: t with: u]
		expectResult: '#(
1: 2 
1)'
]

{ #category : #'testing misc' }
TreeLWTest >> testBelongsTo [

	self
		comment: [ 'This is of interest for trees defining a superTree pointer.']
		test: 
			[| t u v |
			t := CTSubtreedParentedTree new.
			u := CTSubtreedParentedTree new.
			v := CTSubtreedParentedTree new.
			t add: u.
			u add: v.
			Array
				with: (u belongsTo: t)
				with: (v belongsTo: t)
				with: (u belongsTo: u)
				with: (t belongsTo: u)]
		expectResult: '#(true false false false)'.
	self
		comment: ["This is always false for trees not defining a superTree pointer."]
		test: 
			[| t u v |
			t := CTSubtreedTree new.
			u := CTSubtreedTree new.
			v := CTSubtreedTree new.
			t add: u.
			u add: v.
			Array
				with: (u belongsTo: t)
				with: (v belongsTo: t)
				with: (u belongsTo: u)
				with: (t belongsTo: u)]
		expectResult: '#(false false false false)'
]

{ #category : #enumerating }
TreeLWTest >> testCollectLW [
	self
		should:
			[| t |
			t := CTKeyedValuedTree key: 1.
			t addKeys: #(2 3 ).
			t collectLW: [:tree | tree sqrt]]
		raise: MessageNotUnderstood
		description: 'Inappropriate code inside block.'.		
	self
		comment: [ 'CollectLW: only operates on the immediate subtrees.']
		test: 
			[| t u |
			t := CTKeyedValuedTree example4: OrderedCollection.
			u := t collectLW: [:subTree | subTree key: subTree key negated].
			Array with: t with: u]
		expectResult: '#(
1: $a\
. . .	2: $b\
. . .	. . .	3: $c
. . .	. . .	4: $d
. . .	. . .	5: $e
. . .	6: $f 
1: $a\
. . .	-2: $b\
. . .	. . .	3: $c
. . .	. . .	4: $d
. . .	. . .	5: $e
. . .	-6: $f)'
]

{ #category : #copying }
TreeLWTest >> testCopy [
	"Already tested by the <testRecursiveCopy> method."
]

{ #category : #'testing simple' }
TreeLWTest >> testDefinesKey [

	self
		comment: [ 'This tests whether the instance variable has been defined, not 
			whether it has been set to some value.']
		test: [Array with: CTSubtreedTree new definesKey with: CTSubtreedtKeyedTree new definesKey]
		expectResult: '#(false true)'
]

{ #category : #'testing simple' }
TreeLWTest >> testDefinesSubTrees [
	"This is not interesting to test."
]

{ #category : #'testing simple' }
TreeLWTest >> testDefinesSuperTree [

	self
		comment: [ 'This tests whether the instance variable has been defined, not 
			whether it has been set to some value.' ]
		test: [Array with: CTSubtreedTree new definesSuperTree with: CTSubtreedParentedTree new definesSuperTree]
		expectResult: '#(false true)'
]

{ #category : #'testing simple' }
TreeLWTest >> testDefinesValue [

	self
		comment: [ 'This tests whether the instance variable has been defined, not 
			whether it has been set to some value.' ]
		test: [Array with: CTSubtreedTree new definesValue with: CTSubstreedValuedTree new definesValue]
		expectResult: '#(false true)'
]

{ #category : #enumerating }
TreeLWTest >> testDetectLW [

	self
		comment: [ 'Detection succeeds with u and fails with v.']
		test: 
			[| t u v |
			t := CTKeyedValuedTree example4: OrderedCollection.
			u := t detectLW: [:subTree | subTree key = 2].
			v := t detectLW: [:subTree | subTree key = 3].
			Array with: t with: u with: v]
		expectResult: '#(
1: $a\
. . .	2: $b\
. . .	. . .	3: $c
. . .	. . .	4: $d
. . .	. . .	5: $e
. . .	6: $f 
2: $b\
. . .	3: $c
. . .	4: $d
. . .	5: $e nil)'
]

{ #category : #enumerating }
TreeLWTest >> testDo [

	self
		comment: [ 'do: operates on the immediate subtrees.' ]
		test: 
			[| t u |
			t := CTKeyedValuedTree example4: OrderedCollection.
			u := t recursiveCopy do: [:subTree | subTree key: subTree key negated].
			t simplePrintStringLW , String crLW , u simplePrintStringLW]
		expectResult: '
1: $a\
. . .	2: $b\
. . .	. . .	3: $c
. . .	. . .	4: $d
. . .	. . .	5: $e
. . .	6: $f

1: $a\
. . .	-2: $b\
. . .	. . .	3: $c
. . .	. . .	4: $d
. . .	. . .	5: $e
. . .	-6: $f'
]

{ #category : #enumerating }
TreeLWTest >> testDoInclusiveReOrder [

	self
		comment: [ 'Notice the difference between specifying true and false and the 
			effect of using a sorted collection.' ]
		test: 
			[| t u v |
			t := CTKeyedValuedTree example4: SortedCollection.
			u := t recursiveCopy
						do: [:subTree | subTree key: subTree key negated]
						inclusive: true
						reOrder: true.
			v := t recursiveCopy
						do: [:subTree | subTree key: subTree key negated]
						inclusive: false
						reOrder: false.
			Array with: t with: u with: v]
		expectResult: '#(
1: $a\
. . .	2: $b\
. . .	. . .	3: $c
. . .	. . .	4: $d
. . .	. . .	5: $e
. . .	6: $f 
-1: $a\
. . .	-6: $f
. . .	-2: $b\
. . .	. . .	3: $c
. . .	. . .	4: $d
. . .	. . .	5: $e 
1: $a\
. . .	-2: $b\
. . .	. . .	3: $c
. . .	. . .	4: $d
. . .	. . .	5: $e
. . .	-6: $f)'
]

{ #category : #'accessing misc' }
TreeLWTest >> testFullPathNodes [

	self
		comment: [ 'You may access the nodes along a full path, returning a collection 
			of nodes.']
		test: 
			[| t |
			t := CTKeyedValuedTree leafFromPath: #(1 2 3 ).
			t fullPathNodes]
		expectResult: '#(
1\
. . .	2\
. . .	. . .	3 
2\
. . .	3 
3)'
]

{ #category : #'testing misc' }
TreeLWTest >> testHasSubTrees [

	self
		comment: [ 'The root has a subtree; the leaf does not.' ]
		test: [Array
					with: (CTKeyedValuedTree rootFromPath: #(1 2 )) hasSubTrees
					with: (CTKeyedValuedTree leafFromPath: #(1 2 )) hasSubTrees]
		expectResult: '#(true false)'
]

{ #category : #'testing misc' }
TreeLWTest >> testIncludes [

	self
		comment: [ 'You can test whether a tree is in the subtrees collection.' ]
		test: 
			[| t |
			t := CTKeyedValuedTree rootFromPath: #(1 2 ).
			Array
				with: (t includes: (CTKeyedValuedTree key: 1))
				with: (t includes: (CTKeyedValuedTree key: 2))
				with: (t includes: (CTKeyedValuedTree key: 3))]
		expectResult: '#(false true false)'
]

{ #category : #'testing misc' }
TreeLWTest >> testIncludesTreeSatisfying [

	self
		should: 
			[| t |
			t := CTKeyedValuedTree key: 1.
			t addKey: 2.
			t includesTreeSatisfying: [:coll | coll isEmpty]]
		raise: MessageNotUnderstood
		description: 'The block should be querying a tree, not a collection.'.		
	self
		comment: [ 'Here''s how to test whether a subtree exists satisfying a block.']
		test: 
			[| t |
			t := CTKeyedValuedTree rootFromPath: #(1 2 ).
			Array
				with: (t includesTreeSatisfying: [:tree | tree key = 1])
				with: (t includesTreeSatisfying: [:tree | tree key = 2])
				with: (t includesTreeSatisfying: [:tree | tree key = 3])]
		expectResult: '#(false true false)'
]

{ #category : #enumerating }
TreeLWTest >> testInclusiveDo [

	self
		comment: [ 'This operates on the receiver and its immediate subtrees; the 
			subtrees do not get reordered.' ]
		test: 
			[| t u |
			t := CTKeyedValuedTree example4: SortedCollection.
			u := t recursiveCopy inclusiveDo: [:subTree | subTree key: subTree key negated].
			Array with: t with: u]
		expectResult: '#(
1: $a\
. . .	2: $b\
. . .	. . .	3: $c
. . .	. . .	4: $d
. . .	. . .	5: $e
. . .	6: $f 
-1: $a\
. . .	-2: $b\
. . .	. . .	3: $c
. . .	. . .	4: $d
. . .	. . .	5: $e
. . .	-6: $f)'
]

{ #category : #'testing misc' }
TreeLWTest >> testIsBranch [

	self
		comment: [ 'A tree knows whether it is a branch or leaf.' ]
		test: [Array
					with: CTKeyedValuedTree new isBranch
					with: CTKeyedValuedTree new makeBranch isBranch]
		expectResult: '#(false true)'
]

{ #category : #'testing misc' }
TreeLWTest >> testIsLeaf [
	"The test for this is in STreeLWTest."
]

{ #category : #'testing misc' }
TreeLWTest >> testIsProductive [

	self
		comment: [ 'Tree t is productive because it has a leaf underneath; u is not 
			productive.' ]
		test: 
			[| t u |
			t := CTKeyedValuedTree rootFromPath: #(1 2 ).
			u := t recursiveCopy.
			(u atKey: 2) makeBranch.
			Array
				with: t isProductive
				with: u isProductive
				with: t
				with: u]
		expectResult: '#(true false 
1\
. . .	2 
1\
. . .	2\)'
]

{ #category : #'testing misc' }
TreeLWTest >> testIsRoot [

	self
		comment: [ 'A tree without a superTree pointer is always a root.' ]
		test: [Array
			with: (CTKeyedParentedTree rootFromPath: #(1 2 3 )) isRoot
			with: (CTKeyedParentedTree leafFromPath: #(1 2 3 )) isRoot
			with: (CTSubtreedtKeyedTree rootFromPath: #(1 2 3 )) isRoot
			with: (CTSubtreedtKeyedTree leafFromPath: #(1 2 3 )) isRoot]
		expectResult: '#(true false true true)'
]

{ #category : #'testing misc' }
TreeLWTest >> testIsTreeLW [

	self
		comment: [ 'This test is applicable to any object.' ]
		test:
			[Array
				with: Object new isTreeLW
				with: CTKeyedValuedTree new isTreeLW]
		expectResult: '#(false true)'
]

{ #category : #'accessing simple' }
TreeLWTest >> testKey [
	self
		comment: [ 'Key is not defined by STreeLW.' ]
		test: [(CTSubtreedTree key: 1) key]
		expectResult: 'nil'.
	self
		comment: [ 'Key is defined by SKTreeLW.' ]
		test: [(CTSubtreedtKeyedTree key: 1) key]
		expectResult: '1'
]

{ #category : #'accessing simple' }
TreeLWTest >> testKeyParameter [
	"Already tested by the class instance creation method."
]

{ #category : #'printing simple' }
TreeLWTest >> testPrintOn [

	self
		comment: [ 'Actually, almost every method ends up testing printOn:. Notice how 
			branches are marked with a separator suffix.' ]
		test: [CTKeyedValuedTree example4: Array]
		expectResult: '
1: $a\
. . .	2: $b\
. . .	. . .	3: $c
. . .	. . .	4: $d
. . .	. . .	5: $e
. . .	6: $f'
]

{ #category : #'private accessing' }
TreeLWTest >> testPrivateAccessing [
	"The test methods for the private accessing protocol are in the classes which 
	define the respective instance variables. There are no interesting tests to place 
	in TreeLWTest."
]

{ #category : #'private initializing' }
TreeLWTest >> testPrivateInitializing [
	"The methods in the private initializing protocol get tested implicitly whenever a 
	tree is created in the test suite. Writing explicit tests for them would not be 
	interesting."
]

{ #category : #'private misc' }
TreeLWTest >> testPrivateMisc [
	"The methods in the private misc protocol get tested implicitly by many other 
	methods in the test suite. Writing explicit tests for them would not be as useful 
	as proofreading their code."
]

{ #category : #'private printing' }
TreeLWTest >> testPrivatePrinting [
	"The methods in the private printing protocol get tested implicitly by the 
	<printOn:> method and whenever a test tree is printed."
]

{ #category : #'private validating' }
TreeLWTest >> testPrivateValidating [
	"The methods in the private validating protocol are implicitly tested by the class 
	instance creation methods that exercise response to legal and illegal values for 
	the instance variables. The <testValidateTree> and <testValidateTreeClass> methods 
	are implicitly tested by the <testAs> method."
]

{ #category : #converting }
TreeLWTest >> testRecursiveAs [

	self
		should: [CTKeyedValuedTree new recursiveAs: Set]
		raise: TreeLWNotATree
		description: 'Can only convert to another tree this way, not to a collection.'.	
	self
		comment: ["The values of an SKPVTreeLW get lost when it is converted to an 
			SKTreeLW. Notice how one tree can define a superTree pointer and 
			the other tree not define it when using recursiveAs:."]		test: 
			[| t u |
			t := CTUnparentedValuedTree
						key: 1
						value: 11
						subTrees: Array.
			t addAll: (Array with: (CTUnparentedValuedTree key: 2 value: 22)
					with: (CTUnparentedValuedTree key: 3 value: 33)).
			u := t recursiveAs: CTSubtreedtKeyedTree.
			Array
				with: t
				with: t class name
				with: u
				with: u class name]
		expectResult: '#(
1: 11\
. . .	2: 22
. . .	3: 33 #SKVTreeLW 
1\
. . .	2
. . .	3 #SKTreeLW)'




]

{ #category : #'testing misc' }
TreeLWTest >> testRecursiveBelongsTo [

	self
		comment: ["This is of interest for trees defining a superTree pointer."]
		test: 
			[| t u v |
			t := CTSubtreedParentedTree new.
			u := CTSubtreedParentedTree new.
			v := CTSubtreedParentedTree new.
			t add: u.
			u add: v.
			Array
				with: (u recursiveBelongsTo: t)
				with: (v recursiveBelongsTo: t)
				with: (u recursiveBelongsTo: u)
				with: (t recursiveBelongsTo: u)]
		expectResult: '#(true true false false)'.
	self
		comment: ["This is always false for trees not defining a superTree pointer."]
		test: 
			[| t u v |
			t := CTSubtreedTree new.
			u := CTSubtreedTree new.
			v := CTSubtreedTree new.
			t add: u.
			u add: v.
			Array
				with: (u recursiveBelongsTo: t)
				with: (v recursiveBelongsTo: t)
				with: (u recursiveBelongsTo: u)
				with: (t recursiveBelongsTo: u)]
		expectResult: '#(false false false false)'
]

{ #category : #enumerating }
TreeLWTest >> testRecursiveCollectInclusive [

	self
		comment: ["Notice how this recursively operates on all the subtrees and how 
			they get reordered."]
		test: 
			[| t u |
			t := CTKeyedValuedTree example4: SortedCollection.
			u := t recursiveCollect: [:aTree | aTree key: aTree key negated] inclusive: true.
			Array with: t with: u]
		expectResult: '#(
1: $a\
. . .	2: $b\
. . .	. . .	3: $c
. . .	. . .	4: $d
. . .	. . .	5: $e
. . .	6: $f 
-1: $a\
. . .	-6: $f
. . .	-2: $b\
. . .	. . .	-5: $e
. . .	. . .	-4: $d
. . .	. . .	-3: $c)'
]

{ #category : #copying }
TreeLWTest >> testRecursiveCopy [

	self
		comment: ["All the subtrees get copied, so the original and the copy have no 
			identical tree in common."]
		test: 
			[| t u v |
			t := CTKeyedValuedTree key: 1.
			t addPath: #(2 3 4 ); addPath: #(5 6 ).
			u := t recursiveCopy.
			v := false.
			t recursiveDo: [:tree1 | u recursiveDo: [:tree2 | tree1 == tree2 ifTrue: [v := true]]].
			Array with: t with: u with: v]
		expectResult: '#(
1\
. . .	2\
. . .	. . .	3\
. . .	. . .	. . .	4
. . .	5\
. . .	. . .	6 
1\
. . .	2\
. . .	. . .	3\
. . .	. . .	. . .	4
. . .	5\
. . .	. . .	6 false)'
]

{ #category : #enumerating }
TreeLWTest >> testRecursiveDetectInclusiveTopDownBreadthFirst [

	self
		comment: ["Illustrating the four topDown/bottomUp and breadthFirst/depthFirst 
			permutations. If you want to see what happens when nothing is 
			detected, change the test to [:aTree | aTree key = 0]."]
		test: 
			[| t s block |
			t := CTKeyedValuedTree example3: OrderedCollection.
			s := WriteStream on: String new.
			block := 
					[:tD1 :bF1 | 
					| detectedTree |
					detectedTree := t
								recursiveDetect: [:aTree | aTree key odd and: [aTree key > 3]]
								inclusive: true
								topDown: tD1
								breadthFirst: bF1.
					s cr; nextPutAll: (tD1
							ifTrue: ['topDown ']
							ifFalse: ['bottomUp ']); nextPutAll: (bF1
							ifTrue: ['breadthFirst ']
							ifFalse: ['depthFirst ']); nextPutAll: 'key of detected tree = '; nextPutAll: (detectedTree isTreeLW
							ifTrue: [detectedTree key printString]
							ifFalse: [detectedTree printString])].
			block value: true value: true.
			block value: true value: false.
			block value: false value: true.
			block value: false value: false.
			t simplePrintStringLW , String crLW , s contents]
		expectResult: '
1: $a\
. . .	2: $b\
. . .	. . .	3: $c
. . .	. . .	4: $d
. . .	. . .	5: $e
. . .	6: $f
. . .	7: $g\
. . .	8: $h\
. . .	. . .	9: $i
. . .	. . .	10: $j\
. . .	. . .	. . .	11: $k\
. . .	. . .	. . .	. . .	12: $l\
. . .	. . .	. . .	13: $m

topDown breadthFirst key of detected tree = 7
topDown depthFirst key of detected tree = 5
bottomUp breadthFirst key of detected tree = 5
bottomUp depthFirst key of detected tree = 5'
]

{ #category : #enumerating }
TreeLWTest >> testRecursiveDo [

	self
		comment: ["Notice how the subtrees get reordered."]
		test: 
			[| t u |
			t := CTKeyedValuedTree example4: SortedCollection.
			u := t recursiveCopy recursiveDo: [:aTree | aTree key: aTree key negated].
			Array with: t with: u]
		expectResult: '#(
1: $a\
. . .	2: $b\
. . .	. . .	3: $c
. . .	. . .	4: $d
. . .	. . .	5: $e
. . .	6: $f 
-1: $a\
. . .	-6: $f
. . .	-2: $b\
. . .	. . .	-5: $e
. . .	. . .	-4: $d
. . .	. . .	-3: $c)'
]

{ #category : #enumerating }
TreeLWTest >> testRecursiveDoInclusiveTopDownBreadthFirstReOrder [

	self
		comment: ["Notice how the resulting sorted collections of subtrees are not 
			properly ordered because we did not specify reordering. It should 
			normally be specified."]
		test: 
			[| t u |
			t := CTKeyedValuedTree example4: SortedCollection.
			u := t recursiveCopy
						recursiveDo: [:aTree | aTree key: aTree key negated]
						inclusive: true
						topDown: true
						breadthFirst: true
						reOrder: false.
			t simplePrintStringLW , String crLW , u simplePrintStringLW]
		expectResult: '
1: $a\
. . .	2: $b\
. . .	. . .	3: $c
. . .	. . .	4: $d
. . .	. . .	5: $e
. . .	6: $f

-1: $a\
. . .	-2: $b\
. . .	. . .	-3: $c
. . .	. . .	-4: $d
. . .	. . .	-5: $e
. . .	-6: $f'.
	self
		comment: ["Illustrating the four topDown/bottomUp and breadthFirst/depthFirst permutations."]
		test: 
			[| t s block |
			t := CTKeyedValuedTree example3: OrderedCollection.
			s := WriteStream on: String new.
			block := 
					[:tD1 :bF1 | 
					s cr; nextPutAll: (tD1
							ifTrue: ['topDown ']
							ifFalse: ['bottomUp ']); nextPutAll: (bF1
							ifTrue: ['breadthFirst ']
							ifFalse: ['depthFirst ']); nextPutAll: 'order = '.
					t
						recursiveDo: [:aTree | s nextPutAll: aTree key printString; space]
						inclusive: true
						topDown: tD1
						breadthFirst: bF1
						reOrder: false].
			block value: true value: true.
			block value: true value: false.
			block value: false value: true.
			block value: false value: false.
			' (But see caveat in the actual method.)' printSimplyOnLW: s.
			t simplePrintStringLW , String crLW , s contents]
		expectResult: '
1: $a\
. . .	2: $b\
. . .	. . .	3: $c
. . .	. . .	4: $d
. . .	. . .	5: $e
. . .	6: $f
. . .	7: $g\
. . .	8: $h\
. . .	. . .	9: $i
. . .	. . .	10: $j\
. . .	. . .	. . .	11: $k\
. . .	. . .	. . .	. . .	12: $l\
. . .	. . .	. . .	13: $m

topDown breadthFirst order = 1 2 6 7 8 3 4 5 9 10 11 13 12 
topDown depthFirst order = 1 2 3 4 5 6 7 8 9 10 11 12 13 
bottomUp breadthFirst order = 3 4 5 12 11 13 9 10 2 6 7 8 1 
bottomUp depthFirst order = 3 4 5 2 6 7 9 12 11 13 10 8 1  (But see caveat in the actual method.)'
]

{ #category : #'testing misc' }
TreeLWTest >> testRecursiveIncludes [

	self
		comment: ["You can ask whether a tree includes another tree recursively under it."]
		test: 
			[| t |
			t := CTKeyedValuedTree rootFromPath: #(1 2 3 ).
			Array
				with: (t recursiveIncludes: (CTKeyedValuedTree key: 1))
				with: (t recursiveIncludes: (CTKeyedValuedTree key: 2))
				with: (t recursiveIncludes: (CTKeyedValuedTree key: 3))
				with: (t recursiveIncludes: (CTKeyedValuedTree key: 4))]
		expectResult: '#(false true true false)'
]

{ #category : #'testing misc' }
TreeLWTest >> testRecursiveIncludesTreeSatisfying [

	self
		should: 
			[| t |
			t := CTKeyedValuedTree key: 1.
			t addKey: 2.
			t recursiveIncludesTreeSatisfying: [:coll | coll isEmpty]]
		raise: MessageNotUnderstood
		description: 'The block should be querying a tree not a collection.'.
	self
		comment: ["Here's how to test for a tree recursively under the receiver."]
		test: 
			[| t |
			t := CTKeyedValuedTree rootFromPath: #(1 2 3 ).
			Array
				with: (t recursiveIncludesTreeSatisfying: [:tree | tree key = 1])
				with: (t recursiveIncludesTreeSatisfying: [:tree | tree key = 2])
				with: (t recursiveIncludesTreeSatisfying: [:tree | tree key = 3])
				with: (t recursiveIncludesTreeSatisfying: [:tree | tree key = 4])]
		expectResult: '#(false true true false)'
]

{ #category : #enumerating }
TreeLWTest >> testRecursiveSubTrees [

	self
		comment: ["This enumerates the subtrees in a top down, breadth first order."]
		test: 
			[| t u |
			t := CTKeyedValuedTree example4: SortedCollection.
			u := (t recursiveSubTrees: true) collect: [:tree | tree key].
			Array with: u with: t]
		expectResult: '#(an OrderedCollection(1 2 6 3 4 5) 
1: $a\
. . .	2: $b\
. . .	. . .	3: $c
. . .	. . .	4: $d
. . .	. . .	5: $e
. . .	6: $f)'
]

{ #category : #'accessing misc' }
TreeLWTest >> testRoot [

	self
		comment: ["A tree defining a superTree pointer can locate its root."]
		test: 
			[| t |
			t := CTKeyedValuedTree leafFromPath: #(1 2 3 ).
			t root]
		expectResult: '
1\
. . .	2\
. . .	. . .	3'.
	self
		comment: ["A tree not defining a superTree pointer is its own root."]
		test: 
			[| t |
			t := CTUnparentedValuedTree leafFromPath: #(1 2 3 ).
			t root]
		expectResult: '
3'
]

{ #category : #'accessing misc' }
TreeLWTest >> testRootlessPathNodes [

	self
		comment: ["You may access the nodes along a rootless path, returning a 
			collection of nodes."]
		test: 
			[| t |
			t := CTKeyedValuedTree leafFromPath: #(1 2 3 ).
			t rootlessPathNodes]
		expectResult: '#(
2\
. . .	3 
3)'
]

{ #category : #'accessing simple' }
TreeLWTest >> testSubTrees [
	"The test for this is in STreeLWTest."
]

{ #category : #'accessing simple' }
TreeLWTest >> testSubTreesParameter [
	"Already tested by the class instance creation method."
]

{ #category : #'accessing simple' }
TreeLWTest >> testSuperTree [

	self
		should: [CTKeyedValuedTree new superTree: CTKeyedValuedTree new]
		raise: Error
		description:  'Clients cannot set the superTree pointer.'
]

{ #category : #'accessing simple' }
TreeLWTest >> testValue [

	self
		comment: [ 'Value is not defined by STreeLW.']
		test: [(CTSubtreedTree value: 1) value]
		expectResult: 'nil'.
	self
		comment: [ 'Value is defined by SVTreeLW.']
		test: [(CTSubstreedValuedTree value: 1) value]
		expectResult: '1'
]

{ #category : #'accessing simple' }
TreeLWTest >> testValueParameter [
	"Already tested by the class instance creation method."
]
