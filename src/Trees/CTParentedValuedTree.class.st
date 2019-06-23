"
This concrete class adds the 'value' variable to its superclass as explained in TreeLW. The 'SPV' in the name comes from the 's' in subTrees, the 'p' in superTree and the 'v' in value.
"
Class {
	#name : #CTParentedValuedTree,
	#superclass : #CTSubtreedParentedTree,
	#instVars : [
		'value'
	],
	#category : #'Trees-Main'
}

{ #category : #examples }
CTParentedValuedTree class >> readMe [
	
	"TreeLW contains examples for this class."
]

{ #category : #'private accessing' }
CTParentedValuedTree >> basicValue [
	"Return the contents of the value variable. Do not redefine in subclasses."


	^value
]

{ #category : #'private accessing' }
CTParentedValuedTree >> basicValue: anObject [
 
	"Set the value variable to anObject and return the receiver. Do not redefine in
 
	subclasses."


	value := anObject
]
