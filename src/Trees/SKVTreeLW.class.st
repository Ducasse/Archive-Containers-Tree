"
This concrete class adds the 'value' variable to its superclass as explained in TreeLW. The 'SKV' in the name comes from the 's' in subTrees, the 'k' in key and the 'v' in value.
"
Class {
	#name : #SKVTreeLW,
	#superclass : #SKTreeLW,
	#instVars : [
		'value'
	],
	#category : #'Trees-Main'
}

{ #category : #examples }
SKVTreeLW class >> readMe [
	"TreeLW contains examples for this class."
]

{ #category : #'private accessing' }
SKVTreeLW >> basicValue [
	"Return the contents of the value variable. Do not redefine in subclasses."


	^value
]

{ #category : #'private accessing' }
SKVTreeLW >> basicValue: anObject [
 
	"Set the value variable to anObject and return the receiver. Do not redefine in
 
	subclasses."


	value := anObject
]
