accessing
children: aCollection
	"Set aCollection as a collection of children of the receiver. Each child parent is the receiver."
	aCollection do: [ :child | child parent: self ].
	children := aCollection