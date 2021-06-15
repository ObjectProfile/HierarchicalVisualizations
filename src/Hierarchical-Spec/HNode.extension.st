Extension { #name : #HNode }

{ #category : #'*Hierarchical-Spec' }
HNode >> icon [
	^ RSBitmap new
		form: (self iconNamed: self iconName);
		yourself.
]

{ #category : #'*Hierarchical-Spec' }
HNode >> iconName [
	^ self subclassResponsibility
]

{ #category : #'*Hierarchical-Spec' }
HNode >> open [
	^ HSimpleVisualizationBuilder new
		rootNode: self;
		build;
		in: [:b | b canvas openWithTitle: 'Hierarchycal Visualizations']
]
