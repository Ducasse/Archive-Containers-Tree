"
This abstract class adds the 'value' variable to its superclass as explained in TreeLW. The 'V' in the name comes from the 'v' in value.
"
Class {
	#name : #VTreeLW,
	#superclass : #TreeLW,
	#instVars : [
		'value'
	],
	#category : #'Trees-Main'
}

{ #category : #examples }
VTreeLW class >> readMe [
	
	"TreeLW contains examples for this class."
]

{ #category : #'private accessing' }
VTreeLW >> basicValue [
	"Return the contents of the value variable. Do not redefine in subclasses."


	^value
]

{ #category : #'private accessing' }
VTreeLW >> basicValue: anObject [
 
	"Set the value variable to anObject and return the receiver. Do not redefine in 
	subclasses."


	value := anObject
]
