Extension { #name : #HSpace }

{ #category : #'*Hierarchical-Spec' }
HSpace >> open [
	^ SPHierarchical new
		hspace: self;
		openWithSpec.
]
