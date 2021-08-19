Class {
	#name : #HHideOutgoingLinksMenuItem,
	#superclass : #HNodeMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #execution }
HHideOutgoingLinksMenuItem >> execute [
	shape model hideOutgoingLinks.
	visualization rebuildLines: shape.
]

{ #category : #accessing }
HHideOutgoingLinksMenuItem >> label [
	^ 'Hide outgoing links'
]

{ #category : #accessing }
HHideOutgoingLinksMenuItem >> order [
	^ 62
]
