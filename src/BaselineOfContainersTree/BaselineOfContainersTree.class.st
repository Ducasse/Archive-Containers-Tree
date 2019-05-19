Class {
	#name : #BaselineOfContainersTree,
	#superclass : #BaselineOf,
	#category : #BaselineOfContainersTree
}

{ #category : #baselines }
BaselineOfContainersTree >> baseline: spec [
	<baseline>
	spec
		for: #pharo
		do: [
			spec package: 'Containers-SimpleTree'.
			spec package: 'Containers-Tree'.
		]
]
