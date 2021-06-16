Extension { #name : #HNameSpace }

{ #category : #'*Hierarchical-Roassal3' }
HNameSpace >> iconName [
	^ 'pharo'
]

{ #category : #'*Hierarchical-Roassal3' }
HNameSpace >> open [
	^ SPHierarchical new
		hspace: self;
		openWithSpec.
]
