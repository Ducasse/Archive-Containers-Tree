Class {
	#name : #STreeLWTest,
	#superclass : #TreesTestCase,
	#category : #'Trees-Tests'
}

{ #category : #removing }
STreeLWTest >> classUnderTest [
	^ CTKeyedParentedTree
]

{ #category : #adding }
STreeLWTest >> testAdd [

	self
		should: 
			[| t |
			t := CTSubtreedTree new.
			t add: 1]
		raise: TreeLWNotATree
		description: 'The object you add must be a tree.'.		
	self
		should: 
			[| t |
			t := CTSubtreedTree new.
			t add: CTSubtreedParentedTree new]
		raise: TreeLWIncompatibleTree
		description: 'Cannot add a tree defining a superTree pointer to a tree not defining one.'.		
	self
		comment: [ 'Here is a valid way to add a tree to the subtrees collection of another tree. ']
		test: 
			[| t u v |
			t := CTKeyedValuedTree key: 1.
			u := CTKeyedValuedTree key: 2.
			v := t add: u.
			Array with: t with: v]
		expectResult: '#(
1\
. . .	2 
2)'
]

{ #category : #adding }
STreeLWTest >> testAddAll [
	"ToDo: Este test debe ser arreglado para imprimir #(#(
	Ver Array >> #printAsLiteralFormOn: "

	self
		should: 
			[| t |
			t := CTSubtreedTree new.
			t addAll: (Array with: CTSubtreedTree new with: CTSubtreedParentedTree new)]
		raise: TreeLWIncompatibleTree
		description: 'Each tree you add must be valid.'.		
	self
		comment: [ 'Here is a valid example of adding two trees.' ]
		test: 
			[| t u v |
			t := CTKeyedValuedTree key: 1 subTrees: Array.
			u := Array with: (CTKeyedValuedTree key: 2) with: (CTKeyedValuedTree key: 3).
			v := t addAll: u.
			Array with: v with: t]
		expectResult: '#(an Array(
2 
3) 
1\
. . .	2
. . .	3)'
]

