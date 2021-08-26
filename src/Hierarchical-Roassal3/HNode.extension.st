Extension { #name : #HNode }

{ #category : #'*Hierarchical-Roassal3' }
HNode >> open [
	^ HSimpleVisualizationBuilder new
		rootNode: self;
		build;
		in: [:b | b canvas openWithTitle: 'Hierarchycal Visualizations']
]
