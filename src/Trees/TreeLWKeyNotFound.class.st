Class {
	#name : #TreeLWKeyNotFound,
	#superclass : #TreeLWError,
	#category : #'Trees-Exceptions'
}

{ #category : #accessing }
TreeLWKeyNotFound >> key [
	^ super object
]

{ #category : #accessing }
TreeLWKeyNotFound >> key: aKey [
	super object: aKey
]

{ #category : #private }
TreeLWKeyNotFound >> standardMessageText [
	"Generate a standard textual description"
	
	^ String streamContents: [ :stream |
		stream << 'key '.
		stream print: self object.
		stream << ' not found in '.
		stream print: self collection class ]
]
