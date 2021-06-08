Extension { #name : #HModel }

{ #category : #'*Hierarchical-Spec' }
HModel >> icon [
	^ RSBitmap new
		form: (self iconNamed: self iconName);
		yourself.
]

{ #category : #'*Hierarchical-Spec' }
HModel >> iconName [
	^ self subclassResponsibility
]
