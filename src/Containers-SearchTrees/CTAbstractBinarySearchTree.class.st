"
I represent common API for the CTBinarySearchTree and CTNUllBinaryTree


"
Class {
	#name : #CTAbstractBinarySearchTree,
	#superclass : #Object,
	#category : #'Containers-SearchTrees'
}

{ #category : #accessing }
CTAbstractBinarySearchTree >> depth [
	^ self subclassResponsibility
]

{ #category : #query }
CTAbstractBinarySearchTree >> findBreadthFirst: aBlock [
	^ self subclassResponsibility
]

{ #category : #query }
CTAbstractBinarySearchTree >> findDeepFirst: aBlock [
	^ self subclassResponsibility
]

{ #category : #query }
CTAbstractBinarySearchTree >> findNode: aData [
	^ self subclassResponsibility
]

{ #category : #iteration }
CTAbstractBinarySearchTree >> inOrderDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #testing }
CTAbstractBinarySearchTree >> isLeaf [
	^ self subclassResponsibility
]

{ #category : #testing }
CTAbstractBinarySearchTree >> isNullNode [
	^ self subclassResponsibility
]

{ #category : #query }
CTAbstractBinarySearchTree >> leftmostNode: aNode [
	^ self subclassResponsibility
]

{ #category : #accessing }
CTAbstractBinarySearchTree >> maximumValue [
	^ self subclassResponsibility
]

{ #category : #accessing }
CTAbstractBinarySearchTree >> minimumValue [
	^ self subclassResponsibility
]

{ #category : #iteration }
CTAbstractBinarySearchTree >> postOrderDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #iteration }
CTAbstractBinarySearchTree >> preOrderDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #'adding/removing' }
CTAbstractBinarySearchTree >> remove: aData [
	^ self subclassResponsibility
]

{ #category : #query }
CTAbstractBinarySearchTree >> rightmostNode: aNode [
	^ self subclassResponsibility
]

{ #category : #accessing }
CTAbstractBinarySearchTree >> size [
	^ self subclassResponsibility
]
