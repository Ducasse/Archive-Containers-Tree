"
Test suite for SKTreeLW.
"
Class {
	#name : #SKTreeLWTest,
	#superclass : #TreesTestCase,
	#category : #'Trees-Tests'
}

{ #category : #adding }
SKTreeLWTest >> testAddKey [

	self
		comment: [ 'You can add a tree by specifying its key.']
		test: 
			[| t u |
			t := CTSubtreedtKeyedTree key: 1.
			u := t addKey: 2.
			Array with: u with: t]
		expectResult: '#(2 
1\
. . .	2)'
]

{ #category : #adding }
SKTreeLWTest >> testAddKeys [

	self should: [| t |
			t := CTSubtreedtKeyedTree key: 1.
			t addKeys: 2]
		raise: Error
		description: 'Argument must be a collection of keys.'.
	self
		comment: ['A valid example of adding three keys.']
		test: 
			[| t u |
			t := CTSubtreedtKeyedTree key: 1.
			u := t addKeys: #(2 3 4 ).
			t simplePrintStringLW , String crLW , u simplePrintStringLW]
		expectResult: '
1\
. . .	2
. . .	3
. . .	4
#(2 3 4)'
]

{ #category : #adding }
SKTreeLWTest >> testAddPath [
	self
		should: 
			[| t |
			t := CTSubtreedtKeyedTree key: 1.
			t addPath: 2]
		raise: Error
		description: 'Argument must be a sequenceable collection of keys.'.
	self
		comment: ["When you add a path of keys to a tree the returned value is assoc: 
			(number of nodes added)->(leaf node added)."]
		test: 
			[| t u |
			t := CTSubtreedtKeyedTree key: 1.
			u := t addPath: #(2 3 ).
			t simplePrintStringLW , String crLW , u simplePrintStringLW]
		expectResult: '
1\
. . .	2\
. . .	. . .	3
2->
3'
]

{ #category : #'accessing misc' }
SKTreeLWTest >> testAtInclusivePath [
	"The receiver tree instance is supposed to be part of the path."

	self should: [ (CTSubtreedtKeyedTree key: 1) makeBranch atInclusivePath: #(2) ] 
		raise: TreeLWBadPath
		description: 'Incorrect path'.
	self
		should: [(CTSubtreedtKeyedTree key: 1) atInclusivePath: #(1 )]
		raise: TreeLWBadPath
		description: 'Leaves do not have paths.'.
	self
		comment: 'Accessing last node in an inclusive path.'
		test: 
			[| t |
			t := CTSubtreedtKeyedTree key: 1.
			t addPath: #(2 3 ).
			t atInclusivePath: #(1 2 3 )]
		expectResult: '
3'

]

{ #category : #'accessing misc' }
SKTreeLWTest >> testAtInclusivePathIfAbsent [
	"Already tested by the <atInclusivePath:> method."
]

{ #category : #'accessing misc' }
SKTreeLWTest >> testAtKey [

	self
		should: 
			[| t |
			t := CTSubtreedtKeyedTree key: 1.
			t addKey: 2.
			t atKey: 3]
		raise: TreeLWKeyNotFound.
	self
		comment: ["May access the tree at a key in the subtrees collection."]
		test: 
			[| t |
			t := CTSubtreedtKeyedTree key: $a.
			t add: (CTSubtreedtKeyedTree key: $b); add: (CTSubtreedtKeyedTree key: $c).
			t atKey: $b]
		expectResult: '
$b'
]

{ #category : #'accessing misc' }
SKTreeLWTest >> testAtPath [

	self should: [ | t |
			t := CTSubtreedtKeyedTree key: 1.
			t addPath: #(2 3 ).
			t atPath: 2 ] 
		raise: Error
		description: 'A path should be a sequenceable collection of keys. Here it is an integer.'.
	self should: [ | t |
			t := CTSubtreedtKeyedTree key: 1.
			t addPath: #(2 3 ).
			t atPath: #(2 3 4 ) ]
		raise: TreeLWBadPath
		description: 'This path doesn''t exist.'.
	self should: [ | t |
			t := CTSubtreedtKeyedTree key: 1.	"This is a leaf node."
			t atPath: #()]
		raise: TreeLWBadPath
		description: 'A leaf has no path to access.'.
	self
		comment: [ 'May access a node at a path relative to a tree.']
		test: 
			[| t |
			t := CTSubtreedtKeyedTree key: 1.
			t addPath: #(2 3 4 ).
			t atPath: #(2 3 )]
		expectResult: '
3\
. . .	4'	
]

{ #category : #'accessing misc' }
SKTreeLWTest >> testAtPathIfAbsent [
	"Already tested by the <atPath:> method."
]

{ #category : #'accessing misc' }
SKTreeLWTest >> testAtPathIfAbsentLeafIfAbsentBranch [
	self
		comment: [ 'Demonstrates the various possible responses.' ]
		test: 
			[| t u v w x |
			t := CTSubtreedtKeyedTree rootFromPath: #(1 2 3 ).
			u := t atPath: #(2 ) ifAbsentLeaf: [$L] ifAbsentBranch: [$B].
			v := t atPath: #(2 3 ) ifAbsentLeaf: [$L] ifAbsentBranch: [$B].
			w := t atPath: #(2 4 ) ifAbsentLeaf: [$L] ifAbsentBranch: [$B].
			x := t atPath: #(2 3 4 ) ifAbsentLeaf: [$L] ifAbsentBranch: [$B].
			Array with: u with: v with: w with: x]
		expectResult: '#(
2\
. . .	3 
3 $B $L)'
]

{ #category : #'private accessing' }
SKTreeLWTest >> testBasicKey [

	self
		comment: [ 'We use SKTreeLW because there is no KTreeLW. Testing <key> 
			implicitly tests <basicKey>.' ]
		test: [(CTSubtreedtKeyedTree key: 1) key]
		expectResult: '1'
]

{ #category : #'private accessing' }
SKTreeLWTest >> testBasicKeySetter [
	"The <basicKey:> method is implicitly tested by <testBasicKey>."
]

{ #category : #comparing }
SKTreeLWTest >> testEqual [
	" = aTree "

	self
		comment: [ 'Two trees are equal if their keys are equal.']
		test: 
			[| t u v |
			t := CTSubtreedtKeyedTree key: 1 subTrees: Set.
			u := CTKeyedValuedTree key: 1 value: 2 subTrees: Array.
			v := CTSubtreedtKeyedTree key: 0 subTrees: Set.
			Array with: t = u with: t = v]
		expectResult: '#(true false)'
]

{ #category : #'accessing misc' }
SKTreeLWTest >> testFullPathKeys [
	self
		comment: [ 'May access the keys along a full path.']
		test: 
			[| t |
			t := CTKeyedParentedTree leafFromPath: #(1 2 3 ).
			t fullPathKeys]
		expectResult: '#(1 2 3)'
]

{ #category : #'printing misc' }
SKTreeLWTest >> testFullPathString [

	self
		comment: [ 'A string describing the full path to a node.' ]
		test: [(CTKeyedParentedTree leafFromPath: #(1 2 3 4)) fullPathString]
		expectResult: '1\2\3\4'.
	self
		comment: [ 'Same thing, except the tree does not maintain a superTree pointer.' ]
		test: [(CTSubtreedtKeyedTree leafFromPath: #(1 2 3 4)) fullPathString]
		expectResult: '4'
]

{ #category : #'testing misc' }
SKTreeLWTest >> testHasSamePathAs [

	self
		should: [(CTSubtreedtKeyedTree key: 1) hasSamePathAs: #(1)]
		raise: MessageNotUnderstood
		description: 'The argument must be a tree.'.		
	self
		comment: ['A tree with superTree pointer can calculate its path from the root.']
		test: 
			[| t u |
			t := CTKeyedParentedTree leafFromPath: #(1 2 3).
			u := CTKeyedParentedTree leafFromPath: #(1 2 3).
			Array with: (t hasSamePathAs: u) with: (t hasSamePathAs: u superTree)]
		expectResult: '#(true false)'.
	self
		comment: ['A tree without superTree pointer is a root and its key is the single 
			element of its path.']
		test: 
			[| t u v |
			t := CTSubtreedtKeyedTree leafFromPath: #(1 2 3).
			u := CTSubtreedtKeyedTree leafFromPath: #(3).
			v := CTSubtreedtKeyedTree leafFromPath: #(2).
			Array with: (t hasSamePathAs: u) with: (t hasSamePathAs: v)]
		expectResult: '#(true false)'
]

{ #category : #comparing }
SKTreeLWTest >> testHash [
	self
		comment: [ 'Hash depends on the key alone.']
		test: 
			[(CTSubtreedtKeyedTree key: 1) hash]
		expectResult: '1'
]

{ #category : #'printing misc' }
SKTreeLWTest >> testImmediatePathString [

	self
		comment: [ 'A string describing the path from a node''s supertree to the node.' ]
		test: [(CTKeyedParentedTree leafFromPath: #(1 2 3 4)) immediatePathString]
		expectResult: '3\4'.
	self
		comment: [ 'Same thing, but the tree does not maintain a superTree pointer.' ]
		test: [(CTSubtreedtKeyedTree leafFromPath: #(1 2 3 4)) immediatePathString]
		expectResult: '4'.
]

{ #category : #'testing misc' }
SKTreeLWTest >> testIncludesInclusivePath [

	self
		should: 
			[| t |
			t := CTSubtreedtKeyedTree key: 1.
			t addPath: #(2 3 ).
			t includesInclusivePath: 2]
		raise: MessageNotUnderstood
		description: 'Argument must be a sequenceable collection of keys.'.	
	self
		comment: [ 'Here''s how you test for a node at an inclusive path.' ]
		test: 
			[| t |
			t := CTSubtreedtKeyedTree rootFromPath: #(1 2 3).
			Array
					with: (t includesInclusivePath: #(1 2 3))
					with: (t includesInclusivePath: #(1 2 4))]
		expectResult: '#(true false)'

]

{ #category : #'testing misc' }
SKTreeLWTest >> testIncludesKey [

	self
		comment: [ 'Can test whether a tree with a specified key is in the subtrees 
			collection.']
		test: 
			[| t |
			t := CTSubtreedtKeyedTree rootFromPath: #(1 2 ).
			Array with: (t includesKey: 2) with: (t includesKey: 3)]
		expectResult: '#(true false)'
]

{ #category : #'testing misc' }
SKTreeLWTest >> testIncludesPath [

	self
		should: 
			[| t |
			t := CTSubtreedtKeyedTree key: 1.
			t addPath: #(2 3).
			t includesPath: 2]
		raise: MessageNotUnderstood
		description: 'Argument must be a sequenceable collection of keys'	.
	self
		comment: [ 'Here''s how to test whether a path from a node exists.' ]
		test: 
			[| t |
			t := CTSubtreedtKeyedTree rootFromPath: #(1 2 3).
			Array with: (t includesPath: #(2 3)) with: (t includesPath: #(2 4))]
		expectResult: '#(true false)'
]

{ #category : #'accessing misc' }
SKTreeLWTest >> testKeys [
	self
		comment: [ 'Accessing the keys of the subtrees. SortedColl is just for fun.' ]
		test: 
			[| t |
			t := CTSubtreedtKeyedTree key: $a subTrees: SortedCollection.
			t addKeys: 'bc'.
			t keys]
		expectResult: 'a SortedCollection($b $c)'
]

{ #category : #'instance creation' }
SKTreeLWTest >> testLeafFromPath [

	self
		comment: [ 'May create a whole path at once and return its leaf node.' ]
		test: [CTSubtreedtKeyedTree leafFromPath: #(1 2 3)]
		expectResult: '
3'
]

{ #category : #comparing }
SKTreeLWTest >> testLessOrEqualThan [ 
	" <= aTree "

	self
		comment: ['Comparison depends on the keys alone.']
		test: 
			[| t1 t2 |
			t1 := CTSubtreedtKeyedTree key: 1.
			t2 := CTSubtreedtKeyedTree key: 2.
			Array with: t1 <= t2 with: t1 <= t1 with: t2 <= t1]
		expectResult: '#(true true false)'
]

{ #category : #comparing }
SKTreeLWTest >> testLessThan [
	self
		comment: [ 'Comparison depends on the keys alone.']
		test: 
			[| t1 t2 |
			t1 := CTSubtreedtKeyedTree key: 1.
			t2 := CTSubtreedtKeyedTree key: 2.
			Array with: t1 < t2 with: t2 < t1]
		expectResult: '#(true false)'
]

{ #category : #removing }
SKTreeLWTest >> testRemoveKey [
	self
		should: 
			[| t |
			t := CTSubtreedtKeyedTree key: 1.
			t addKey: 2.
			t removeKey: 3]
		raise: TreeLWKeyNotFound
		description: 'Cannot remove a key you do not have.'.
	self
		comment: ["Here's how to do it."]
		test: 
			[| s t u |
			t := CTSubtreedtKeyedTree key: 1 subTrees: Array.
			t addKeys: #(2 3 ).
			u := t copy.
			s := u removeKey: 2.
			Array with: s with: t with: u]
		expectResult: '#(2 
1\
. . .	2
. . .	3 
1\
. . .	3)'
]

{ #category : #removing }
SKTreeLWTest >> testRemoveKeyIfAbsent [
	"Already tested by the <testRemoveKey> method."
]

{ #category : #removing }
SKTreeLWTest >> testRemoveKeys [
	self
		should: 
			[| t |
			t := CTSubtreedtKeyedTree key: 1.
			t addKeys: #(2 3).
			t removeKeys: #(2 4)]
		raise: TreeLWKeyNotFound
		description: 'You must have all the keys.'.		
	self
		comment: ["Here's how to remove a collection of trees specified by their keys 
			from the subtrees collection."]
		test: 
			[| s t u |
			t := CTSubtreedtKeyedTree key: 1.
			t addKeys: #(2 3 4).
			u := t copy.
			s := u removeKeys: #(2 3).
			Array with: s with: t with: u]
		expectResult: '#(#(2 3) 
1\
. . .	2
. . .	3
. . .	4 
1\
. . .	4)'
]

{ #category : #removing }
SKTreeLWTest >> testRemovePath [

	self
		should: 
			[| t |
			t := CTSubtreedtKeyedTree key: 1.
			t addPath: #(2 3 ).
			t removePath: #(2 3 4 )]
		raise: TreeLWBadPath
		description: 'Cannot remove a path you do not have'.		
	self
		comment: ['Here''s how to remove a node specified by a path from a tree.']
		test: 
			[| s t u |
			t := CTSubtreedtKeyedTree key: 1 subTrees: Array.
			t addPath: #(2 3 ); addPath: #(3 4 ).
			u := t copy.
			s := u removePath: #(2 3 ).
			Array with: s with: t with: u]
		expectResult: '#(#(2 3) 
1\
. . .	2\
. . .	. . .	3
. . .	3\
. . .	. . .	4 
1\
. . .	2\
. . .	3\
. . .	. . .	4)'
]

{ #category : #removing }
SKTreeLWTest >> testRemovePathIfAbsent [
	"Already tested by the <testRemovePath> method."
]

{ #category : #'instance creation' }
SKTreeLWTest >> testRootFromPath [

	self
		should: [ CTSubtreedtKeyedTree rootFromPath: #() ]
		raise: Error
		description: 'Path cannot be empty.'.		
	self
		comment: [ 'May create a whole path at once and return its root node.' ]
		test: [CTSubtreedtKeyedTree rootFromPath: 'abc']
		expectResult: '
$a\
. . .	$b\
. . .	. . .	$c'
]

{ #category : #'accessing misc' }
SKTreeLWTest >> testRootlessPathKeys [
	self
		comment: [ 'May access the keys along a rootless path.' ]
		test: 
			[| t |
			t := CTKeyedParentedTree leafFromPath: #(1 2 3 ).
			t rootlessPathKeys]
		expectResult: '#(2 3)'
]

{ #category : #'printing misc' }
SKTreeLWTest >> testRootlessPathString [

	self
		comment: [ 'String describing path to a node, not including root.' ]
		test: [(CTKeyedParentedTree leafFromPath: #(1 2 3 4)) rootlessPathString]
		expectResult: '2\3\4'.
	self
		comment: [ 'Same thing, except the tree does not maintain a superTree pointer.' ]
		test: [(CTSubtreedtKeyedTree leafFromPath: #(1 2 3 4)) rootlessPathString]
		expectResult: ''
]

{ #category : #'printing misc' }
SKTreeLWTest >> testStringFromPathKeys [

	self
		comment: [ 'A string describing a path derived from its keys' ]
		test: [CTKeyedValuedTree basicNew stringFromPathKeys: #(1 2 3)]
		expectResult: '1\2\3'
]

{ #category : #'printing misc' }
SKTreeLWTest >> testStringFromPathKeysSeparator [

	self
		comment: [ 'Using an arbitrary separator here.' ]
		test: [CTKeyedValuedTree basicNew stringFromPathKeys: #(1 2 3) separator: $|]
		expectResult: '1|2|3'
]

{ #category : #'printing misc' }
SKTreeLWTest >> testStringFromPathNodes [
	self
		comment: [' In the first tree the last node is a leaf; in the second it is a branch.' ]
		test: 
			[| t u v |
			t := CTKeyedValuedTree key: 1.
			u := CTKeyedValuedTree key: 2.
			v := CTKeyedValuedTree key: 3.
			t add: u.
			u add: v.
			(t stringFromPathNodes: (Array with: t with: u with: v)) ,
			String crLW ,
			(t stringFromPathNodes: (Array with: t with: u with: v copy makeBranch))]
		expectResult: '1\2\3
1\2\3\'
]

{ #category : #'private validating' }
SKTreeLWTest >> testValidateSubTreesClass [

	self
		should: [CTSubtreedtKeyedTree new validateSubTreesClass: Dictionary]
		raise: TreeLWBadSubTrees
		description: 'This class is not valid.'.		

	(Array
		with: OrderedCollection
		with: Array
		with: Set
		with: SortedCollection)
		do: [:cl | self
				comment: [ 'These classes are valid.' ]
				test: [(CTSubtreedtKeyedTree new) validateSubTreesClass: cl; yourself]
				expectResult: '
node']
]
