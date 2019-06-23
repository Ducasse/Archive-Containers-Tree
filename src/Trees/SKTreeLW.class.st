"
This concrete class adds the 'key' variable to its superclass as explained in TreeLW.  The 'SK' in the name comes from the 's' in subTrees and the 'k' in key. SKTreeLW adds support for

	access to a subtree based on its key or path
	comparison of two trees based on their keys
	adding and removing a subtree based on its key or path
	tests based on the key or path
	printing operations based on the path
	other key and path based operations.

A path is a sequenceable collection of keys and is analogous to a directory path in a filesystem.

Adding a key variable also enables the use of sets and sorted collections for storing subTrees. The key is used to find a tree in a set and to compare two trees in a sorted collection. Methods in the comparing protocol must be based on the key alone.
"
Class {
	#name : #SKTreeLW,
	#superclass : #STreeLW,
	#instVars : [
		'key'
	],
	#category : #'Trees-Main'
}

{ #category : #'instance creation' }
SKTreeLW class >> leafFromPath: aPath [ 
	"Same as rootFromPath: except that the last node on the path is returned."

	| root |
	
	root := self key: aPath first.
	^(root addPath: (aPath copyFrom: 2 to: aPath size)) value
]

{ #category : #examples }
SKTreeLW class >> readMe [
	"TreeLW contains examples for this class."
]

{ #category : #'instance creation' }
SKTreeLW class >> rootFromPath: aPath [ 
	"Create and return a new instance containing nodes along aPath. The path is a 
	non empty sequenceable collection of keys starting from the new root node. 
	Return the resulting root node."

	| root |

	root := self key: aPath first.
	root addPath: (aPath copyFrom: 2 to: aPath size).
	^root
]

{ #category : #comparing }
SKTreeLW >> < aTree [
 
	"Answer whether the receiver is less than aTree. By defining this selector and <=,
 
	we make it possible to use a sorted collection for the subtrees. The other
 
	traditional comparison operators are not needed for sorting but could be defined.
 
	We could get most of them for free by making TreeLW a subclass of 
	Magnitude,
	but this would be artificial, since it would only be usable by keyed trees."


	^self key < aTree key
]

{ #category : #comparing }
SKTreeLW >> <= aTree [
 
	"Answer whether the receiver is less than or equal to aTree. The motivation for
 
	defining this is explained in the < method."


	^(aTree key < self key) not
]

{ #category : #comparing }
SKTreeLW >> = aTree [
 
	"Answer whether the receiver is equal to aTree. Equality testing must
	be based on the key alone. Subclasses should not change this. See
	TreeLW>>atKey:ifAbsent for an explanation."


	^aTree isTreeLW and: [self key = aTree key]
]

{ #category : #adding }
SKTreeLW >> addKey: aKey [
	"Add a tree with the specified key to the subTrees collection and answer aKey. If
	the receiver is a leaf, coerce it to a branch before adding to it."

	self add: ((self class key: aKey) basicSubTrees: self subTrees class).
	^aKey
]

{ #category : #adding }
SKTreeLW >> addKeys: collOfKeys [
 
	"Add collOfKeys to the receiver and answer collOfKeys. See addAll: for
 
	optimization comment."


	collOfKeys do: [:aKey | self addKey: aKey].
	^collOfKeys
]

{ #category : #adding }
SKTreeLW >> addPath: aPath [
 
	"Add trees along aPath to the receiver and return (count -> last tree in path).
	In more detail:
	Starting from the receiver, traverse its nodes along aPath. The path is a
	sequenceable collection of keys exclusive of the receiver. The receiver
	may already contain the entire path. If not, extend the receiver with the new
	nodes.
	Return an association whose key is the number of nodes added to the
	receiver (possibly zero) and whose value is the last node in the path. If the
	path is empty, return (0 -> receiver).
	Note that in contrast to the other add methods, this protects against creating
	duplicate keys within each subtrees collection."


	| aTree n |

	n := 0.
	aTree := self.
	aPath do: [:aKey | aTree := aTree atKey: aKey
					ifAbsent: [n := n + 1.
						aTree add: ((self class key: aKey) basicSubTrees: self subTrees class)]].
	^n -> aTree
]

{ #category : #'accessing misc' }
SKTreeLW >> atInclusivePath: aPath [ 
	
	"Same as atInclusive:ifAbsent:, but does default error handling."

	

	^self atInclusivePath: aPath ifAbsent: [ self class badPathSignal ]
]

{ #category : #'accessing misc' }
SKTreeLW >> atInclusivePath: aPath ifAbsent: aBlock [ 

	"Return the tree at aPath starting from the receiver. This path is a sequenceable 
	
	collection of keys inclusive of the receiver and inclusive of the last node. Return 
	
	the result of evaluating aBlock if not found."

	

	^(aPath isEmpty or: [aPath first ~= self key])
		
		ifTrue: [aBlock value]
		
		ifFalse: [self atPath: (aPath copyFrom: 2 to: aPath size) ifAbsent: aBlock]
]

{ #category : #'accessing misc' }
SKTreeLW >> atKey: aKey [ 
	"Return the subTree whose key equals aKey. Raise an error 
	exception if not found."

	^self atKey: aKey ifAbsent: [self class keyNotFoundSignal ]
]

{ #category : #'accessing misc' }
SKTreeLW >> atKey: aKey ifAbsent: aBlock [ 
	
	"Return the subtree whose key equals aKey, or the result of evaluating 
	aBlock if not found. 
	
	In calling <elementMatching:ifAbsentLW:>, this method assumes that the
	equality test and hash function are based on the key alone. Subclasses
	should not relax this assumption. Each subtree must have a unique key. 
	A temporary tree is used as a probe to find the desired subtree."

	| aTree |

	aTree := self class basicNew basicKey: aKey.
	^self subTrees elementMatching: aTree ifAbsentLW: aBlock
]

{ #category : #'accessing misc' }
SKTreeLW >> atPath: aPath [ 
	"Same as atPath:ifAbsent:, but with default error handling."

	^self atPath: aPath ifAbsent: [self class badPathSignal ]
]

{ #category : #'accessing misc' }
SKTreeLW >> atPath: aPath ifAbsent: aBlock [ 
	
	"Return the tree at aPath relative to the receiver. This path is a sequenceable 
	
	collection of keys exclusive of the receiver and inclusive of the last node. 
	
	Return the result of evaluating aBlock if not found."

	

	^self
 atPath: aPath
		
		ifAbsentLeaf: aBlock
		
		ifAbsentBranch: aBlock
]

{ #category : #'accessing misc' }
SKTreeLW >> atPath: aPath ifAbsentLeaf: block1 ifAbsentBranch: block2 [ 

	"Return the tree at aPath relative to the receiver. This path is a sequenceable 
	
	collection of keys exclusive of the receiver and inclusive of the last node. If
 
	there is no node at this path, and if the last node searched was a leaf/branch,
 
	return the result of evaluating block1/ block2. If the receiver is a leaf node,
 
	return the result of evaluating block1. This method enables more informative
 
	error messages to be displayed than atPath:ifAbsent:."


	| node |


	self isLeaf
		ifTrue: [^block1 value].
	
	node := self.
	aPath do: [:aKey | node := node atKey: aKey 
									ifAbsent: [^node isLeaf
							
						ifTrue: [block1 value]
							
						ifFalse: [block2 value]]].
	^node

]

{ #category : #'private accessing' }
SKTreeLW >> basicKey [
	"Return the contents of the key variable. Do not redefine in subclasses."


	^key
]

{ #category : #'private accessing' }
SKTreeLW >> basicKey: aKey [
	"Set the key variable to anObject and return the receiver. Do not redefine in
	subclasses."

	key := aKey
]

{ #category : #'accessing misc' }
SKTreeLW >> fullPathKeys [
	"Return an array containing keys of nodes from the root to the receiver, inclusive
 
	of both. If the receiver is a root node, the array will contain the key of the
 
	receiver as its single element."


	^self fullPathNodes collectLW: [:aNode | aNode key]
]

{ #category : #'printing misc' }
SKTreeLW >> fullPathString [
	"Return a string describing the path from the root to the receiver, inclusive of
	both. If the receiver is a root node, the string will represent the key of the
	receiver only."

	^self stringFromPathKeys: self fullPathKeys
]

{ #category : #'testing misc' }
SKTreeLW >> hasSamePathAs: aTree [
 
	"Return whether the receiver has the same path from its root as aTree. If the
 
	receiver does not define a superTree, it is its own root node. A simpler
 
	implementation would be ^self fullPathNodes = aTree fullPathNodes. But that
	would be slower, especially when the answer is false."


	^self key = aTree key and: [self isRoot
			ifTrue: [aTree isRoot]

			ifFalse: [aTree isRoot not and: [self superTree hasSamePathAs: aTree superTree]]]
]

{ #category : #comparing }
SKTreeLW >> hash [
	"Answer a SmallInteger derived from to the receiver. Hashing must be based on
 
	the key alone. Subclasses should not change this. See TreeLW>>atKey:ifAbsent
	for an explanation."


	^self key hash
]

{ #category : #'printing misc' }
SKTreeLW >> immediatePathString [
	"Return a string representing the immediate path from the super tree to the
	receiver, inclusive of both. If the receiver is a root node, the string will represent
	the key of the receiver only."

	^self stringFromPathNodes: (self isRoot
			ifTrue: [Array with: self]
			ifFalse: [Array with: self superTree with: self])
]

{ #category : #'testing misc' }
SKTreeLW >> includesInclusivePath: aPath [
 
	"Answer whether the receiver includes trees along aPath, which is a
 
	sequenceable collection of keys inclusive of the receiver."


	^(self atInclusivePath: aPath ifAbsent: [nil]) notNil
]

{ #category : #'testing misc' }
SKTreeLW >> includesKey: aKey [
 
	"Return a boolean indicating whether aKey belongs to a direct subtree of the
 
	receiver."


	^self includes: (self class basicNew basicKey: aKey)
]

{ #category : #'testing misc' }
SKTreeLW >> includesPath: aPath [
 
	"Answer whether the receiver includes trees along aPath, which is a
 
	sequenceable collection of keys exclusive of the receiver."


	^(self atPath: aPath ifAbsent: [nil]) notNil
]

{ #category : #'accessing misc' }
SKTreeLW >> keys [
	"Return the keys of the subtrees."


	^self subTrees collectLW: [:tree | tree key]
]

{ #category : #removing }
SKTreeLW >> removeKey: aKey [
	"Remove a tree with the specified key from the subTrees collection and answer
	aKey. Raise an error exception if absent."

	^self removeKey: aKey ifAbsent: [self class keyNotFoundSignal ]
]

{ #category : #removing }
SKTreeLW >> removeKey: aKey ifAbsent: aBlock [
 
	"Remove a tree with the specified key from the subTrees collection. Answer aKey
 
	if it was present or the result of evaluating aBlock if it was absent."


	| tree |

	tree := self atKey: aKey ifAbsent: [^aBlock value].

	self subTrees removeLW: tree makeRoot.
	^aKey
]

{ #category : #removing }
SKTreeLW >> removeKeys: collOfKeys [
 
	"Remove trees keyed by collOfKeys from the subTrees collection and answer
 
	collOfKeys. Raise an error exception if any is absent."


	collOfKeys do: [:aKey | self removeKey: aKey].
	^collOfKeys
]

{ #category : #removing }
SKTreeLW >> removePath: aPath [
	"Remove the tree stored at aPath. Return aPath if present or the result of
	raising an error exception if absent. The path is a non empty sequenceable
	collection of keys exclusive of the receiver."

	^self removePath: aPath ifAbsent: [self class badPathSignal]
]

{ #category : #removing }
SKTreeLW >> removePath: aPath ifAbsent: aBlock [
 
	"Remove the tree stored at aPath. Return aPath if present or the result of
 
	evaluating aBlock if absent. The path is a non empty sequenceable collection of
 
	keys exclusive of the receiver."


	| size |
	(size := aPath size) > 0
		ifTrue: [ | tree |

			tree := self atPath: (aPath copyFrom: 1 to: size - 1) ifAbsent: [^aBlock value].
			tree removeKey: aPath last ifAbsent: [^aBlock value].
			^aPath]
		ifFalse: [^aBlock value]
]

{ #category : #'accessing misc' }
SKTreeLW >> rootlessPathKeys [
	"Return an array containing keys of nodes from the root to the receiver,
 
	excluding the root and including the receiver. If the receiver is a root node, the
 
	array will be empty."


	^self rootlessPathNodes collectLW: [:aNode | aNode key]
]

{ #category : #'printing misc' }
SKTreeLW >> rootlessPathString [
	"Return a string describing the path from the root to the receiver, excluding the
	root and including the receiver. If the receiver is a root node, return an empty
	string."

	^self stringFromPathKeys: self rootlessPathKeys
]

{ #category : #'printing misc' }
SKTreeLW >> stringFromPathKeys: aPath [
	"Return a string describing aPath, which is a sequenceable collection of
	keys. Contrary to stringFromPathNodes:, a final separator is not appended."

	^self stringFromPathKeys: aPath separator: self separator
]

{ #category : #'printing misc' }
SKTreeLW >> stringFromPathKeys: aPath separator: separatorChar [
 
	"Return a string describing aPath, which is a sequenceable collection of
 
	keys, using separatorChar as the separator. Contrary to
 
	stringFromPathNodes:, a final separator is not appended."


	| stream |
	stream := (String new: 64) writeStream.
	aPath do: [:aKey | 
		stream nextPutAll: (aKey simplePrintStringLW copyWithout: separatorChar).
		
		stream nextPut: separatorChar].
	stream size > 1
		ifTrue: [stream skip: -1].
	^stream contents
]

{ #category : #'printing misc' }
SKTreeLW >> stringFromPathNodes: aPath [
	"Return a string describing aPath, which is a sequenceable collection of
	nodes. If the last node is a branch, the last character will be a separator."

	| stream separator |

	stream := (String new: 64) writeStream.
	separator := self separator.
	aPath do: [:node | 
		stream nextPutAll: (node key simplePrintStringLW copyWithout: separator).
		node isBranch
			 ifTrue: [stream nextPut: separator]].
	^stream contents
]

{ #category : #'private validating' }
SKTreeLW >> validateSubTreesClass: aClass [
	"Same as superclass but less restrictive. Defining a <key> instance variable
	enables us to add Set and SortedCollection to the list of supported collections."

	(aClass == OrderedCollection or: [aClass == Array or: [aClass == Set or: [aClass == SortedCollection]]])
		ifFalse: [self class badSubTreesSignal]
]
