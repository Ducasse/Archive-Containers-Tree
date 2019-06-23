"
This abstract class adds the 'superTree' variable to its superclass. 
"
Class {
	#name : #CTSimpleParentedTree,
	#superclass : #CTTree,
	#instVars : [
		'superTree'
	],
	#category : #'Trees-Main'
}

{ #category : #examples }
CTSimpleParentedTree class >> readMe [
	
	"TreeLW contains examples for this class."
]

{ #category : #'private accessing' }
CTSimpleParentedTree >> basicSuperTree [
	"Return the contents of the superTree variable. Do not redefine in subclasses."

	^superTree
]

{ #category : #'private accessing' }
CTSimpleParentedTree >> basicSuperTree: aTree [ 
	"Set the superTree variable to aTree and return the receiver. If the argument is a 
	tree, it becomes the superTree of the receiver. If the argument is something 
	else (except nil, which is not allowed), the receiver becomes a root node. Do not 
	redefine in subclasses."

	superTree := aTree
]
