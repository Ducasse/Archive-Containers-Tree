Extension { #name : #Array }

{ #category : #'*Trees' }
Array >> addLW: newObject [ 
	"Add newObject to the end of the receiver and return newObject. Although the 
	class comments for Collection and ArrayedCollection prohibit this, there is no 
	reason in principle for the prohibition. The programmer should be able to make 
	the following choice: 
	
	Array				adding is slow	uses less memory 
	OrderedCollection	adding is fast	uses more memory 
	
	By offering this choice, we extend the polymorphic power of the adding protocol. 
	We have extended the removing protocol analogously. Since these extensions 
	are unorthodox, caution is advised in using them. 
	
	Implementation note: Although would like to have used copyWith:, it is slower. 
	More seriously, it returns the species, while we must return the class."

	| size newSize newArray |
	newArray := self class new: (newSize := (size := self size) + 1).
	1 to: size do: [:i | newArray at: i put: (self at: i)].
	newArray at: newSize put: newObject.
	self become: newArray.
	^newObject
]

{ #category : #'*Trees' }
Array >> printSimplyOnLW: aStream [ 
	"Append my characters to aStream without performing any special 
	handling for embedded quotes. Also, do not place quotes before or 
	after the string."

	self printAsLiteralFormOn: aStream
]

{ #category : #'*Trees' }
Array >> remove: oldObject ifAbsentLW: anExceptionBlock [ 
	"Remove the first instance of oldObject from the receiver and return oldObject. 
	If not found, return the result of evaluating anExceptionBlock. Array>>addLW: 
	explains the rationale for implementing this method. 
	
	Implementation note: This method is optimized for speed. A more elegant
	calculation of newArray runs at less than a third the speed for small arrays: 
	newArray := ((stream := self readStream) upTo: oldObject) ,, stream upToEnd."

	| newSize newArray |
	(newSize := self size - 1) < 0 ifTrue: [^anExceptionBlock value].
	newArray := self class new: newSize.
	1 to: newSize do: 
		[:i | 
		| element |
		(element := self at: i) = oldObject
			ifTrue: 
				[i to: newSize do: [:j | newArray at: j put: (self at: j + 1)].
				self become: newArray.
				^oldObject]
			ifFalse: [newArray at: i put: element]].
	^(self at: newSize + 1) = oldObject
		ifTrue: 
			[self become: newArray.
			oldObject]
		ifFalse: [anExceptionBlock value]
]
