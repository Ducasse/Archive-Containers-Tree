"
This concrete class adds the 'value' variable to its superclass as explained in TreeLW. The 'SV' in the name comes from the 's' in subTrees and the 'v' in value.
"
Class {
	#name : #SVTreeLW,
	#superclass : #STreeLW,
	#instVars : [
		'value'
	],
	#category : #'Trees-Main'
}

{ #category : #examples }
SVTreeLW class >> readMe [
	
	"TreeLW contains examples for this class."
]

{ #category : #'private accessing' }
SVTreeLW >> basicValue [
	"Return the contents of the value variable. Do not redefine in subclasses."


	^value
]

{ #category : #'private accessing' }
SVTreeLW >> basicValue: anObject [
 
	"Set the value variable to anObject and return the receiver. Do not redefine in 
	subclasses."


	value := anObject
]
