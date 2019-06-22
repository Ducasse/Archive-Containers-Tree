"
This abstract class adds the 'value' variable to its superclass. 
"
Class {
	#name : #CTSimpleParentedValuedTree,
	#superclass : #CTSimpleParentedTree,
	#instVars : [
		'value'
	],
	#category : #'Trees-Main'
}

{ #category : #examples }
CTSimpleParentedValuedTree class >> readMe [
	
	"TreeLW contains examples for this class."
]

{ #category : #'private accessing' }
CTSimpleParentedValuedTree >> basicValue [
	"Return the contents of the value variable. Do not redefine in subclasses."

	^value
]

{ #category : #'private accessing' }
CTSimpleParentedValuedTree >> basicValue: anObject [ 
	"Set the value variable to anObject and return the receiver. Do not redefine in 
	subclasses."

	value := anObject
]
