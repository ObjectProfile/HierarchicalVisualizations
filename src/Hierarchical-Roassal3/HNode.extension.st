Extension { #name : #HNode }

{ #category : #'*Hierarchical-Roassal3' }
HNode >> icon [
	^ RSBitmap new
		form: (self iconNamed: self iconName);
		yourself.
]

{ #category : #'*Hierarchical-Roassal3' }
HNode >> iconName [
	^ self subclassResponsibility
]

{ #category : #'*Hierarchical-Roassal3' }
HNode >> open [
	^ HSimpleVisualizationBuilder new
		rootNode: self;
		build;
		in: [:b | b canvas openWithTitle: 'Hierarchycal Visualizations']
]
