Class {
	#name : #BTreeKeys,
	#superclass : #Object,
	#category : #'Containers-BTree'
}

{ #category : #testing }
BTreeKeys >> canGrow [
	^ (self at: self size) isNil
]

{ #category : #testing }
BTreeKeys >> canShrink [
	^  (self at: self size // 2 + 1) notNil
]

{ #category : #copying }
BTreeKeys >> emptyCopy [
	^ self class new: self size
]

{ #category : #private }
BTreeKeys >> findIndexForKey: aMagnitude [
	self withIndexDo:
		[:key :i |
		(key isNil or: [key > aMagnitude]) 
			ifTrue: [^ i - 1]].
	^ self size

]

{ #category : #accessing }
BTreeKeys >> first [
	^ self at: 1
]

{ #category : #accessing }
BTreeKeys >> lastIndex [
	self withIndexDo:
		[:key :i |
		key isNil ifTrue:
			[^ i - 1]].
	^ self size

]

{ #category : #private }
BTreeKeys >> shiftLeftTo: index [
	index to: self size - 1 by: 1 do:
		[:i |
		self at: i put: (self at: i+1)].
	self at: self size put: nil.
]

{ #category : #private }
BTreeKeys >> shiftRightFrom: index [
	self size to: index+1 by: -1 do:
		[:i |
		self at: i put: (self at: i - 1)]
	
]

{ #category : #enumerating }
BTreeKeys >> withIndexDo: aBlock [
	1 to: self size do: [:i | aBlock value: (self at: i) value: i]
]
