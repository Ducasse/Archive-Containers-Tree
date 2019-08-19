Class {
	#name : #CTAbstractTreeNode,
	#superclass : #Object,
	#category : #'Containers-NewTrees'
}

{ #category : #'adding/removing' }
CTAbstractTreeNode >> addNode: arg1 [ 
	^ self subclassResponsibility
]

{ #category : #operations }
CTAbstractTreeNode >> depth [
	
	self subclassResponsibility 
]

{ #category : #traversing }
CTAbstractTreeNode >> findBreadthFirst: arg1 [ 
	^ self subclassResponsibility
]

{ #category : #traversing }
CTAbstractTreeNode >> findDeepFirst: arg1 [ 
	^ self subclassResponsibility
]

{ #category : #traversing }
CTAbstractTreeNode >> inOrderDo: arg1 [ 
	^ self subclassResponsibility
]

{ #category : #accessing }
CTAbstractTreeNode >> isLeaf [
	^ self subclassResponsibility
]

{ #category : #traversing }
CTAbstractTreeNode >> postOrderDo: arg1 [ 
	^ self subclassResponsibility
]

{ #category : #traversing }
CTAbstractTreeNode >> preOrderDo: arg1 [ 
	^ self subclassResponsibility
]

{ #category : #'adding/removing' }
CTAbstractTreeNode >> remove: arg1 [ 
	^ self subclassResponsibility
]

{ #category : #operations }
CTAbstractTreeNode >> sizeOfTree [
	^ self subclassResponsibility
]
