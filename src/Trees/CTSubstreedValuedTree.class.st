"
This concrete class adds the 'value' variable to its superclass as explained in TreeLW. The 'SV' in the name comes from the 's' in subTrees and the 'v' in value.
"
Class {
	#name : #CTSubstreedValuedTree,
	#superclass : #CTSubtreedTree,
	#instVars : [
		'value'
	],
	#category : #'Trees-Main'
}

{ #category : #examples }
CTSubstreedValuedTree class >> readMe [
	
	"TreeLW contains examples for this class."
]

{ #category : #'private accessing' }
CTSubstreedValuedTree >> basicValue [
	"Return the contents of the value variable. Do not redefine in subclasses."


	^value
]

{ #category : #'private accessing' }
CTSubstreedValuedTree >> basicValue: anObject [
 
	"Set the value variable to anObject and return the receiver. Do not redefine in 
	subclasses."


	value := anObject
]
