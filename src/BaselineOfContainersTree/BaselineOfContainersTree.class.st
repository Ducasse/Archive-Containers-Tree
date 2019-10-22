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
			spec package: 'Containers-BinarySearchTree'.
			spec package: 'Containers-NewTrees'.
			spec package: 'Containers-SearchTrees'.
			spec package: 'Containers-BinarySearchTree-Tests' with: [ spec requires: 'Containers-BinarySearchTree' ].
			spec package: 'Containers-NewTrees-Tests' with: [ spec requires: 'Containers-NewTrees' ].
			spec package: 'Containers-SearchTrees-Tests' with: [ spec requires: 'Containers-SearchTrees' ].
		
		spec
				group: 'All' with: #('Containers-BinarySearchTree' 
										'Containers-SimpleTree' 
										'Containers-NewTrees' 'Containers-NewTrees-Tests'
										'Containers-SearchTrees' 'Containers-SearchTrees-Tests')
		
		
		
		
		
		
		
		
		]
]
