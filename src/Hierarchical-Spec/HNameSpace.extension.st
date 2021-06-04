Extension { #name : #HNameSpace }

{ #category : #'*Hierarchical-Spec' }
HNameSpace >> iconName [
	^ 'pharo'
]

{ #category : #'*Hierarchical-Spec' }
HNameSpace >> open [
	^ SPHierarchical new
		hspace: self;
		openWithSpec.
]
