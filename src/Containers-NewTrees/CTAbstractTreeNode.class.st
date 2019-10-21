"
Should probably rename sizeOfTree into numberOfNode?
"
Class {
	#name : #CTAbstractTreeNode,
	#superclass : #Object,
	#category : #'Containers-NewTrees'
}

{ #category : #'adding/removing' }
CTAbstractTreeNode >> addNode: aData [
	^ self subclassResponsibility
]

{ #category : #operations }
CTAbstractTreeNode >> depth [
	
	self subclassResponsibility 
]

{ #category : #traversing }
CTAbstractTreeNode >> findBreadthFirst: aBlock [
	^ self subclassResponsibility
]

{ #category : #traversing }
CTAbstractTreeNode >> findDeepFirst: aBlock [
	^ self subclassResponsibility
]

{ #category : #traversing }
CTAbstractTreeNode >> inOrderDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #accessing }
CTAbstractTreeNode >> isLeaf [
	^ self subclassResponsibility
]

{ #category : #traversing }
CTAbstractTreeNode >> postOrderDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #traversing }
CTAbstractTreeNode >> preOrderDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #'adding/removing' }
CTAbstractTreeNode >> remove: aData [ 
	^ self subclassResponsibility
]

{ #category : #operations }
CTAbstractTreeNode >> sizeOfTree [
	"Answer the number of nodes in a tree"
	
	^ self subclassResponsibility
]
