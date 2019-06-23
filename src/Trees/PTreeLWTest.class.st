Class {
	#name : #PTreeLWTest,
	#superclass : #TreesTestCase,
	#category : #'Trees-Tests'
}

{ #category : #'private accessing' }
PTreeLWTest >> testBasicSuperTree [

	self
		comment: ["Look at a root node and a non root node. We use SPVTreeLW
			to be able to print values and because PTreeLW and PVTreeLW are 
			abstract classes. Printing the resulting supertrees implicitly tests the
			<basicSuperTree> method."]
		test: 
			[| t1 t2 |
			t1 := CTParentedValuedTree value: 1.
			t2 := CTParentedValuedTree value: 2.
			t1 add: t2.
			Array with: t1 superTree with: t2 superTree]
		expectResult: '#(#none 
1\
. . .	2)'
]

{ #category : #'private accessing' }
PTreeLWTest >> testBasicSuperTreeATreeArgument [
	"This method is implicitly tested by <testBasicSuperTree>."
]
