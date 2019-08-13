Class {
	#name : #CTAbstractBinarySearchTree,
	#superclass : #Object,
	#category : #'Containers-SearchTrees'
}

{ #category : #accessing }
CTAbstractBinarySearchTree >> add: arg1 [ 
	^ self subclassResponsibility
]

{ #category : #accessing }
CTAbstractBinarySearchTree >> depth [
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
CTAbstractBinarySearchTree >> leftmostNode: arg1 [ 
	^ self subclassResponsibility
]

{ #category : #accessing }
CTAbstractBinarySearchTree >> remove: arg1 [ 
	^ self subclassResponsibility
]

{ #category : #accessing }
CTAbstractBinarySearchTree >> sizeOfTree [
	^ self subclassResponsibility
]
