Class {
	#name : #HHideOutgoingLinksMenuItem,
	#superclass : #HNodeMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #accessing }
HHideOutgoingLinksMenuItem >> label [
	^ 'Hile outgoing links'
]

{ #category : #accessing }
HHideOutgoingLinksMenuItem >> order [
	^ 62
]

{ #category : #accessing }
HHideOutgoingLinksMenuItem >> selector [
	^ #hideOutgoingLinks
]

{ #category : #accessing }
HHideOutgoingLinksMenuItem >> target [
	^ self
]