{ #category : #'accessing misc' }
STreeLWTest >> testAtIndex [
	self
		should: [ | t |
			t := self classUnderTest key: 1 subTrees: Set.
			t addKey: 2.
			t atIndex: 1 ]
		raise: TreeLWNotATree , TreeLWBadSubTrees , Error
		description: 'Cannot access a set of subtrees via an index.'.
	
	self
		should: [ | t |
			t := self classUnderTest key: 1 subTrees: Array.
			t addKey: 2.
			t atIndex: 10 ]
		raise: Error
		description: 'Index out of range.'.
	
	self
		comment: 'May access the node at an index if the subtrees are stored in a 
			sequenceable collection.' 
		test: [ | t |
			t := self classUnderTest new.
			t
				add: (self classUnderTest key: $a);
				add: (self classUnderTest key: $b).
			t atIndex: 1 ]
		expectResult:
			'
$a'
]

{ #category : #'accessing misc' }
STreeLWTest >> testAtIndexPut [

	self
		should: 
			[| t |
			t := CTSubtreedtKeyedTree key: 1 subTrees: Array.
			t addKey: 2.
			t atIndex: 1 put: (CTKeyedParentedTree key: 3)]
		raise: TreeLWIncompatibleTree
		description: 'Both trees must either define or not define a superTrees pointer.'.		
	self
		should: 
			[| t |
			t := CTSubtreedtKeyedTree key: 1 subTrees: SortedCollection.
			t addKey: 2.
			t atIndex: 1 put: (CTSubtreedtKeyedTree key: 3)]
		raise: Error
		description: 'Cannot store into an index of a sorted collection.'.		
	self
		comment: [ 'May store a tree at an index in the subtrees collection if it is 
			sequenceable. The previous tree at this index gets replaced.' ]
		test: 
			[| t u |
			t := CTSubtreedtKeyedTree key: $a subTrees: Array.
			t add: (CTSubtreedtKeyedTree key: $b).
			u := t atIndex: 1 put: (CTSubtreedtKeyedTree key: $c).
			t simplePrintStringLW , String crLW , u simplePrintStringLW]
		expectResult: '
$a\
. . .	$c

$c'
]

{ #category : #converting }
STreeLWTest >> testClip [

	self
		comment: ["Notice how v is a branch and w is a leaf."]
		test: 
			[| t u v w |
			t := CTSubtreedtKeyedTree key: 1.
			u := t copy clip.
			v := t copy makeBranch.
			w := v copy clip.
			Array with: t with: u with: v with: w]
		expectResult: '#(
1 
1 
1\ 
1)'
]

{ #category : #'private initializing' }
STreeLWTest >> testDefaultSubTrees [
	"This is implicitly tested when a tree is created."
]

{ #category : #removing }
STreeLWTest >> testDetach [
	self
		comment: 'After detaching u, t is an empty branch, u is a leaf, and u has become a root.'
		test: [ | t u |
			t := self classUnderTest key: 1.
			u := self classUnderTest key: 2.
			t add: u.
			u detach.
			Array with: t with: u with: u isRoot ]
		expectResult:
			'#(
1\ 
2 true)'
]

{ #category : #'testing misc' }
STreeLWTest >> testIsLeaf [
	self
		comment: 'A tree knows whether it is a branch or leaf.'
		test: [ Array with: self classUnderTest new isLeaf with: self classUnderTest new makeBranch isLeaf ]
		expectResult: '#(true false)'
]

{ #category : #converting }
STreeLWTest >> testMakeBranch [

	self
		comment: [ 'Notice that the result is a branch.' ]
		test: [CTSubtreedTree new makeBranch]
		expectResult: '
node\'
]

{ #category : #converting }
STreeLWTest >> testMakeLeaf [

	self
		comment: [ 'In converting the tree to a leaf, its subtree gets removed.']
		test: 
			[| t |
			t := CTSubtreedtKeyedTree rootFromPath: #(1 2 ).
			t makeLeaf]
		expectResult: '
1'
]

{ #category : #'private accessing' }
STreeLWTest >> testPrivateAccessing [
	"The <testBasicSubTrees> and <testBasicSubTrees:> methods implicitly get tested by 
	many other methods. We won't bother to write tests for them here."
]

{ #category : #removing }
STreeLWTest >> testPrune [
	self
		comment:
			'Branch 7 was unproductive and got removed. Branch 11 did not get removed because you must use recursivePrune to operate recursively.'
		test: [ | t u |
			t := self classUnderTest example3: OrderedCollection.
			u := t recursiveCopy.
			u prune.
			t simplePrintStringLW , String crLW , u simplePrintStringLW ]
		expectResult:
			'
1\
. . .	2\
. . .	. . .	3
. . .	. . .	4
. . .	. . .	5
. . .	6
. . .	7\
. . .	8\
. . .	. . .	9
. . .	. . .	10\
. . .	. . .	. . .	11\
. . .	. . .	. . .	. . .	12\
. . .	. . .	. . .	13

1\
. . .	2\
. . .	. . .	3
. . .	. . .	4
. . .	. . .	5
. . .	6
. . .	8\
. . .	. . .	9
. . .	. . .	10\
. . .	. . .	. . .	11\
. . .	. . .	. . .	. . .	12\
. . .	. . .	. . .	13'
]

{ #category : #converting }
STreeLWTest >> testRecursiveClip [

	self
		comment: [ 'Notice how the branch node with key=3 gets converted to a leaf.' ]
		test: 
			[| t u v w |
			t := CTSubtreedtKeyedTree key: 1 subTrees: Array.
			u := CTSubtreedtKeyedTree key: 2.
			v := (CTSubtreedtKeyedTree key: 3) makeBranch.
			t add: u; add: v.
			w := t copy recursiveClip.
			Array with: t with: w]
		expectResult: '#(
1\
. . .	2
. . .	3\ 
1\
. . .	2
. . .	3)'
]

{ #category : #removing }
STreeLWTest >> testRecursivePrune [
	self
		comment: 'Branches 7 and 11 were unproductive and got recursively pruned.'
		test: [ | t u |
			t := self classUnderTest example3: OrderedCollection.
			u := t recursiveCopy.
			u recursivePrune.
			t simplePrintStringLW , String crLW , u simplePrintStringLW ]
		expectResult:
			'
1\
. . .	2\
. . .	. . .	3
. . .	. . .	4
. . .	. . .	5
. . .	6
. . .	7\
. . .	8\
. . .	. . .	9
. . .	. . .	10\
. . .	. . .	. . .	11\
. . .	. . .	. . .	. . .	12\
. . .	. . .	. . .	13

1\
. . .	2\
. . .	. . .	3
. . .	. . .	4
. . .	. . .	5
. . .	6
. . .	8\
. . .	. . .	9
. . .	. . .	10\
. . .	. . .	. . .	13'
]

{ #category : #removing }
STreeLWTest >> testRecursiveRemoveTreesSatisfying [
	self
		comment: 'The trees with odd keys get removed, along with their subtrees.'
		test: [ | t u |
			t := self classUnderTest example3: OrderedCollection.
			u := t recursiveCopy recursiveRemoveTreesSatisfying: [ :tree | tree key odd ].
			t simplePrintStringLW , String crLW , u simplePrintStringLW ]
		expectResult:
			'
1\
. . .	2\
. . .	. . .	3
. . .	. . .	4
. . .	. . .	5
. . .	6
. . .	7\
. . .	8\
. . .	. . .	9
. . .	. . .	10\
. . .	. . .	. . .	11\
. . .	. . .	. . .	. . .	12\
. . .	. . .	. . .	13

1\
. . .	2\
. . .	. . .	4
. . .	6
. . .	8\
. . .	. . .	10\'
]

{ #category : #enumerating }
STreeLWTest >> testRecursiveSelectInclusive [

	self
		comment: ["Display 
			the original tree 
			recursiveSelect with the root node included and failing 
			recursiveSelect with the root node excluded 
			recursiveSelect with the root node included and passing."]
		test: 
			[| t u v w |
			t := CTSubtreedtKeyedTree example3: Array.
			u := t recursiveSelect: [:aTree | aTree key even] inclusive: true.
			v := t recursiveSelect: [:aTree | aTree key even] inclusive: false.
			w := t recursiveSelect: [:aTree | aTree key = 1 | aTree key even] inclusive: true.
			Array with: t with: u with: v with: w]
		expectResult: '#(
1\
. . .	2\
. . .	. . .	3
. . .	. . .	4
. . .	. . .	5
. . .	6
. . .	7\
. . .	8\
. . .	. . .	9
. . .	. . .	10\
. . .	. . .	. . .	11\
. . .	. . .	. . .	. . .	12\
. . .	. . .	. . .	13 nil 
1\
. . .	2\
. . .	. . .	4
. . .	6
. . .	8\
. . .	. . .	10\ 
1\
. . .	2\
. . .	. . .	4
. . .	6
. . .	8\
. . .	. . .	10\)'
]

{ #category : #converting }
STreeLWTest >> testRecursiveSubTreesAs [
	"self needsWork"
	
	"Debido a diferencias entre los esquemas de hashing de Squeak y VisualWorks 
	(tamaños iniciales de coleccion y orden en que los elementos son agregados)
	este test esta dañado y es comentado por tal motivo."
	
"	self
		should: 
			[ | t |
			t := SKTreeLW key: 1.
			t addKeys: #(2 3 ).
			t recursiveSubTreesAs: SKPTreeLW ] 
		raise: TreeLWError
		description:  'Argument must be a collection class.'.		
	self
		comment: [ 'We double the keys to eliminate hashing coincidences. Notice how some of the sets have different orderings.' ]
		test: 
			[| t u |
			self halt.
			t := SKTreeLW example3: OrderedCollection.
			t recursiveDo: [:tree | tree key: tree key * 2].
			u := t recursiveSubTreesAs: Set.
			Array
				with: t
				with: t subTrees class name
				with: u
				with: u subTrees class name] 
		expectResult: '#(
2\
. . .	4\
. . .	. . .	6
. . .	. . .	8
. . .	. . .	10
. . .	12
. . .	14\
. . .	16\
. . .	. . .	18
. . .	. . .	20\
. . .	. . .	. . .	22\
. . .	. . .	. . .	. . .	24\
. . .	. . .	. . .	26 #SortedCollection 
2\
. . .	12
. . .	14\
. . .	4\
. . .	. . .	8
. . .	. . .	10
. . .	. . .	6
. . .	16\
. . .	. . .	18
. . .	. . .	20\
. . .	. . .	. . .	22\
. . .	. . .	. . .	. . .	24\
. . .	. . .	. . .	26 #Set)'"
]

{ #category : #removing }
STreeLWTest >> testRemove [
	self
		should: [ | t |
			t := self classUnderTest key: 1.
			t add: (self classUnderTest key: 2).
			t remove: (self classUnderTest key: 3) ]
		raise: TreeLWTreeNotFound
		description: 'Cannot remove a tree you do not have.'.
	self
		should: [ | t |
			t := self classUnderTest key: 1.
			t remove: (self classUnderTest key: 1) ]
		raise: TreeLWTreeNotFound
		description: 'Cannot remove from a leaf.'.
	self
		comment: [ 'Valid example of removing a tree.' ]
		test: [ | t u v |
			t := self classUnderTest key: 1 subTrees: Array.
			t addKeys: #(2 3).
			u := t copy.
			v := u remove: (self classUnderTest key: 2).
			Array with: t with: u with: v ]
		expectResult:
			'#(
1\
. . .	2
. . .	3 
1\
. . .	3 
2)'
]

{ #category : #removing }
STreeLWTest >> testRemoveAll [
	" Idem testAddAll "

	self
		should: [ | t |
			t := self classUnderTest key: 1.
			t add: (self classUnderTest key: 2).
			t add: (self classUnderTest key: 3).
			t removeAll: (Array with: (self classUnderTest key: 2) with: (self classUnderTest key: 4)) ]
		raise: TreeLWTreeNotFound
		description: 'You must have all the specified subtrees.'.
	self
		comment: [ 'Here''s how to remove a collection of trees from the subtrees collection.' ]
		test: [ | s t u |
			t := self classUnderTest key: 1.
			t addKeys: #(2 3 4).
			u := t copy.
			s := u removeAll: (Array with: (self classUnderTest key: 2) with: (self classUnderTest key: 3)).
			Array with: s with: t with: u ]
		expectResult:
			'#(an Array(
2 
3) 
1\
. . .	2
. . .	3
. . .	4 
1\
. . .	4)'
]

{ #category : #removing }
STreeLWTest >> testRemoveIfAbsent [
	"Already tested by the <testRemove> method."
]

{ #category : #removing }
STreeLWTest >> testRemoveTreesSatisfying [
	self
		comment: [ 'This removes trees from the subtrees collection, but not recursively.' ]
		test: [ | t u |
			t := self classUnderTest key: 1 subTrees: Array.
			t
				addPath: #(2 3);
				addPath: #(3 4).
			u := t copy.
			u removeTreesSatisfying: [ :tree | tree key odd ].
			Array with: t with: u ]
		expectResult:
			'#(
1\
. . .	2\
. . .	. . .	3
. . .	3\
. . .	. . .	4 
1\
. . .	2\
. . .	. . .	3)'
]

{ #category : #enumerating }
STreeLWTest >> testSelect [

	self
		comment: [ 'This operates on the immediate subtrees.' ]
		test: 
			[| t u |
			t := CTSubtreedtKeyedTree example4: SortedCollection.
			u := t select: [:aTree | aTree key > 2].
			Array with: t with: u]
		expectResult: '#(
1\
. . .	2\
. . .	. . .	3
. . .	. . .	4
. . .	. . .	5
. . .	6 
1\
. . .	6)'
]

{ #category : #'accessing simple' }
STreeLWTest >> testSubTrees [

	self
		comment: [ 'This tree has two subtrees.' ]
		test: 
			[| t |
			t := CTKeyedValuedTree subTrees: Array.
			t addKeys: 'bc'.
			t subTrees]
		expectResult: '#(
$b 
$c)'
]

{ #category : #converting }
STreeLWTest >> testSubTreesAs [
	self
		should: [ | t |
			t := CTSubtreedtKeyedTree key: 1.
			t addKeys: #(2 3).
			t subTreesAs: Dictionary ]
		raise: TreeLWBadSubTrees
		description: 'Cannot store subtrees in a dictionary.'.
	self
		comment: [ 'Converting a leaf node.' ]
		test: [ | t |
			t := (CTSubtreedtKeyedTree key: 1 subTrees: SortedCollection) subTreesAs: Set.
			Array with: t with: t subTrees class name ]
		expectResult:
			'#(
1 #Set)'.
	self
		comment: [ 'Notice the difference between this and its recursive counterpart. 
			This only transforms the immediate subtrees collection.' ]
		test: [ | t u |
			t := CTSubtreedtKeyedTree example3: SortedCollection.
			t recursiveDo: [ :tree | tree key: tree key * 2 ].
			u := t subTreesAs: Set.
			Array
				with: t
				with: t subTrees class name
				with: u
				with: u subTrees class name ]
		expectResult:
			'#(
2\
. . .	4\
. . .	. . .	6
. . .	. . .	8
. . .	. . .	10
. . .	12
. . .	14\
. . .	16\
. . .	. . .	18
. . .	. . .	20\
. . .	. . .	. . .	22\
. . .	. . .	. . .	. . .	24\
. . .	. . .	. . .	26 #SortedCollection 
2\
. . .	12
. . .	14\
. . .	4\
. . .	. . .	6
. . .	. . .	8
. . .	. . .	10
. . .	16\
. . .	. . .	18
. . .	. . .	20\
. . .	. . .	. . .	22\
. . .	. . .	. . .	. . .	24\
. . .	. . .	. . .	26 #Set)'
]

{ #category : #'private validating' }
STreeLWTest >> testValidateSubTrees [
	"This method is implicitly tested by TesterTreeLW>>testSubTrees."
]
