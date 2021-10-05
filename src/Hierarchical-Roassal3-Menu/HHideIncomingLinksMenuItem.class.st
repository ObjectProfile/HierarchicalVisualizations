"
this menu hide incoming links
"
Class {
	#name : #HHideIncomingLinksMenuItem,
	#superclass : #HNodeMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #execution }
HHideIncomingLinksMenuItem >> execute [
	shape model hideIncomingLinks.
	visualization rebuildLines: shape.
]

{ #category : #accessing }
HHideIncomingLinksMenuItem >> group [
	^ 3
]

{ #category : #accessing }
HHideIncomingLinksMenuItem >> label [
	^ 'Hide incoming links'
]

{ #category : #accessing }
HHideIncomingLinksMenuItem >> order [
	^ 61
]
