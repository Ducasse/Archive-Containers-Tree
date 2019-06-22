"
This concrete class adds the 'value' variable to its superclass as explained in TreeLW. The 'SKPV' in the name comes from the 's' in subTrees, the 'k' in key, the 'p' in superTree and the 'v' in value.
"
Class {
	#name : #CTKeyedValuedTree,
	#superclass : #CTKeyedParentedTree,
	#instVars : [
		'value'
	],
	#category : #'Trees-Main'
}

{ #category : #examples }
CTKeyedValuedTree class >> readMe [
	
	"TreeLW contains examples for this class."
]

{ #category : #'private accessing' }
CTKeyedValuedTree >> basicValue [
	
	"Return the contents of the value variable. Do not redefine in subclasses."

	

	^value
]

{ #category : #'private accessing' }
CTKeyedValuedTree >> basicValue: anObject [ 
	
	"Set the value variable to anObject and return the receiver. Do not redefine in 
	
	subclasses."

	

	value := anObject
]
