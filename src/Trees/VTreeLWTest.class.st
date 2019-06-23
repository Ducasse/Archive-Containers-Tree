Class {
	#name : #VTreeLWTest,
	#superclass : #TreesTestCase,
	#category : #'Trees-Tests'
}

{ #category : #'private accessing' }
VTreeLWTest >> testBasicValue [
	self
		comment: ["We use SVTreeLW because VTreeLW is an abstract class. Testing 
			<value> implicitly tests <basicValue>."]
		test: [(CTSubstreedValuedTree value: 1) value]
		expectResult: '1'
]
