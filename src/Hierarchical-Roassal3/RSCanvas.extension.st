Extension { #name : #RSCanvas }

{ #category : #'*Hierarchical-Roassal3' }
RSCanvas >> selectedShapes [
	^ self propertyAt: #selectedShapes ifAbsent: [ #() ]
]

{ #category : #'*Hierarchical-Roassal3' }
RSCanvas >> selectedShapes: aGroupOfShapes [
	self propertyAt: #selectedShapes put: aGroupOfShapes.
]
