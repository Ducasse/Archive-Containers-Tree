"
This concrete class adds the 'value' variable to its superclass as explained in TreeLW. The 'SKV' in the name comes from the 's' in subTrees, the 'k' in key and the 'v' in value.
"
Class {
	#name : #CTUnparentedValuedTree,
	#superclass : #CTSubtreedtKeyedTree,
	#instVars : [
		'value'
	],
	#category : #'Trees-Main'
}

{ #category : #examples }
CTUnparentedValuedTree class >> readMe [
	"TreeLW contains examples for this class."
]

{ #category : #'private accessing' }
CTUnparentedValuedTree >> basicValue [
	"Return the contents of the value variable. Do not redefine in subclasses."


	^value
]

{ #category : #'private accessing' }
CTUnparentedValuedTree >> basicValue: anObject [
 
	"Set the value variable to anObject and return the receiver. Do not redefine in
 
	subclasses."


	value := anObject
]
