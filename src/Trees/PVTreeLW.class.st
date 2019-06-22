"
This abstract class adds the 'value' variable to its superclass as explained in TreeLW. The 'PV' in the name comes from the 'p' in superTree and the 'v' in value.
"
Class {
	#name : #PVTreeLW,
	#superclass : #PTreeLW,
	#instVars : [
		'value'
	],
	#category : #'Trees-Main'
}

{ #category : #examples }
PVTreeLW class >> readMe [
	
	"TreeLW contains examples for this class."
]

{ #category : #'private accessing' }
PVTreeLW >> basicValue [
	"Return the contents of the value variable. Do not redefine in subclasses."

	^value
]

{ #category : #'private accessing' }
PVTreeLW >> basicValue: anObject [ 
	"Set the value variable to anObject and return the receiver. Do not redefine in 
	subclasses."

	value := anObject
]
