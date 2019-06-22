Extension { #name : #PositionableStream }

{ #category : #'*Trees' }
PositionableStream >> contentsSpecies [

	^collection species
]

{ #category : #'*Trees' }
PositionableStream >> upToAfterAnyInLW: aCollectionEtc [
	"Answer a subcollection from position to the occurrence (if any,
	not inclusive) of any object in aCollectionEtc. If not there, answer 
	everything.  Leave the receiver positioned after aCollectionEtc.
	NOTE: aCollectionEtc can be any object, such as a collection,
	that responds to the message <includes:>."

	| newStream element |
	newStream := (self contentsSpecies new: 64) writeStream.
	[self atEnd or: [aCollectionEtc includes: (element := self next)]]
		whileFalse: [newStream nextPut: element].
	^newStream contents
]
