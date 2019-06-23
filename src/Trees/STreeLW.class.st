"
This concrete class adds the 'subTrees' variable to its superclass as explained in TreeLW. The 'S' in the name comes from the 's' in subTrees. STreeLW adds support for

	

	indexed tree accessing (subTrees must be a sequenceable collection)
	
	adding and removing trees
	
	distinguishing between branches and leaves
	
	selecting trees
	converting between leaves and branches
	
	converting to a different collection class for holding subTrees.
"
Class {
	#name : #STreeLW,
	#superclass : #TreeLW,
	#instVars : [
		'subTrees'
	],
	#category : #'Trees-Main'
}

{ #category : #examples }
STreeLW class >> readMe [
	
	"TreeLW contains examples for this class."
]

{ #category : #adding }
STreeLW >> add: aTree [
	"Add aTree to the subTrees collection and answer aTree. If the receiver is a leaf,
	coerce it to a branch before adding to it."

	self validateTree: aTree.
	aTree attachTo: self makeBranch.
	^self subTrees addLW: aTree
]

{ #category : #adding }
STreeLW >> addAll: collOfTrees [
	"Add collOfTrees to the receiver and answer collOfTrees. Applications working
	with large sorted collections of keyed trees may want to optimize this method for
	speed. See SortedCollection>>addAll:."

	collOfTrees do: [:tree | self add: tree].
	^collOfTrees
]

{ #category : #'accessing misc' }
STreeLW >> atIndex: integer [
	"Return the subTree at the specified index. The subTrees collection must
	understand at:. Raise an error exception if the index is invalid."

	^self subTrees at: integer
]

{ #category : #'accessing misc' }
STreeLW >> atIndex: integer put: aTree [
	"Put aTree at the specified index in the subTrees collection and answer aTree.
	The collection must understand at: and at:put:. Raise an error exception if the
	index is invalid. Although you can send add: to a leaf, you cannot send at:put:."

	self validateTree: aTree.
	(self atIndex: integer) makeRoot.
	aTree attachTo: self.
	^self subTrees at: integer put: aTree
]

{ #category : #'private accessing' }
STreeLW >> basicSubTrees [
	"Return the contents of the subTrees variable. Do not redefine in subclasses."


	^subTrees
]

{ #category : #'private accessing' }
STreeLW >> basicSubTrees: aCollectionOrClass [
	"Set the subTrees variable to aCollectionOrClass (e.g., Array new or Array) and
	return the receiver. Do not redefine in subclasses. The basicSubTrees: method
	in the superclass further explains the argument."

	subTrees := aCollectionOrClass
]

{ #category : #converting }
STreeLW >> clip [
	"If the receiver is an empty branch, convert it to a leaf. Return the receiver.

	Implementation note: the test for isLeaf is not necessary but is included to
	boost performance for leaf nodes when this method called recursively."


	self isLeaf
	 ifFalse: [self hasSubTrees ifFalse: [self makeLeaf]]
]

{ #category : #'private initializing' }
STreeLW >> defaultSubTrees [
	"Return the default value for initializing the subTrees."


	^OrderedCollection
]

{ #category : #removing }
STreeLW >> detach [
	"Detach the receiver from its supertree, if it has one, and make it a root node.

	If it is already a root node, do nothing. Return the receiver."


	self isRoot
	 ifFalse: [self superTree remove: self]
]

{ #category : #'testing misc' }
STreeLW >> isLeaf [
	"Return a boolean indicating whether the receiver is a leaf node."


	^self basicSubTrees isBehavior
]

{ #category : #converting }
STreeLW >> makeBranch [
	"Coerce the receiver to a branch node and return it."


	self isLeaf
		 ifTrue: [self basicSubTrees: self basicSubTrees new]
]

{ #category : #converting }
STreeLW >> makeLeaf [
	"Coerce the receiver to a leaf node and return it. Any subtrees it may have had
	will be detached."


	self isBranch
		ifTrue: [self definesSuperTree 
					ifTrue: [self do: [:tree | tree makeRoot]].
		
				self basicSubTrees: self basicSubTrees class]
]

{ #category : #adding }
STreeLW >> prune [
	"Prune unproductive branches, if any, from the receiver and return it. An
	unproductive branch is one containing no leaves directly or recursively."

	self removeTreesSatisfying: [:tree | tree isProductive not]
]

{ #category : #converting }
STreeLW >> recursiveClip [
	"For the receiver and its immediate and recursive subtrees, convert empty
	branches to leaves. Return the receiver.
	
	Implementation note: we could have simply used recursiveDo:, but that defaults
	to reOrder: true, which is not needed here. We prefer to optimize performance."


	self
		recursiveDo: [:tree | tree clip]
		inclusive: true

		topDown: true
		breadthFirst: true
		reOrder: false
]

{ #category : #adding }
STreeLW >> recursivePrune [
	"Prune unproductive branches, if any, from the receiver and from its recursive
	subtrees. Return the receiver. An unproductive branch is one containing no
	leaves directly or recursively."

	self recursiveRemoveTreesSatisfying: [:tree | tree isProductive not]
]

{ #category : #adding }
STreeLW >> recursiveRemoveTreesSatisfying: aBlock [
	"Remove all direct and recursive subtrees from the receiver for which aBlock
	evaluates to true and return the receiver. If a tree gets removed, all its
	recursive subtrees do too, whether or not they evaluate to true."

	self removeTreesSatisfying: aBlock.
	self do: [:tree | tree recursiveRemoveTreesSatisfying: aBlock]
]

{ #category : #enumerating }
STreeLW >> recursiveSelect: aBlock [
 
	"Evaluate aBlock recursively (top down breadth first) on the,
	forming new collections from the subtrees for which aBlock evaluates to
	true. Return the resulting tree or return nil.
 
	
	If boolean is false, a copy of the receiver automatically becomes the root of
 
	the resulting tree without being required to pass the test. If boolean is true,
 
	the receiver is required to pass before its copy becomes the new root. If it
 
	fails the test, nil is returned as the answer.
 

	If any other tree fails the test, it and all its subtrees are excluded from the result.

	We do not define this for tree classes which lack a subTrees variable because
	they typically store a fixed number of subTrees."


	| newTree |

	newTree := self basicCopy: self species.
	self isBranch
		ifTrue: [| selectedTrees |
			selectedTrees := self subTrees select: aBlock.
			newTree fastSubTrees: (selectedTrees collectLW: [:subTree | subTree recursiveSelect: aBlock ])].
	^newTree
]

{ #category : #enumerating }
STreeLW >> recursiveSelect: aBlock inclusive: boolean [
 
	"Evaluate aBlock recursively (top down breadth first) on the,
	forming new collections from the subtrees for which aBlock evaluates to
	true. Return the resulting tree or return nil.
 
	
	If boolean is false, a copy of the receiver automatically becomes the root of
 
	the resulting tree without being required to pass the test. If boolean is true,
 
	the receiver is required to pass before its copy becomes the new root. If it
 
	fails the test, nil is returned as the answer.
 

	If any other tree fails the test, it and all its subtrees are excluded from the result.

	We do not define this for tree classes which lack a subTrees variable because
	they typically store a fixed number of subTrees."


	| newTree |

	boolean
	 ifTrue: [(aBlock value: self)
				 ifFalse: [^nil]].
	newTree := self basicCopy: self species.
	self isBranch
		ifTrue: [| selectedTrees |
			selectedTrees := self subTrees select: aBlock.
			newTree fastSubTrees: (selectedTrees collectLW: [:subTree | subTree recursiveSelect: aBlock inclusive: false])].
	^newTree
]

{ #category : #converting }
STreeLW >> recursiveSubTreesAs: collectionClass [
	"Return a recursive copy of the receiver that uses collectionClass for storing 
	its direct and recursive subtrees.
	Note that the as: message used here is sent to a collection, not to a tree."

	"Warning: Read #testRecursiveSubTreesAs comments for this method before using it"

	| newTree |

	self validateSubTreesClass: collectionClass.
	newTree := self basicCopy: self species.
	newTree fastSubTrees: (self isLeaf
			ifTrue: [collectionClass]
			ifFalse: [ (self subTrees as: collectionClass)	
							collectLW: [:tree | tree recursiveSubTreesAs: collectionClass]]).
	^newTree
]

{ #category : #adding }
STreeLW >> remove: aTree [
	"Remove aTree from the subTrees collection and answer aTree. Raise an error
	exception if absent."

	^self remove: aTree ifAbsent: [ self class treeNotFoundSignal ]
]

{ #category : #adding }
STreeLW >> remove: aTree ifAbsent: aBlock [
	"Remove aTree from the subTrees collection. Answer aTree if it was present or
	the result of evaluating aBlock if it was absent. Clients using this method must
	be satisfied with the definition of the equality test (=)"

	^self subTrees remove: aTree makeRoot ifAbsentLW: aBlock
]

{ #category : #adding }
STreeLW >> removeAll: collOfTrees [
	"Remove collOfTrees from the subTrees collection and answer collOfTrees.
	Raise an error exception if any is absent.
	
	Implementation note: we copy the collection before iterating over it just in case
	the client happened to pass the subTrees collection itself."

	collOfTrees copy do: [:tree | self remove: tree].
	^collOfTrees
]

{ #category : #adding }
STreeLW >> removeTreesSatisfying: aBlock [
	"Remove all direct subtrees from the receiver for which aBlock evaluates to true
	and return the receiver."

	self subTrees copy do: [:tree | (aBlock value: tree)
			ifTrue: [self subTrees removeLW: tree makeRoot]]
]

{ #category : #enumerating }
STreeLW >> select: aBlock [
 
	"Return a recursive copy of the receiver whose direct subtrees are those for
 
	which aBlock evaluates to true. If the receiver is a leaf node, return a recursive
 
	copy of it.

	We do not define this for tree classes which lack a subTrees variable because
	they typically store a fixed number of subTrees."


	| newTree |


	newTree := self recursiveCopy.
	self isBranch
	 ifTrue: [newTree basicSubTrees: (newTree subTrees select: aBlock)].
	^newTree
]

{ #category : #'accessing simple' }
STreeLW >> subTrees [
	"Return the subtrees, reporting an empty collection for a leaf node."


	^self isLeaf
		ifTrue: [self basicSubTrees new]

		ifFalse: [self basicSubTrees]
]

{ #category : #converting }
STreeLW >> subTreesAs: collectionClass [
	"Return a recursive copy of the receiver that uses collectionClass for storing
	its direct subtrees.
	
	Note that the as: message used here is sent to a collection, not to a tree."


	| newTree |

	self validateSubTreesClass: collectionClass.
	newTree := self recursiveCopy.
	newTree basicSubTrees: (self isLeaf
			ifTrue: [collectionClass]
			ifFalse: [newTree subTrees as: collectionClass]).
	^newTree
]

{ #category : #'private validating' }
STreeLW >> validateSubTrees: aCollectionOrClass [
 
	"Raise an exception if aCollectionOrClass cannot be used for the subTrees
 
	collection of the receiver. A collection instance is used for branch nodes and
	a collection class for leaf nodes."

	aCollectionOrClass isBehavior
		ifTrue: [self validateSubTreesClass: aCollectionOrClass]
		ifFalse: [self validateSubTreesCollection: aCollectionOrClass]
]
