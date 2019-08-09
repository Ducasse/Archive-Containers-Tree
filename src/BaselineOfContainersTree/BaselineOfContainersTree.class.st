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
			spec package: 'Containers-BinarySearchTree'.
			spec package: 'Containers-NewTrees'.
			spec package: 'Containers-BinarySearchTree-Tests' with: [ spec requires: 'Containers-BinarySearchTree' ].
			spec package: 'Containers-NewTrees-Tests' with: [ spec requires: 'Containers-NewTrees' ].
		]
]
