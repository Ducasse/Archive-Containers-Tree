"
This concrete class adds the 'value' variable to its superclass as explained in TreeLW. The 'SKPV' in the name comes from the 's' in subTrees, the 'k' in key, the 'p' in superTree and the 'v' in value.
"
Class {
	#name : #SKPVTreeLW,
	#superclass : #SKPTreeLW,
	#instVars : [
		'value'
	],
	#category : #'Trees-Main'
}

{ #category : #examples }
SKPVTreeLW class >> readMe [
	
	"TreeLW contains examples for this class."
]

{ #category : #'private accessing' }
SKPVTreeLW >> basicValue [
	
	"Return the contents of the value variable. Do not redefine in subclasses."

	

	^value
]

{ #category : #'private accessing' }
SKPVTreeLW >> basicValue: anObject [ 
	
	"Set the value variable to anObject and return the receiver. Do not redefine in 
	
	subclasses."

	

	value := anObject
]
