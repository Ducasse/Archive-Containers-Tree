accessing
degree
	^ self hasNoParent
		ifTrue: [ 0 ]
		ifFalse: [ 1 + self parent degree ]