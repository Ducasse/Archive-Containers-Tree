Class {
	#name : #BinaryTreeLWTest,
	#superclass : #TreesTestCase,
	#category : #'Trees-Tests'
}

{ #category : #'private accessing' }
BinaryTreeLWTest >> testBasicSubTrees [
	self
		comment:
			'We call <subTrees>, the public interface, which ends up calling <basicSubTrees>. This is for a branch node.'
		test: [ | t1 t2 t3 |
			t1 := CTBinaryTree value: 1.
			t2 := CTBinaryTree value: 2.
			t3 := CTBinaryTree value: 3.
			t1 left: t2 right: t3.
			t1 subTrees ]
		expectResult:
			'#(
2 
3)'.
	self
		comment: 'This is for a leaf node.'
		test: [ CTBinaryTree new subTrees ]
		expectResult: '#()'
]

{ #category : #'private accessing' }
BinaryTreeLWTest >> testBasicSubTreesArgument [
	self
		should: [ CTBinaryTree new subTrees: CTBinaryTree new ]
		raise: TreeLWBadSubTrees
		description:
			'TesterTreeLW class>>subTrees: tested all error conditions except
			the one tested here, which is a seqColl with the wrong number of trees.'.
	self
		comment: 'We call <subTrees:>, the public interface, which ends up calling 
			<basicSubTrees:>. t1 is a branch node. t4 is a leaf node.'
		test: [ | t1 t2 t3 t4 |
			t1 := CTBinaryTree value: 1.
			t2 := CTBinaryTree value: 2.
			t3 := CTBinaryTree value: 3.
			t1 subTrees: (Array with: t2 with: t3).
			t4 := t1 copy.
			t4 subTrees: Array new.
			Array with: t1 with: t4 ]
		expectResult:
			'#(
1\
. . .	2
. . .	3 
1)'
]

{ #category : #'private initializing' }
BinaryTreeLWTest >> testDefaultSubTrees [
	"This gets tested implicitly whenever a tree is created in the test suite. Writing 
	an explicit tests would not be interesting."
]

{ #category : #'testing misc' }
BinaryTreeLWTest >> testIsLeaf [
	self
		comment: 'Leaf node is created with <new>.'
		test: [ CTBinaryTree new isLeaf ]
		expectResult: 'true'.
	self
		comment: 'Branch node is created with <left:right:>.'
		test: [ | t |
			t := CTBinaryTree left: CTBinaryTree new right: CTBinaryTree new.
			t isLeaf ]
		expectResult: 'false'
]

{ #category : #'accessing simple' }
BinaryTreeLWTest >> testLeft [
	self
		comment: 'Left tree of a leaf node.'
		test: [ CTBinaryTree new left ]
		expectResult: 'nil'.
	self
		comment: 'Left tree of a branch node.'
		test: [ | t |
			t := CTBinaryTree left: (CTBinaryTree value: 1) right: (CTBinaryTree value: 2).
			t left ]
		expectResult:
			'
1'
]

{ #category : #'accessing simple' }
BinaryTreeLWTest >> testLeftRight [
	"Already tested by the class instance creation method."
]

{ #category : #'accessing simple' }
BinaryTreeLWTest >> testRight [
	self
		comment: 'Right tree of a leaf node.'
		test: [ CTBinaryTree new right ]
		expectResult: 'nil'.
	self
		comment: 'Right tree of a branch node.'
		test: [ | t |
			t := CTBinaryTree left: (CTBinaryTree value: 1) right: (CTBinaryTree value: 2).
			t right ]
		expectResult:
			'
2'
]

{ #category : #'private validating' }
BinaryTreeLWTest >> testValidateSubTreesCollection [
	"This is implicitly tested by the <testBasicSubTrees> method. See its comment."
]
