instance creation
for: anObject
	"Return a new tree whose object is anObject and no children. 
	(a Tree is composed of an object and a set of children)."
	^ self new 
		object: anObject;
		yourself