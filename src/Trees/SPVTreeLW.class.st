"
This concrete class adds the 'value' variable to its superclass as explained in TreeLW. The 'SPV' in the name comes from the 's' in subTrees, the 'p' in superTree and the 'v' in value.
"
Class {
	#name : #SPVTreeLW,
	#superclass : #SPTreeLW,
	#instVars : [
		'value'
	],
	#category : #'Trees-Main'
}

{ #category : #examples }
SPVTreeLW class >> readMe [
	
	"TreeLW contains examples for this class."
]

{ #category : #'private accessing' }
SPVTreeLW >> basicValue [
	"Return the contents of the value variable. Do not redefine in subclasses."


	^value
]

{ #category : #'private accessing' }
SPVTreeLW >> basicValue: anObject [
 
	"Set the value variable to anObject and return the receiver. Do not redefine in
 
	subclasses."


	value := anObject
]
