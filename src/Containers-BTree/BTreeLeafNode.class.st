Class {
	#name : #BTreeLeafNode,
	#superclass : #BTreeNode,
	#type : #variable,
	#category : #'Containers-BTree'
}

{ #category : #enumerating }
BTreeLeafNode >> childrenDo: aBlock [
	"no children"
]

{ #category : #enumerating }
BTreeLeafNode >> commonKeysWith: aNode keysAndValuesDo: aBlock flip: aBoolean [
	| index key block leaf advanceKey last |

	aNode firstKey ifNil: [^ self].

	block := aBoolean ifTrue: [[:k :v1 :v2 | aBlock value: k value: v2 value: v1]] ifFalse: [aBlock].

	index := 0.
	advanceKey :=
		[index := index + 1.
		index > self size ifTrue: [^ self].
		key := keys at: index.
		key ifNil: [^ self]].
	last := self lastKey.
	
	advanceKey value.
	[key < aNode firstKey] whileTrue: advanceKey.
		
	[leaf := aNode existingLeafForKey: key.
	leaf lastKey < key ifTrue: advanceKey ifFalse:
		[leaf keysAndValuesDo:
			[:otherKey :otherValue |
			otherKey > last ifTrue: [^ self].
			[key < otherKey] whileTrue: advanceKey.
			key = otherKey ifTrue: [block value: key value: (self at: index) value: otherValue]].
		key > leaf lastKey ifFalse: advanceKey]] repeat

]

{ #category : #accessing }
BTreeLeafNode >> depth [
	^ 1
]

{ #category : #query }
BTreeLeafNode >> existingLeafForKey: aMagnitude [
       ^ self
]

{ #category : #accessing }
BTreeLeafNode >> first [
	^ self values first
]

{ #category : #testing }
BTreeLeafNode >> isLeaf [
	^ true
]

{ #category : #accessing }
BTreeLeafNode >> keys [
	^ Array streamContents: [:s | self keysDo: [:ea | s nextPut: ea]]
]

{ #category : #accessing }
BTreeLeafNode >> last [
	^ self values last
]

{ #category : #accessing }
BTreeLeafNode >> lastKey [
	| last |
	last := nil.
	self keysDo: [:k | last := k].
	^ last
]

{ #category : #query }
BTreeLeafNode >> leafForKey: aMagnitude [
	^ self
]

{ #category : #enumerating }
BTreeLeafNode >> leavesFrom: start to: end do: aBlock [
	aBlock value: self
]

{ #category : #query }
BTreeLeafNode >> valueForKey: aMagnitude ifAbsent: errorBlock [
	| i |
	i := keys findIndexForKey: aMagnitude.
	^ (i > 0 and: [(keys at: i) = aMagnitude])
		ifTrue: [self at: i]
		ifFalse: [errorBlock value]

]

{ #category : #query }
BTreeLeafNode >> valueForKey: aMagnitude ifPresent: aBlock [
	^ aBlock value: (self valueForKey: aMagnitude ifAbsent: [^ nil])
]
