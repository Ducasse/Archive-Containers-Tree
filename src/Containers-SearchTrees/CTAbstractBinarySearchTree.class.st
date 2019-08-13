Class {
	#name : #CTAbstractBinarySearchTree,
	#superclass : #Object,
	#category : #'Containers-SearchTrees'
}

{ #category : #accessing }
CTAbstractBinarySearchTree >> add: aData [
	^ self subclassResponsibility
]

{ #category : #accessing }
CTAbstractBinarySearchTree >> depth [
	^ self subclassResponsibility
]

{ #category : #accessing }
CTAbstractBinarySearchTree >> findBreadthFirst: aBlock [
	^ self subclassResponsibility
]

{ #category : #accessing }
CTAbstractBinarySearchTree >> findDeepFirst: aBlock [
	^ self subclassResponsibility
]

{ #category : #accessing }
CTAbstractBinarySearchTree >> findNode: aData [
	^ self subclassResponsibility
]

{ #category : #accessing }
CTAbstractBinarySearchTree >> inOrderDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #accessing }
CTAbstractBinarySearchTree >> isLeaf [
	^ self subclassResponsibility
]

{ #category : #accessing }
CTAbstractBinarySearchTree >> isNullNode [
	^ self subclassResponsibility
]

{ #category : #accessing }
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

{ #category : #accessing }
CTAbstractBinarySearchTree >> postOrderDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #accessing }
CTAbstractBinarySearchTree >> preOrderDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #accessing }
CTAbstractBinarySearchTree >> remove: aData [
	^ self subclassResponsibility
]

{ #category : #accessing }
CTAbstractBinarySearchTree >> rightmostNode: aNode [
	^ self subclassResponsibility
]

{ #category : #accessing }
CTAbstractBinarySearchTree >> sizeOfTree [
	^ self subclassResponsibility
]
