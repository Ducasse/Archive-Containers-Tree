"
Esta superclase agrupa comportamiento común para la ejecución correcta de los casos de prueba.

This superclass groups common behavior for properly execution of the test cases.
"
Class {
	#name : #TreesTestCase,
	#superclass : #TestCase,
	#category : #'Trees-Tests'
}

{ #category : #private }
TreesTestCase >> comment: ignore test: aBlock expectResult: aString [
	"Evaluate aBlock and raise an exception if the resulting normalized print string does not equal aString normalized. This method is used when testing code that is not expected to generate an error."

	| normalizedResult normalizedString |
	normalizedResult := self
		normalizeResult: aBlock value simplePrintStringLW.
	normalizedString := self normalizeResult: aString copy.
	self assert: normalizedResult = normalizedString
]

{ #category : #private }
TreesTestCase >> normalizeResult: aString [
	"Return a normalized version of aString. The normalization we perform is to convert filename separator characters to an arbitrary canonical character. We need to do this because tree paths and tree print strings contain these separators, and they are platform specific. Unix, Mac, DOS respectively use \:/. If we did not normalize, tests prepared on one platform would fail on another platform."

	^ aString replaceAnyIn: '\:/' withLW: $\
]
