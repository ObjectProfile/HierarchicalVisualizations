Extension { #name : #RSShape }

{ #category : #'*Hierarchical-Roassal3' }
RSShape >> removeSelectionBox [
	| key |
	key := #selectionBox.
	(self hasProperty: key) ifFalse: [ ^ self ].
	self selectionBox remove.
	self removeKey: key.
]

{ #category : #'*Hierarchical-Roassal3' }
RSShape >> selectionBox [
	^ self propertyAt: #selectionBox
]

{ #category : #'*Hierarchical-Roassal3' }
RSShape >> selectionBox: aRSBox [
	^ self propertyAt: #selectionBox put: aRSBox
]
