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
